using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace OnlineBookStore
{
    public partial class ChangePassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("CustomerLogin.aspx");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string currentPassword = txtCurrentPassword.Text;
            string newPassword = txtNewPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (string.IsNullOrWhiteSpace(currentPassword) || string.IsNullOrWhiteSpace(newPassword) || string.IsNullOrWhiteSpace(confirmPassword))
            {
                lblPasswordMessage.Text = "All fields are required.";
                return;
            }

            if (newPassword != confirmPassword)
            {
                lblPasswordMessage.Text = "New password and confirmation do not match.";
                return;
            }

            // Password validation: check length, letters, and digits
            if (!IsValidPassword(newPassword))
            {
                lblPasswordMessage.Text = "Password must be at least 6 characters long and contain at least 1 letter and 1 digit.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString))
            {
                conn.Open();

                // Check if current password matches the stored password
                string query = "SELECT Password FROM Users WHERE Id = @UserId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    string storedPassword = cmd.ExecuteScalar()?.ToString();

                    if (storedPassword != HashPassword(currentPassword))
                    {
                        lblPasswordMessage.Text = "Current password is incorrect.";
                        return;
                    }
                }

                // Update the password in the database
                query = "UPDATE Users SET Password = @NewPassword, ModifiedOn = GETDATE() WHERE Id = @UserId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@NewPassword", HashPassword(newPassword));
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    lblPasswordMessage.Text = rowsAffected > 0 ? "Password changed successfully." : "Failed to change password.";
                }
            }
        }

        private bool IsValidPassword(string password)
        {
            // Check if the password is at least 6 characters long and contains at least 1 letter and 1 digit
            return password.Length >= 6 && password.Any(char.IsLetter) && password.Any(char.IsDigit);
        }


        private string HashPassword(string password)
        {
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                var hashedBytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }
    }
}
