using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment
{
    public partial class WebUserControl1 : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user session exists
            if (Session["UserId"] != null)
            {
                // Update label texts for logged-in user
                lblloginSignup.Visible = false; // Hide Login / SignUp label
                lblMyAccount.Text = "Log Out"; // Change My Account to Log Out
            }
            else
            {
                // Default state for non-logged-in user
                lblloginSignup.Visible = true;
                lblMyAccount.Text = "My Account";
            }
        }

        protected void SearchButton_Click(object sender, ImageClickEventArgs e)
        {
                string searchQuery = txtSearchBox.Text.Trim();
                Response.Redirect($"search.aspx?query={Server.UrlEncode(searchQuery)}");
        }

        protected void CartButton_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }

        protected void ProfileButton_Click(object sender, EventArgs e)
        {
            // If session exists, log the user out
            if (Session["user"] != null)
            {
                // Clear the session
                Session.Abandon();

                // Redirect to homepage or login page after logout
                Response.Redirect("SelectRole.aspx");
            }
            else
            {
                // Redirect to Login/SignUp page if no session exists
                Response.Redirect("SelectRole.aspx");
            }
        }
    }
}