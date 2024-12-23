using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string searchQuery = Request.QueryString["query"] ?? string.Empty;

                // Get the book data from the database
                DataTable bookData = GetBookDataFromDatabase($"%{searchQuery}%");

                // Update the UI
                lblSearchQuery.Text = string.IsNullOrEmpty(searchQuery) ? "All Books" : searchQuery;
                lblTotalResults.Text = bookData.Rows.Count.ToString();
                lblShownResults.Text = bookData.Rows.Count.ToString();

                // Bind the book data
                BindBookDataToControl(bookData);
            }
        }

        private DataTable GetBookDataFromDatabase(string searchQuery)
        {
            DataTable bookData = new DataTable();

            // Connect to the SQL Server database and retrieve the book data
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Books WHERE Title LIKE @SearchQuery OR Genre LIKE @SearchQuery";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@SearchQuery", $"%{searchQuery}%");

                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(bookData);
            }

            return bookData;
        }

        private void BindBookDataToControl(DataTable bookData)
        {
            // If no books are returned, show a message.
            if (bookData.Rows.Count == 0)
            {
                rptBooks.Visible = false;
            }
            else
            {
                rptBooks.Visible = true;
            }

            // Bind the book data to a GridView or Repeater control
            rptBooks.DataSource = bookData;
            rptBooks.DataBind();
        }

        protected void SearchButton_Click(object sender, ImageClickEventArgs e)
        {
            // Retrieve search query from the TextBox
            string searchQuery = txtSearchBox.Text.Trim();

            // Get the book data from the database based on the search query
            DataTable bookData = GetBookDataFromDatabase(searchQuery);

            // Update the UI elements
            lblSearchQuery.Text = string.IsNullOrEmpty(searchQuery) ? "All Books" : searchQuery;
            lblTotalResults.Text = bookData.Rows.Count.ToString();
            lblShownResults.Text = bookData.Rows.Count.ToString();

            // Bind the book data to the control
            BindBookDataToControl(bookData);
        }
    }

}