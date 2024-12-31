using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment
{
    public partial class WebUserControl1 : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user session exists
                if (Session["UserId"] != null)
                {
                    // Update label texts for logged-in user
                    lblloginSignup.Visible = false; // Hide Login / SignUp label
                    lblMyAccount.Text = "Log Out"; // Change My Account to Log Out
                    UpdateCartDisplay();
                }
                else
                {
                    // Default state for non-logged-in user
                    lblloginSignup.Visible = true;
                    lblMyAccount.Text = "My Account";
                }
            }
        }

        protected void SearchButton_Click(object sender, ImageClickEventArgs e)
        {
                string searchQuery = txtSearchBox.Text.Trim();
                Response.Redirect($"search.aspx?query={Server.UrlEncode(searchQuery)}");
        }

        protected void CartButton_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }

        protected void ProfileButton_Click(object sender, EventArgs e)
        {
            // If session exists, log the user out
            if (Session["user"] != null)
            {
                // Clear the session
                Session.Abandon();

                // Redirect to homepage or login page after logout
                Response.Redirect("SelectRole.aspx");
            }
            else
            {
                // Redirect to Login/SignUp page if no session exists
                Response.Redirect("SelectRole.aspx");
            }
        }

        private void UpdateCartDisplay()
        {
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = @"SELECT ISNULL(SUM(Price), 0) AS TotalPrice, COUNT(*) AS ItemCount 
                                     FROM Cart 
                                     WHERE UserID = @UserID";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            conn.Open();

                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    decimal totalPrice = Convert.ToDecimal(reader["TotalPrice"]);
                                    int itemCount = Convert.ToInt32(reader["ItemCount"]);

                                    // Update the cart labels dynamically
                                    CartPrice.InnerText = $"RM{totalPrice:F2}";
                                    CartQty.InnerText = $"({itemCount})";
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log the error
                    Console.WriteLine(ex.Message);
                }
            }
            else
            {
                // If user is not logged in, show default values
                CartPrice.InnerText = "RM0.00";
                CartQty.InnerText = "(0)";
            }
        }

        [System.Web.Services.WebMethod]
        public static object GetCartSummary()
        {
            if (System.Web.HttpContext.Current.Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(System.Web.HttpContext.Current.Session["UserId"]);
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = @"SELECT ISNULL(SUM(Price), 0) AS TotalPrice, COUNT(*) AS ItemCount 
                                 FROM Cart 
                                 WHERE UserID = @UserID";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            conn.Open();

                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    return new
                                    {
                                        totalPrice = Convert.ToDecimal(reader["TotalPrice"]).ToString("F2"),
                                        itemCount = Convert.ToInt32(reader["ItemCount"])
                                    };
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    return new { error = ex.Message };
                }
            }

            return new { totalPrice = "0.00", itemCount = 0 };
        }

    }
}