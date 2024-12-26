using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace OnlineBookStore
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeOrderSummary();
                UpdateTotal(0);
                PopulateStates();
            }
        }

        private void InitializeOrderSummary()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ImageUrl", typeof(string));
            dt.Columns.Add("Title", typeof(string));
            dt.Columns.Add("Price", typeof(decimal));


            if (Session["SelectedItems"] != null)
            {
                DataTable selectedItems = (DataTable)Session["SelectedItems"];
                foreach (DataRow row in selectedItems.Rows)
                {
                    dt.Rows.Add(row["ImageUrl"], row["Title"], row["Price"]);
                }
            }
            else
            {
                dt.Rows.Add(1, "Book 1", 100);
                dt.Rows.Add(2, "Book 2", 120);
            }

            gvOrderSummary.DataSource = dt;
            gvOrderSummary.DataBind();

            Session["OrderSummary"] = dt;
        }

        private decimal CalculateSubtotal()
        {
            DataTable dt = Session["OrderSummary"] as DataTable;
            decimal subtotal = 0;
            foreach (DataRow row in dt.Rows)
            {
                subtotal += Convert.ToDecimal(row["Price"]);
            }
            return subtotal;
        }

        private void UpdateTotal(decimal discount)
        {
            decimal subtotal = CalculateSubtotal();
            decimal total = subtotal - discount;

            lblSubtotals.Text = subtotal.ToString("F2");
            lblTotals.Text = total.ToString("F2");


            Session["Discount"] = discount;
        }


        protected void btnApplyCoupon_Click(object sender, EventArgs e)
        {
            string couponCode = txtCouponCode.Text.Trim();
            decimal discount = 0;

            if (couponCode == "SAVE10")
            {
                discount = 10;
                lblCouponCodes.Text = "The Coupon Code applied: SAVE10";
                lblCouponCodes.ForeColor = System.Drawing.Color.Green;
                Session["Discount"] = discount;
            }
            else
            {
                lblCouponCodes.Text = "Invalid Coupon Code";
                lblCouponCodes.ForeColor = System.Drawing.Color.Red;
                Session["Discount"] = 0;
            }


            UpdateTotal(discount);
        }




        protected void btnCompleteOrder_Click(object sender, EventArgs e)
        {
            if (ValidatePaymentDetails())
            {
                int userID = 123;
                List<string> bookTitles = new List<string>();
                DataTable dt = Session["OrderSummary"] as DataTable;

                foreach (DataRow row in dt.Rows)
                {
                    bookTitles.Add(row["Title"].ToString());
                }

                decimal totalPrice = decimal.Parse(lblTotals.Text);


                Response.Redirect("PaymentSuccessful.aspx");
            }
            else
            {

                System.Diagnostics.Debug.WriteLine("Redirect to PaymentSuccessful.aspx");
                lblErrorMessage.ForeColor = System.Drawing.Color.Red;
                lblErrorMessage.Text = "Payment Failed";
            }
        }


        private bool ValidatePaymentDetails()
        {
            lblErrorMessage.Text = "";
            bool isValid = true;

            if (string.IsNullOrEmpty(txtCreditCardNumber.Text) || txtCreditCardNumber.Text.Length != 16)
            {
                isValid = false;
                lblErrorMessage.Text = "Invalid Credit Card Number. Must be 16 digits.";
            }
            else if (string.IsNullOrEmpty(txtExpiry.Text) || !IsValidExpiry(txtExpiry.Text))
            {
                isValid = false;
                lblErrorMessage.Text = "Invalid Expiry Date. Use MM/YY format.";
            }
            else if (string.IsNullOrEmpty(txtCVC.Text) || txtCVC.Text.Length != 3)
            {
                isValid = false;
                lblErrorMessage.Text = "Invalid CVC. Must be 3 digits.";
            }

            return isValid;
        }

        private bool IsValidExpiry(string expiry)
        {
            DateTime result;
            return DateTime.TryParseExact(expiry, "MM/yy", null, System.Globalization.DateTimeStyles.None, out result) && result > DateTime.Now;
        }


        private void PopulateStates()
        {
            ddlState.Items.Clear();
            ddlState.Items.Add(new ListItem("-- Select State --", ""));
            ddlState.Items.Add(new ListItem("Selangor", "Selangor"));
            ddlState.Items.Add(new ListItem("Johor", "Johor"));
            ddlState.Items.Add(new ListItem("Kedah", "Kedah"));
            ddlState.Items.Add(new ListItem("Kelantan", "Kelantan"));
            ddlState.Items.Add(new ListItem("Negeri Sembilan", "Negeri Sembilan"));
            ddlState.Items.Add(new ListItem("Pahang", "Pahang"));
            ddlState.Items.Add(new ListItem("Perak", "Perak"));
            ddlState.Items.Add(new ListItem("Perlis", "Perlis"));
            ddlState.Items.Add(new ListItem("Pulau Pinang", "Pulau Pinang"));
            ddlState.Items.Add(new ListItem("Sabah", "Sabah"));
            ddlState.Items.Add(new ListItem("Sarawak", "Sarawak"));
            ddlState.Items.Add(new ListItem("Terengganu", "Terengganu"));
            ddlState.Items.Add(new ListItem("Melaka", "Melaka"));
            ddlState.Items.Add(new ListItem("Kuala Lumpur", "Kuala Lumpur"));
            ddlState.Items.Add(new ListItem("Labuan", "Labuan"));
            ddlState.Items.Add(new ListItem("Putrajaya", "Putrajaya"));
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCity.Items.Clear();
            ddlCity.Enabled = ddlState.SelectedIndex > 0;

            if (ddlCity.Enabled)
            {
                switch (ddlState.SelectedValue)
                {
                    case "Selangor":
                        ddlCity.Items.Add(new ListItem("Shah Alam"));
                        ddlCity.Items.Add(new ListItem("Petaling Jaya"));
                        ddlCity.Items.Add(new ListItem("Klang"));
                        ddlCity.Items.Add(new ListItem("Subang Jaya"));
                        ddlCity.Items.Add(new ListItem("Kajang"));
                        break;

                    case "Johor":
                        ddlCity.Items.Add(new ListItem("Johor Bahru"));
                        ddlCity.Items.Add(new ListItem("Muar"));
                        ddlCity.Items.Add(new ListItem("Batu Pahat"));
                        ddlCity.Items.Add(new ListItem("Kluang"));
                        ddlCity.Items.Add(new ListItem("Segamat"));
                        break;

                    case "Pulau Pinang":
                        ddlCity.Items.Add(new ListItem("George Town"));
                        ddlCity.Items.Add(new ListItem("Bayan Lepas"));
                        ddlCity.Items.Add(new ListItem("Bukit Mertajam"));
                        ddlCity.Items.Add(new ListItem("Nibong Tebal"));
                        break;

                    case "Kedah":
                        ddlCity.Items.Add(new ListItem("Alor Setar"));
                        ddlCity.Items.Add(new ListItem("Sungai Petani"));
                        ddlCity.Items.Add(new ListItem("Kulim"));
                        ddlCity.Items.Add(new ListItem("Langkawi"));
                        break;

                    case "Kelantan":
                        ddlCity.Items.Add(new ListItem("Kota Bharu"));
                        ddlCity.Items.Add(new ListItem("Pasir Mas"));
                        ddlCity.Items.Add(new ListItem("Tanah Merah"));
                        break;

                    case "Negeri Sembilan":
                        ddlCity.Items.Add(new ListItem("Seremban"));
                        ddlCity.Items.Add(new ListItem("Port Dickson"));
                        break;

                    case "Pahang":
                        ddlCity.Items.Add(new ListItem("Kuantan"));
                        ddlCity.Items.Add(new ListItem("Temerloh"));
                        ddlCity.Items.Add(new ListItem("Bentong"));
                        break;

                    case "Perak":
                        ddlCity.Items.Add(new ListItem("Ipoh"));
                        ddlCity.Items.Add(new ListItem("Taiping"));
                        ddlCity.Items.Add(new ListItem("Teluk Intan"));
                        ddlCity.Items.Add(new ListItem("Lumut"));
                        break;

                    case "Perlis":
                        ddlCity.Items.Add(new ListItem("Kangar"));
                        ddlCity.Items.Add(new ListItem("Arau"));
                        break;

                    case "Sabah":
                        ddlCity.Items.Add(new ListItem("Kota Kinabalu"));
                        ddlCity.Items.Add(new ListItem("Sandakan"));
                        ddlCity.Items.Add(new ListItem("Tawau"));
                        break;

                    case "Sarawak":
                        ddlCity.Items.Add(new ListItem("Kuching"));
                        ddlCity.Items.Add(new ListItem("Miri"));
                        ddlCity.Items.Add(new ListItem("Sibu"));
                        break;

                    case "Terengganu":
                        ddlCity.Items.Add(new ListItem("Kuala Terengganu"));
                        ddlCity.Items.Add(new ListItem("Kemaman"));
                        ddlCity.Items.Add(new ListItem("Dungun"));
                        break;

                    case "Melaka":
                        ddlCity.Items.Add(new ListItem("Melaka City"));
                        ddlCity.Items.Add(new ListItem("Alor Gajah"));
                        break;

                    case "Kuala Lumpur":
                        ddlCity.Items.Add(new ListItem("Kuala Lumpur"));
                        break;

                    case "Labuan":
                        ddlCity.Items.Add(new ListItem("Labuan"));
                        break;

                    case "Putrajaya":
                        ddlCity.Items.Add(new ListItem("Putrajaya"));
                        break;

                    default:
                        ddlCity.Items.Add(new ListItem("-- Select City --"));
                        break;
                }
            }
        }

        private void SaveOrderToDatabase(int userID, List<string> bookTitles, decimal totalPrice)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Database1ConnectionString"].ToString();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                foreach (var bookTitle in bookTitles)
                {
                    string query = "INSERT INTO Orders (UserID, BookTitle, TotalPrice, OrderDate) VALUES (@UserID, @BookTitle, @TotalPrice, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        cmd.Parameters.AddWithValue("@BookTitle", bookTitle);
                        cmd.Parameters.AddWithValue("@TotalPrice", totalPrice);

                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }

    }
}
