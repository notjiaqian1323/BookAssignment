using System;
using System.Collections.Generic;
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
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            try
            {
                using (var connection = new SqlConnection(connectionString))
                {
                    // Get book information from Books table
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
                            string genre = reader["Genre"].ToString();
                            string description = reader["Description"].ToString();
                            string imageUrl = reader["ImageUrl"].ToString();
                            decimal price = Convert.ToDecimal(reader["Price"]);
                            int userId;
                            if (HttpContext.Current.Session["UserId"] == null || !int.TryParse(HttpContext.Current.Session["UserId"].ToString(), out userId))
                            {
                                return "Please log in first and then add to the shopping cart.";
                            }

                            reader.Close();

                            // Check if book already exists in cart
                            string checkQuery = "SELECT COUNT(*) FROM Cart WHERE BookId = @BookId";
                            command = new SqlCommand(checkQuery, connection);
                            command.Parameters.AddWithValue("@BookId", bookId);

                            int exists = (int)command.ExecuteScalar();

                            if (exists == 0)
                            {
                                // Insert new record if book doesn't exist in cart
                                string insertQuery = @"
                                    INSERT INTO Cart (BookId, Title, Genre, Description, ImageUrl, Price, UserId) 
                                    VALUES (@BookId, @Title, @Genre, @Description, @ImageUrl, @Price, @UserId)";

                                command = new SqlCommand(insertQuery, connection);
                                command.Parameters.AddWithValue("@BookId", bookId);
                                command.Parameters.AddWithValue("@Title", title);
                                command.Parameters.AddWithValue("@Genre", genre);
                                command.Parameters.AddWithValue("@Description", description);
                                command.Parameters.AddWithValue("@ImageUrl", imageUrl);
                                command.Parameters.AddWithValue("@Price", price);
                                command.Parameters.AddWithValue("@UserId", userId); // Replace with actual user ID from session

                                command.ExecuteNonQuery();
                            }
                            else
                            {
                                message = "This book is already in your cart!";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                message = "Error: " + ex.Message;
            }

            return message;
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
