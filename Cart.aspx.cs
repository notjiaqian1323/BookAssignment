using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineBookstore
{
    public partial class Cart : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("SelectRole.aspx?ReturnUrl=Cart.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadBooks();
                UpdateTotal(0);
            }
        }

        private void LoadBooks()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT CartID,
                   ImageUrl, 
                   Title, 
                   Price 
            FROM Cart
            WHERE UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvCart.DataSource = dt;
                    gvCart.DataBind();
                    Session["Cart"] = dt;

                    if (dt.Rows.Count > 0)
                    {
                        decimal subtotal = dt.AsEnumerable()
                            .Sum(row => Convert.ToDecimal(row["Price"]));

                        lblSubtotal.Text = subtotal.ToString("F2");
                        decimal shipping = 10;
                        lblTotal.Text = (subtotal + shipping).ToString("F2");
                    }
                    else
                    {
                        lblSubtotal.Text = "0.00";
                        lblTotal.Text = "10.00";
                    }
                }
            }
        }


        private void UpdateTotal(decimal discount)
        {
            decimal subtotal = CalculateSubtotal();
            decimal shipping = 10;
            decimal total = subtotal + shipping - discount;

            lblSubtotal.Text = subtotal.ToString("F2");
            lblShipping.Text = shipping.ToString("F2");
            lblTotal.Text = total.ToString("F2");
        }

        private decimal CalculateSubtotal()
        {
            DataTable cart = Session["Cart"] as DataTable;
            decimal subtotal = 0;

            if (cart != null)
            {
                foreach (DataRow row in cart.Rows)
                {
                    subtotal += Convert.ToDecimal(row["Price"]);
                }
            }

            return subtotal;
        }





        protected void btnCheckout_Click(object sender, EventArgs e)
        {

            DataTable selectedItems = new DataTable();
            selectedItems.Columns.Add("ImageUrl", typeof(string));
            selectedItems.Columns.Add("Title", typeof(string));
            selectedItems.Columns.Add("Price", typeof(decimal));


            foreach (GridViewRow row in gvCart.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {

                    Image imgBook = (Image)row.FindControl("imgBook");
                    string imageUrl = imgBook != null ? imgBook.ImageUrl : "";


                    string title = row.Cells[2].Text;


                    Label lblPrice = (Label)row.FindControl("lblPrice");
                    decimal price = decimal.Parse(lblPrice.Text.Replace("RM", "").Trim());


                    selectedItems.Rows.Add(imageUrl, title, price);
                }
            }


            Session["SelectedItems"] = selectedItems;


            Response.Redirect("Checkout.aspx");
        }

        protected void chkSelect_CheckedChanged(object sender, EventArgs e)
        {
            decimal subtotal = 0;

            foreach (GridViewRow row in gvCart.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                Label lblPrice = row.FindControl("lblPrice") as Label;

                if (chkSelect != null && chkSelect.Checked && lblPrice != null)
                {

                    if (decimal.TryParse(lblPrice.Text.Replace("RM", "").Trim(), out decimal price))
                    {
                        subtotal += price;
                    }
                }
            }


            lblSubtotal.Text = subtotal.ToString("F2");
            decimal shipping = 10;
            lblTotal.Text = (subtotal + shipping).ToString("F2");
        }

        protected void gvCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblPrice = e.Row.FindControl("lblPrice") as Label;
                if (lblPrice != null && decimal.TryParse(lblPrice.Text, out decimal price))
                {
                    lblPrice.Text = $"RM {price:F2}";
                }
            }
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                int cartId = Convert.ToInt32(e.CommandArgument);
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;
                int userId = Convert.ToInt32(Session["UserId"]);

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Cart WHERE CartID = @CartID AND UserId = @UserId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@CartID", cartId);
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                LoadBooks();
                UpdateTotal(0);
            }
        }

        private void RemoveFromCart(int bookId)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Cart WHERE BookId = @BookId AND UserId = @UserId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BookId", bookId);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void UpdateSelectedTotal()
        {
            DataTable selectedItems = Session["SelectedItems"] as DataTable;
            decimal subtotal = 0;

            if (selectedItems != null)
            {
                foreach (DataRow row in selectedItems.Rows)
                {
                    subtotal += Convert.ToDecimal(row["Price"]);
                }
            }

            decimal shipping = 10;
            decimal total = subtotal + shipping;

            lblSubtotal.Text = subtotal.ToString("F2");
            lblTotal.Text = total.ToString("F2");
        }

    }
}
