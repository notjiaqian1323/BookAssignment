using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace OnlineBookStore
{
    public partial class CustomerLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtCustomerEmail.Text.Trim();
                string password = txtCustomerPassword.Text.Trim();

                if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
                {
                    ShowMessage("Email and Password cannot be empty.", "alert-danger");
                    return;
                }
                if (!IsValidEmail(email))
                {
                    ShowMessage("Invalid email format.", "alert-danger");
                    return;
                }

                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString))
                {
                    string query = "SELECT Id FROM [User] WHERE LOWER(Email) = @Email AND Password = @Password AND Role = 'Customer'";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Email", email.ToLower());
                    command.Parameters.AddWithValue("@Password", HashPassword(password));

                    connection.Open();
                    object userId = command.ExecuteScalar();

                    if (userId != null)
                    {
                        Session["UserRole"] = "Customer";
                        Session["UserId"] = userId;
                        Response.Redirect("HomePage.aspx");
                    }
                    else
                    {
                        ShowMessage("Invalid email or password.", "alert-danger");
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowMessage("A database error occurred. Please try again later.", "alert-danger");
                LogError(ex);
            }
            catch (Exception ex)
            {
                ShowMessage("An unexpected error occurred. Please try again later.", "alert-danger");
                LogError(ex);
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
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                var hashedBytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        private void ShowMessage(string message, string cssClass = "alert-danger")
        {
            lblMessage.Text = message;
            lblMessage.CssClass = $"alert {cssClass}";
            lblMessage.Visible = true;
        }

        private void LogError(Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.ToString());
        }

    }
}
