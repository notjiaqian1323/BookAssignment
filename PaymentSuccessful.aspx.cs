using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineBookStore
{
    public partial class PaymentSuccessful : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Additional setup logic if necessary
        }

        protected void btnBackToHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx"); // Redirect to the homepage
        }
    }
}