using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;
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
            }
        }

        protected void ddlGenres_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedGenre = ddlGenres.SelectedItem.Value;

            if (!string.IsNullOrEmpty(selectedGenre))
            {
                var books = GetBooksByGenre(selectedGenre);
                RenderBooks(books);
            }
        }

        private List<Book> GetBooksByGenre(string genre)
        {
            var books = new List<Book>();
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Books WHERE Genre = @Genre";
                var command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Genre", genre);

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
                bookHtml.AppendFormat("<img src='{0}' alt='{1}' />", book.ImageUrl, book.Title);
                bookHtml.AppendFormat("<h3>{0}</h3>", book.Title);
                bookHtml.AppendFormat("<p>{0}</p>", book.Description);
                bookHtml.AppendFormat("<p>Price: ${0}</p>", book.Price);
                bookHtml.AppendFormat("<button class='btn' onclick=\"AddToCart('{0}')\">Add to Cart</button>", book.BookId);
                bookHtml.Append("</div>");

                bookContainer.Controls.Add(new Literal { Text = bookHtml.ToString() });
            }
        }


        [System.Web.Services.WebMethod]
        public static void AddToCart(int bookId)
        {
            string message = "Product added to cart successfully!";
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            try
            {
                // Get the current user ID from session (replace with actual session variable or authentication system)
                // Replace this with the actual user ID from session or authentication

                using (var connection = new SqlConnection(connectionString))
                {
                string query = @"INSERT INTO CartItem (BookId, DateAdded, Status) VALUES (@BookId, @DateAdded, @Status)";

                    using (var command = new SqlCommand(query, connection))
                    {
                        // Add parameters to avoid SQL injection
                        command.Parameters.AddWithValue("@BookId", bookId);
                        command.Parameters.AddWithValue("@DateAdded", DateTime.Now);
                        command.Parameters.AddWithValue("@Status", "Pending"); // Default status is "Pending"

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                message = "Error: " + ex.Message;
            }
        }

    }

    public class Book
    {
        public int BookId { get; set; }
        public string Title { get; set; }
        public string Genre { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get ; set; }
        public decimal Price { get; set; }
    }

}
