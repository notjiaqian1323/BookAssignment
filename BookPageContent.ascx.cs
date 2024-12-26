using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment
{
    public partial class WebUserControl3 : System.Web.UI.UserControl
    {
        public string PageContent { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Directly render the HTML content
            litContent.Text = PageContent;
        }
    }
}