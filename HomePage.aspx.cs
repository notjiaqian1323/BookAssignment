using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            LoadBooks();
        }

        private void LoadBooks()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Title, Price, ImageUrl FROM Books";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Pass DataTable to client-side rendering
                    rptBookFiction.DataSource = dt;
                    rptBookFiction.DataBind();
                    rptBooknFiction.DataSource = dt;
                    rptBooknFiction.DataBind();
                    rptBookPromo.DataSource = dt;
                    rptBookPromo.DataBind();
                }
            }
        }
    }
}