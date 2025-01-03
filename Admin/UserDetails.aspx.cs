using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment.Admin
{
    public partial class UserDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["UserId"] != null)
                {
                    int userId = Convert.ToInt32(Request.QueryString["UserId"]);
                    LoadUserDetails(userId);
                    LoadUserOrders(userId);
                }
            }
        }

        private void LoadUserDetails(int userId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT Name, Email, Password, Role, Gender
            FROM [User]
            WHERE Id = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblName.InnerText = reader["Name"].ToString();
                            lblEmail.InnerText = reader["Email"].ToString();
                            lblPassword.InnerText = "********"; // Mask the password
                            lblRole.InnerText = reader["Role"].ToString();
                            lblGender.InnerText = reader["Gender"]?.ToString() ?? "Not Specified";
                        }
                    }
                }
            }
        }

        private void LoadUserOrders(int userId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT o.OrderID, od.Title, o.PaymentMethod, o.OrderDate
            FROM Orders o
            JOIN OrderDetails od ON o.OrderID = od.OrderID
            WHERE o.UserID = @UserId
            ORDER BY o.OrderDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    conn.Open();

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptOrderDetails.DataSource = dt;
                        rptOrderDetails.DataBind();
                        pnlNoOrders.Visible = false;
                    }
                    else
                    {
                        pnlNoOrders.Visible = true;
                    }
                }
            }
        }


    }
}