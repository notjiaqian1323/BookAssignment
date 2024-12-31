using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineBookstore
{
    public partial class BookCatalog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bookContainer.Controls.Clear();
                // Load all books initially
                var books = GetBooksByGenre("");
                RenderBooks(books);
            }
        }

        protected void ddlGenres_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedGenre = ddlGenres.SelectedItem.Value;
            var books = GetBooksByGenre(selectedGenre);
            RenderBooks(books);
        }

        private List<Book> GetBooksByGenre(string genre)
        {
            var books = new List<Book>();
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                string query;
                SqlCommand command;

                if (string.IsNullOrEmpty(genre))
                {
                    // If no genre is selected, get all books
                    query = "SELECT * FROM Books";
                    command = new SqlCommand(query, connection);
                }
                else
                {
                    // Get books of selected genre
                    query = "SELECT * FROM Books WHERE Genre = @Genre";
                    command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Genre", genre);
                }

                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        books.Add(new Book
                        {
                            BookId = reader.GetInt32(0),
                            Title = reader.GetString(1),
                            Genre = reader.GetString(2),
                            Description = reader.GetString(3),
                            ImageUrl = reader.GetString(4),
                            Price = reader.GetDecimal(5)
                        });
                    }
                }
            }
            return books;
        }

        private void RenderBooks(List<Book> books)
        {
            bookContainer.Controls.Clear();
            foreach (var book in books)
            {
                var bookHtml = new StringBuilder();
                bookHtml.Append("<div class='book-card'>");
                bookHtml.AppendFormat("<a href='BookDetails.aspx?BookId={0}'><img src='{1}' alt='{2}' /></a>", book.BookId, book.ImageUrl, book.Title);
                bookHtml.AppendFormat("<a href='BookDetails.aspx?BookId={0}'><h3>{1}</h3></a>", book.BookId, book.Title);
                bookHtml.AppendFormat("<p>{0}</p>", book.Description);
                bookHtml.AppendFormat("<p>Price: RM {0:F2}</p>", book.Price);
                bookHtml.AppendFormat("<button type='button' class='btn' onclick='addToCart({0}); return false;'>Add to Cart</button>", book.BookId);
                bookHtml.Append("</div>");

                bookContainer.Controls.Add(new Literal { Text = bookHtml.ToString() });
            }
        }


        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        public static string AddToCart(int bookId)
        {
            string message = "Product added to cart successfully!";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            try
            {
                if (HttpContext.Current.Session["UserId"] == null)
                {
                    return "<i class=\"fa-solid fa-circle-xmark\"></i> Please log in first to add to the shopping cart.";
                }

                int userId = Convert.ToInt32(HttpContext.Current.Session["UserId"]);

                using (var connection = new SqlConnection(connectionString))
                {
                    string getBookQuery = @"
                SELECT Title, Genre, Description, ImageUrl, Price 
                FROM Books 
                WHERE BookId = @BookId";

                    connection.Open();
                    var command = new SqlCommand(getBookQuery, connection);
                    command.Parameters.AddWithValue("@BookId", bookId);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string title = reader["Title"].ToString();
                            string image = reader["ImageUrl"].ToString();
                            decimal price = Convert.ToDecimal(reader["Price"]);

                            // Check if book already exists in cart
                            string checkQuery = "SELECT COUNT(*) FROM Cart WHERE BookId = @BookId AND UserID = @UserId";
                            var checkCommand = new SqlCommand(checkQuery, connection);
                            checkCommand.Parameters.AddWithValue("@BookId", bookId);
                            checkCommand.Parameters.AddWithValue("@UserId", userId);

                            int exists = (int)checkCommand.ExecuteScalar();

                            if (exists == 0)
                            {
                                // Insert new record
                                string insertQuery = @"
                            INSERT INTO Cart (BookId, Title, Price, UserId, ImageUrl) 
                            VALUES (@BookId, @Title, @Price, @UserId, @ImageUrl)";

                                var insertCommand = new SqlCommand(insertQuery, connection);
                                insertCommand.Parameters.AddWithValue("@BookId", bookId);
                                insertCommand.Parameters.AddWithValue("@Title", title);
                                insertCommand.Parameters.AddWithValue("@Price", price);
                                insertCommand.Parameters.AddWithValue("@UserId", userId);
                                insertCommand.Parameters.AddWithValue("@ImageUrl", image);

                                insertCommand.ExecuteNonQuery();
                            }
                            else
                            {
                                return "<i class=\"fa-solid fa-circle-xmark\"></i> This book is already in your cart!";
                            }
                        }
                    }
                }

                // Return a message indicating refresh is required
                return "REFRESH";
            }
            catch (Exception ex)
            {
                return "<i class=\"fa-solid fa-circle-xmark\"></i>" + ex.Message;
            }
        }


        public class Book
        {
            public int BookId { get; set; }
            public string Title { get; set; }
            public string Genre { get; set; }
            public string Description { get; set; }
            public string ImageUrl { get; set; }
            public decimal Price { get; set; }
        }
    }
}
