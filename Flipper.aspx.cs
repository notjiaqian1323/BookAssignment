using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["BookId"] != null)
                {
                    int bookId;
                    if (int.TryParse(Request.QueryString["BookId"], out bookId))
                    {
                        LoadBookContent(bookId);
                    }
                    else
                    {
                        lblTitle.Text = "Invalid Book ID.";
                    }
                }
                else
                {
                    lblTitle.Text = "No Book Selected.";
                }
            }
        }

        private void LoadBookContent(int bookId) {
            
        }
    }
}