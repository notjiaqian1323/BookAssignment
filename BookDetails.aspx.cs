using System;
using System.Data.SqlClient;
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
                        bookHtml.AppendFormat("<p><strong>Description:</strong> {0}</p>", reader["Description"]);
                        bookHtml.AppendFormat("<p class='price'>RM {0:F2}</p>", reader["Price"]);
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

    }
}
