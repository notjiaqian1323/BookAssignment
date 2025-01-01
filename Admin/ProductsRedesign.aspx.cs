using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment.Admin
{
    public partial class ProductsRedesign : System.Web.UI.Page
    {
        private string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Database1.mdf;Integrated Security=True;MultipleActiveResultSets=True";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBooks();
            }
        }

        protected void lvBooks_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lvBooks.EditIndex = e.NewEditIndex;
            BindBooks(); // Rebind the data
        }

        protected void lvBooks_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            lblErrorMessage.Visible = false;
            lblErrorMessage.Text = string.Empty;

            // Get the controls in the current item
            try
            {
                ListViewItem item = lvBooks.Items[e.ItemIndex];
                int bookID = (int)lvBooks.DataKeys[e.ItemIndex].Value;

                string bookName = ((TextBox)item.FindControl("txtBookName")).Text.Trim();
                string bookDesc = ((TextBox)item.FindControl("txtBookDesc")).Text.Trim();
                string priceInput = ((TextBox)item.FindControl("txtPrice")).Text.Trim();
                decimal price;

                // Handle validations
                if (string.IsNullOrWhiteSpace(bookName))
                {
                    ShowErrorMessage("Book name cannot be empty.");
                    return;
                }

                if (!decimal.TryParse(priceInput, out price) || price <= 0)
                {
                    ShowErrorMessage("Price must be a valid positive number.");
                    return;
                }

                // Handle file upload
                FileUpload fuImagePath = (FileUpload)item.FindControl("fuImagePath");
                string imagePath = null;

                if (fuImagePath.HasFile)
                {

                    // Validate file type
                    string fileExtension = Path.GetExtension(fuImagePath.FileName).ToLower();
                    if (fileExtension != ".jpg" && fileExtension != ".png" && fileExtension != ".jpeg")
                    {
                        ShowErrorMessage("Only image files (.jpg, .png, .jpeg) are allowed.");
                        return;
                    }

                    // Save the file to the server
                    string folderPath = Server.MapPath("~/Images/");
                    string fileName = Path.GetFileName(fuImagePath.FileName);
                    string relativePath = "Images/" + fileName;
                    fuImagePath.SaveAs(Path.Combine(folderPath, fileName));
                    imagePath = relativePath;
                }
                else
                {
                    // Use the existing image path
                    imagePath = ((HiddenField)item.FindControl("hfImagePath")).Value;
                }

                // Update the database
                string query = "UPDATE Books SET Title = @Title, Price = @Price, Description = @Desc, ImageUrl = @ImageUrl WHERE BookId = @BookID";
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Title", bookName);
                    cmd.Parameters.AddWithValue("@Desc", bookDesc);
                    cmd.Parameters.AddWithValue("@Price", price);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                    cmd.Parameters.AddWithValue("@BookID", bookID);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lvBooks.EditIndex = -1; // Exit edit mode
                BindBooks(); // Rebind the data
            }
            catch (Exception ex)
            {
                ShowErrorMessage("An error occurred: " + ex.Message);
            }
        }

        protected void lvBooks_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            int bookID = (int)lvBooks.DataKeys[e.ItemIndex].Value;

            // Delete from the database
            string query = "DELETE FROM Books WHERE BookID = @BookID";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BookID", bookID);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindBooks(); // Rebind the data
        }

        protected void lvBooks_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            lvBooks.EditIndex = -1;
            BindBooks();
        }

        private void BindBooks()
        {
            string query = "SELECT * FROM Books";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                lvBooks.DataSource = reader;
                lvBooks.DataBind();
            }
        }

        private void ShowErrorMessage(string message)
        {
            lblErrorMessage.Text = message;
            lblErrorMessage.CssClass = "error-message"; // Ensure your CSS class is defined
            lblErrorMessage.Visible = true;
        }
    }
}