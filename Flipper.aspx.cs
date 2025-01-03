using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace BookAssignment
{
    public partial class Flipper : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string bookId = Request.QueryString["bookId"];

                if (!string.IsNullOrEmpty(bookId))
                {
                    LoadBookContent(bookId);
                }
                else
                {
                    bookContent.InnerHtml = "<p>Invalid book selection. Please return to the bookshelf.</p>";
                }
            }
        }

        private void LoadBookContent(string bookId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Title, Content FROM FlipperDetails WHERE BookID = @BookID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@BookID", bookId);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            bookTitle.InnerHtml = reader["Title"].ToString();
                            bookContent.InnerHtml = reader["Content"].ToString().Replace("\n", "<br/>");
                        }
                        else
                        {
                            bookContent.InnerHtml = "<p>Book content not found.</p>";
                        }
                    }
                }
            }
        }
    }
}
