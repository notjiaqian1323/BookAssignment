using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace OnlineBookstore
{
    public partial class BookDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string bookId = Request.QueryString["BookId"];
                if (string.IsNullOrEmpty(bookId))
                {
                    lblErrorMessage.Text = "No book selected.";
                    return;
                }

                RenderBookDetails(bookId);
            }
        }

        private void RenderBookDetails(string bookId)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Books WHERE BookId = @BookId";
                var command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@BookId", bookId);

                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        var bookHtml = new System.Text.StringBuilder();
                        bookHtml.Append("<div class='book-image'>");
                        bookHtml.AppendFormat("<img src='{0}' alt='{1}' />", reader["ImageUrl"], reader["Title"]);
                        bookHtml.Append("</div>");
                        bookHtml.Append("<div class='book-info'>");
                        bookHtml.AppendFormat("<h2>{0}</h2>", reader["Title"]);
                        bookHtml.AppendFormat("<p><strong>Genre:</strong> {0}</p>", reader["Genre"]);
                        bookHtml.AppendFormat("<p>{0}</p>", reader["Description"]);
                        bookHtml.AppendFormat("<p class='price'>Price: RM {0:F2}</p>", reader["Price"]);
                        bookHtml.AppendFormat("<button type='button' class='btn' onclick='addToCart({0});'>Add to Cart</button>", bookId);
                        bookHtml.Append("</div>");

                        bookDetailsDiv.Controls.Add(new Literal { Text = bookHtml.ToString() });
                    }
                    else
                    {
                        lblErrorMessage.Text = "Book not found.";
                    }
                }
            }
        }

        [WebMethod]
        public static string AddToCart(int bookId)
        {
            string message = "Product added to cart successfully!";
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            try
            {
                using (var connection = new SqlConnection(connectionString))
                {
                    // Check if user is logged in
                    int userId;
                    if (HttpContext.Current.Session["UserId"] == null || !int.TryParse(HttpContext.Current.Session["UserId"].ToString(), out userId))
                    {
                        return "Please log in first to add items to your cart.";
                    }

                    // Check if book is already in the cart
                    string checkQuery = "SELECT COUNT(*) FROM Cart WHERE BookId = @BookId AND UserId = @UserId";
                    var command = new SqlCommand(checkQuery, connection);
                    command.Parameters.AddWithValue("@BookId", bookId);
                    command.Parameters.AddWithValue("@UserId", userId);

                    connection.Open();
                    int exists = (int)command.ExecuteScalar();

                    if (exists == 0)
                    {
                        // Add book to cart
                        string insertQuery = @"
                            INSERT INTO Cart (BookId, Title, Genre, Description, ImageUrl, Price, UserId)
                            SELECT BookId, Title, Genre, Description, ImageUrl, Price, @UserId 
                            FROM Books WHERE BookId = @BookId";

                        command = new SqlCommand(insertQuery, connection);
                        command.Parameters.AddWithValue("@BookId", bookId);
                        command.Parameters.AddWithValue("@UserId", userId);

                        command.ExecuteNonQuery();
                    }
                    else
                    {
                        message = "This book is already in your cart.";
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
}
