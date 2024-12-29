using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace OnlineBookStore
{
    public partial class UpdateInfo : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("CustomerLogin.aspx");
                }
                else
                {
                    LoadUserProfile(); // Ensure this method is defined
                }
            }
        }

        private void LoadUserProfile()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString))
            {
                conn.Open();
                string query = "SELECT Name, Email, Gender, ProfilePicture FROM User WHERE Id = @UserId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtName.Text = reader["Name"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            rblGender.SelectedValue = reader["Gender"].ToString();

                            // Set the profile picture (use the default if no picture is set)
                            string profilePic = reader["ProfilePicture"].ToString();
                            imgProfile.Src = string.IsNullOrEmpty(profilePic) ? "Profilepic/defaultpic.png" : profilePic;
                        }
                    }
                }
            }
        }

        protected void btnUpdateInfo_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string email = txtEmail.Text;
            string name = txtName.Text;
            string gender = rblGender.SelectedValue;

            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(name))
            {
                lblMessage.Text = "Name and Email cannot be empty.";
                return;
            }

            // Check if the email already exists in the database
            if (IsEmailTaken(email, userId))
            {
                lblMessage.Text = "This Email is already used by another user.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString))
            {
                conn.Open();
                string query = "UPDATE User SET Name = @Name, Email = @Email, Gender = @Gender WHERE Id = @UserId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    lblMessage.Text = rowsAffected > 0 ? "Profile updated successfully." : "Failed to update profile.";
                }
            }
        }

        protected void btnChangeProfilePic_Click(object sender, EventArgs e)
        {
            if (fuProfilePic.HasFile)
            {
                // Save the uploaded picture to the server
                string fileName = Path.GetFileName(fuProfilePic.PostedFile.FileName);
                string filePath = Server.MapPath("~/Profilepic/") + fileName;

                fuProfilePic.SaveAs(filePath);

                // Update the profile picture path in the database
                int userId = Convert.ToInt32(Session["UserId"]);
                string profilePicPath = "~/Profilepic/" + fileName;

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString))
                {
                    conn.Open();
                    string query = "UPDATE User SET ProfilePicture = @ProfilePicture WHERE Id = @UserId";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ProfilePicture", profilePicPath);
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        lblProfilePicMessage.Text = rowsAffected > 0 ? "Profile picture updated successfully." : "Failed to update profile picture.";
                    }
                }

                // Update the image on the page
                imgProfile.Src = profilePicPath;
            }
            else
            {
                lblProfilePicMessage.Text = "Please select a file to upload.";
            }
        }

        private bool IsEmailTaken(string email, int userId)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM User WHERE Email = @Email AND Id != @UserId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    int emailCount = (int)cmd.ExecuteScalar();
                    return emailCount > 0;
                }
            }
        }
    }
}
