using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPurchasedBooks();
            }
        }


        private void LoadPurchasedBooks()
        {
            if (Session["SelectedItems"] != null)
            {
                DataTable selectedItems = (DataTable)Session["SelectedItems"];
                StringBuilder sb = new StringBuilder();

                foreach (DataRow row in selectedItems.Rows)
                {
                    string imageUrl = row["ImageUrl"].ToString();
                    string title = row["Title"].ToString();

                    sb.AppendFormat(@"
            <div class='box'>
                <img src='{0}' alt='{1}' />
                <div class='overlay'>
                    <h3 class='title'>{1}</h3>
                    <a href='Flipper.aspx'>Read Now</a>
                </div>
            </div>", imageUrl, title);
                }

                // Add the Discover More box at the end
                sb.Append(@"
        <div class='box'>
            <img src='Images/light-gray.jpg' alt='Discover More' />
            <div class='discover'>
                <h3><a href='Homepage.aspx' class='discover-link'>Discover more</a></h3>
            </div>
        </div>");

                // Render into a Literal Control on your page
                booksContainer.InnerHtml = sb.ToString();
            }
            else
            {
                // Handle case where no items are found in the session
                booksContainer.InnerHtml = @"
        <div class='box'>
            <img src='Images/light-gray.jpg' alt='No Books' />
            <div class='discover'>
                <h3>No Books Found</h3>
            </div>
        </div>
        <div class='box'>
            <img src='Images/light-gray.jpg' alt='Discover More' />
            <div class='discover'>
                <h3><a href='Homepage.aspx' class='discover-link'>Discover more</a></h3>
            </div>
        </div>";
            }
        }

    }
}