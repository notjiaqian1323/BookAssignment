using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace BookAssignment.Admin
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUsers();
            }
        }

        private void BindUsers()
        {
            string query = "SELECT Id, Name, Email, Role FROM Users";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                lvUsers.DataSource = reader;
                lvUsers.DataBind();
            }
        }

        protected void lvUsers_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lvUsers.EditIndex = e.NewEditIndex;
            BindUsers();
        }

        protected void lvUsers_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            try
            {
                ListViewItem item = lvUsers.Items[e.ItemIndex];
                int userId = Convert.ToInt32(lvUsers.DataKeys[e.ItemIndex].Value);

                string name = ((TextBox)item.FindControl("txtName")).Text.Trim();
                string email = ((TextBox)item.FindControl("txtEmail")).Text.Trim();
                string roles = ((TextBox)item.FindControl("txtRoles")).Text.Trim();

                if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(roles))
                {
                    lblMessage.Text = "All fields are required.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string query = "UPDATE Users SET Name = @Name, Email = @Email, Role = @Roles WHERE Id = @Id";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Roles", roles);
                    cmd.Parameters.AddWithValue("@Id", userId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lvUsers.EditIndex = -1;
                BindUsers();
                lblMessage.Text = "User updated successfully.";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void lvUsers_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(lvUsers.DataKeys[e.ItemIndex].Value);

                string query = "DELETE FROM Users WHERE Id = @Id";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Id", userId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                BindUsers();
                lblMessage.Text = "User deleted successfully.";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }


        protected void lvUsers_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            lvUsers.EditIndex = -1;
            BindUsers();
        }




    }
}