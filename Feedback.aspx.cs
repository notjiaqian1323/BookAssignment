using System;
using System.Configuration;
using System.Data.SqlClient;

namespace OnlineBookstore
{
    public partial class Feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.Text = ""; // Clear the thank-you message on page load
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string feedback = txtFeedback.Text.Trim();
            string rating = GetSelectedRating(); // Get the selected star rating

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(feedback) || string.IsNullOrEmpty(rating))
            {
                lblMessage.Text = "All fields are required.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                // Save feedback to the database
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Feedback (Name, Email, FeedbackText, Rating, SubmittedOn) VALUES (@Name, @Email, @FeedbackText, @Rating, @SubmittedOn)";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Name", name);
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@FeedbackText", feedback);
                        command.Parameters.AddWithValue("@Rating", int.Parse(rating));
                        command.Parameters.AddWithValue("@SubmittedOn", DateTime.Now);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }

                // Display thank-you message
                lblMessage.Text = "Thank you for your feedback!";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                // Clear the form
                txtName.Text = "";
                txtEmail.Text = "";
                txtFeedback.Text = "";
                ClearRating();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred while submitting your feedback. Please try again later.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        private string GetSelectedRating()
        {
            if (star1.Checked) return "1";
            if (star2.Checked) return "2";
            if (star3.Checked) return "3";
            if (star4.Checked) return "4";
            if (star5.Checked) return "5";
            return string.Empty;
        }

        private void ClearRating()
        {
            star1.Checked = false;
            star2.Checked = false;
            star3.Checked = false;
            star4.Checked = false;
            star5.Checked = false;
        }
    }
}
