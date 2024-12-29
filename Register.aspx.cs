using System;
using System.Data.SqlClient;
using System.Configuration;

namespace OnlineBookStore
{
    public partial class Register : System.Web.UI.Page
    {
        protected void RegisterButton_Click(object sender, EventArgs e)
        {
            string fullName = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmPassword))
            {
                lblError.Text = "Please fill all fields correctly.";
                lblError.Visible = true;
                return;
            }

            if (!ValidatePassword(password))
            {
                lblError.Text = "Password must be at least 6 characters long <br> and contain at least 1 letter and 1 digit.";
                lblError.Visible = true;
                return;
            }

            if (password != confirmPassword)
            {
                lblError.Text = "Passwords do not match.";
                lblError.Visible = true;
                return;
            }

            lblError.Visible = false; // Hide error label if input is valid

            string hashedPassword = HashPassword(password);
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString))
                {
                    con.Open();
                    string query = "INSERT INTO [User] (Name, Email, Password, Role) VALUES (@Name, @Email, @Password, 'Customer')";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", fullName ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Email", email ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Password", hashedPassword ?? (object)DBNull.Value);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            Response.Redirect("CustomerLogin.aspx");
                        }
                        else
                        {
                            // Handle no rows affected
                            Response.Write("No record was inserted. Please try again.");
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627 || ex.Number == 2601) // Unique constraint violation
                {
                    lblError.Text = "This Email is already used by another user.";
                }
                else
                {
                    lblError.Text = "An error occurred. Please try again.";
                }
                lblError.Visible = true;
            }
        }

        /// <summary>
        /// Validates the password to ensure it is at least 6 characters long and contains at least 1 letter and 1 digit.
        /// </summary>
        private bool ValidatePassword(string password)
        {
            if (password.Length < 6)
                return false;

            bool hasLetter = false;
            bool hasDigit = false;

            foreach (char c in password)
            {
                if (char.IsLetter(c))
                    hasLetter = true;
                if (char.IsDigit(c))
                    hasDigit = true;

                if (hasLetter && hasDigit)
                    return true;
            }

            return false;
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
