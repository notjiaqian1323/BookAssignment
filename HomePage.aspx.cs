using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace BookAssignment
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBooksByGenre("Fantasy", rptBookFantasy);
                LoadBooksByGenre("Mystery", rptBookMystery);
                LoadBooksByGenre("Romance", rptBookRomance);
                LoadBooksByGenre("Science Fiction", rptBookScience);
                LoadBooksByGenre("Comedy", rptBookComedy);
            }
        }

        private void LoadBooksByGenre(string genre, Repeater repeater)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT Title, ImageUrl, Price
                FROM Books
                WHERE Genre = @Genre
                ORDER BY Title";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Genre", genre);
                    conn.Open();

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        repeater.DataSource = dt;
                        repeater.DataBind();
                    }
                }
            }
        }
    }
}