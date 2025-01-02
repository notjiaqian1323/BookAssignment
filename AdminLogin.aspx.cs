using System;
using System.Web.UI;

namespace OnlineBookStore
{
    using System;
    using System.Configuration;
    using System.Data.SqlClient;
    using System.Web.UI;

    public partial class AdminLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string email = txtAdminEmail.Text.Trim();
            string password = txtAdminPassword.Text.Trim();

            // Validate input
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ShowMessage("Email and Password cannot be empty.");
                return;
            }

            if (!IsValidEmail(email))
            {
                ShowMessage("Invalid email format.");
                return;
            }

            // Check credentials in the database
            if (IsValidAdmin(email, password))
            {
                // Redirect to the admin dashboard
                Response.Redirect("Admin/DashboardRedesign.aspx");
            }
            else
            {
                ShowMessage("Invalid email or password.");
            }
        }

        private bool IsValidAdmin(string email, string password)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Password FROM Users WHERE Email = @Email AND Role = @Role";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Role", "Admin");

                conn.Open();
                string storedPassword = cmd.ExecuteScalar()?.ToString();

                // Validate password (ensure password is hashed in the database for security)
                return storedPassword != null && storedPassword == HashPassword(password);
            }
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private string HashPassword(string password)
        {
            // Hash the input password to match it with the hashed password in the database
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                var hashedBytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        private void ShowMessage(string message)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Visible = true;
        }
    }

}