using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment.Admin
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadProductDetails();
            LoadOrderDetails();
        }

        private void LoadProductDetails()
        {
            // Get BookId from QueryString
            string bookId = Request.QueryString["BookId"];
            if (string.IsNullOrEmpty(bookId))
            {
                Response.Redirect("ProductsRedesign.aspx");
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT Title, Description, Genre, Author, Price, ImageUrl 
                                 FROM Books 
                                 WHERE BookId = @BookId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@BookId", bookId);
                        conn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblTitle.InnerText = reader["Title"].ToString();
                                lblDescription.InnerText = reader["Description"].ToString();
                                lblGenre.InnerText = reader["Genre"].ToString();
                                lblAuthor.InnerText = reader["Author"].ToString();
                                lblPrice.InnerText = $"RM{Convert.ToDecimal(reader["Price"]):F2}";
                                imgBook.Src = "~/" + reader["ImageUrl"].ToString();
                            }
                            else
                            {
                                // Handle if no product found
                                Response.Redirect("ProductsRedesign.aspx");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception and redirect
                Console.WriteLine(ex.Message);
                Response.Redirect("ProductsRedesign.aspx");
            }
        }

        private void LoadOrderDetails()
        {
            string bookId = Request.QueryString["BookId"];
            if (string.IsNullOrEmpty(bookId))
            {
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                    SELECT o.OrderID, o.UserID, u.Name AS UserName, o.PaymentMethod, o.OrderDate
                    FROM Orders o
                    INNER JOIN [User] u ON o.UserID = u.Id
                    WHERE o.BookID = @BookID
                    ORDER BY o.OrderDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@BookID", bookId);
                        conn.Open();

                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        rptOrderDetails.DataSource = dt;
                        rptOrderDetails.DataBind();

                        // Toggle empty orders panel visibility
                        pnlNoOrders.Visible = (dt.Rows.Count == 0);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }


    }
}