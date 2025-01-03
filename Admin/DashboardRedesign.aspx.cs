using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment.Admin
{
    public partial class DashboardRedesign : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNewUsers();
                LoadTopSellingBook();
            }
        }

        private void LoadNewUsers()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            string query = @"
            SELECT TOP 5 
                Id, 
                Name, 
                CreatedOn, 
                ISNULL(ProfilePicture, '../ProfilePic/defaultpic.png') AS ProfilePicture 
            FROM [User]
            ORDER BY CreatedOn DESC";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    rptNewUsers.DataSource = reader;
                    rptNewUsers.DataBind();
                }
            }
        }

        protected void LoadTopSellingBook()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT TOP 1 b.Title, b.ImageUrl, COUNT(od.BookId) AS OrderCount
            FROM OrderDetails od
            JOIN Books b ON od.BookId = b.BookId
            GROUP BY b.Title, b.ImageUrl
            ORDER BY OrderCount DESC";

                conn.Open();

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string title = reader["Title"].ToString();
                            string imageUrl = reader["ImageUrl"].ToString();

                            // Pass data to the client-side using hidden fields or server-side attributes
                            topSellingTitle.InnerText = title;
                            imgBox.Attributes["data-bg-url"] = imageUrl;
                        }
                        else
                        {
                            // Fallback if no book is found
                            topSellingTitle.InnerText = "No Top-Selling Book Yet!";
                            imgBox.Attributes["data-bg-url"] = "../Images/light-gray.jpg";
                        }
                    }
                }
            }
        }

        [WebMethod]
        public static string GetGenreOrderData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            // Predefine all genres with zero count
            Dictionary<string, int> genreOrders = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase)
    {
        {"Fantasy", 0},
        {"Mystery", 0},
        {"Romance", 0},
        {"Science Fiction", 0},
        {"Comedy", 0}
    };

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT b.Genre, ISNULL(COUNT(od.BookId), 0) AS OrderCount
            FROM Books b
            LEFT JOIN OrderDetails od ON b.BookId = od.BookId
            GROUP BY b.Genre";

                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string genre = reader["Genre"]?.ToString().Trim() ?? "Unknown";
                            int count = Convert.ToInt32(reader["OrderCount"]);

                            // Normalize genre and check if it exists in the dictionary
                            if (genreOrders.ContainsKey(genre))
                            {
                                genreOrders[genre] = count; // Safely update count
                            }
                            else
                            {
                                // Log or handle unexpected genres for debugging
                                Console.WriteLine($"Unexpected genre: {genre}");
                            }
                        }
                    }
                }
            }

            // Serialize the dictionary into JSON
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(genreOrders);
        }


    }
}