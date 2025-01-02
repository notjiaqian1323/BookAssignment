using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPurchasedBooks();
            }
        }


        private void LoadPurchasedBooks()
        {
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                DataTable purchasedBooks = new DataTable();

                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                SELECT b.ImageUrl, b.Title, o.BookID
                FROM OrderDetails o
                INNER JOIN Books b ON o.BookID = b.BookId
                WHERE o.UserID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        conn.Open();

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(purchasedBooks);
                        }
                    }
                }

                // Render the books dynamically
                StringBuilder sb = new StringBuilder();

                if (purchasedBooks.Rows.Count > 0)
                {
                    foreach (DataRow row in purchasedBooks.Rows)
                    {
                        string imageUrl = row["ImageUrl"].ToString();
                        string title = row["Title"].ToString();

                        sb.AppendFormat(@"
                <div class='box'>
                    <img src='{0}' alt='{1}' />
                    <div class='overlay'>
                        <h3 class='title'>{1}</h3>
                        <a href='Flipper.aspx?bookId={2}'>Read Now</a>
                    </div>
                </div>", imageUrl, title, row["BookID"]);
                    }
                }
                else
                {
                    // No books found for the user
                    sb.Append(@"
            <div class='box'>
                <img src='Images/light-gray.jpg' alt='No Books' />
                <div class='discover'>
                    <h3>No Books Found</h3>
                </div>
            </div>");
                }

                // Add the Discover More box at the end
                sb.Append(@"
        <div class='box'>
            <img src='Images/light-gray.jpg' alt='Discover More' />
            <div class='discover'>
                <h3><a href='Homepage.aspx' class='discover-link'>Discover more</a></h3>
            </div>
        </div>");

                // Render into a Literal Control on your page
                booksContainer.InnerHtml = sb.ToString();
            }
            else
            {
                // If no session, display no books found
                booksContainer.InnerHtml = @"
        <div class='box'>
            <img src='Images/light-gray.jpg' alt='No Books' />
            <div class='discover'>
                <h3>No Books Found</h3>
            </div>
        </div>
        <div class='box'>
            <img src='Images/light-gray.jpg' alt='Discover More' />
            <div class='discover'>
                <h3><a href='Homepage.aspx' class='discover-link'>Discover more</a></h3>
            </div>
        </div>";
            }
        }

    }
}