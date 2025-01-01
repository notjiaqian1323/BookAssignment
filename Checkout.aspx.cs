using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace OnlineBookStore
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 验证用户是否登录
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCartItems();
                UpdateTotal(0);
            }
        }

        private void LoadCartItems()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT Title, Price, ImageUrl, COUNT(*) as Quantity 
                               FROM Cart 
                               WHERE UserID = @UserID 
                               GROUP BY Title, Price, ImageUrl";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    DataTable dt = new DataTable();
                    dt.Load(cmd.ExecuteReader());

                    gvOrderSummary.DataSource = dt;
                    gvOrderSummary.DataBind();
                    Session["OrderSummary"] = dt;
                }
            }
        }

        private decimal CalculateSubtotal()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT SUM(Price) FROM Cart WHERE UserID = @UserID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    object result = cmd.ExecuteScalar();
                    return result != DBNull.Value ? Convert.ToDecimal(result) : 0m;
                }
            }
        }

        private void UpdateTotal(decimal discount)
        {
            decimal subtotal = CalculateSubtotal();
            decimal total = subtotal - discount;

            lblSubtotals.Text = $"RM {subtotal:F2}";
            lblTotals.Text = $"RM {total:F2}";

            Session["Discount"] = discount;
            Session["OrderTotal"] = total;
        }

        protected void btnApplyCoupon_Click(object sender, EventArgs e)
        {
            string couponCode = txtCouponCode.Text.Trim();
            decimal discount = 0;

            if (couponCode == "SAVE10")
            {
                discount = 10;
                lblCouponCodes.Text = "SAVE10";
                lblCouponCodes.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblCouponCodes.Text = "Invalid Coupon Code";
                lblCouponCodes.ForeColor = System.Drawing.Color.Red;
            }

            UpdateTotal(discount);
        }

        protected void btnCompleteOrder_Click(object sender, EventArgs e)
        {
            if (!ValidatePaymentDetails())
            {
                return;
            }

            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                SaveOrders(userId);
                ClearUserCart(userId);
                Response.Redirect("PaymentSuccessful.aspx");
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "Error processing order. Please try again.";
                System.Diagnostics.Debug.WriteLine($"Order Error: {ex.Message}");
            }
        }

        private void SaveOrders(int userId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // 获取购物车中的所有商品
                        string cartQuery = @"SELECT BookId, Price 
                                          FROM Cart 
                                          WHERE UserID = @UserID";

                        using (SqlCommand cartCmd = new SqlCommand(cartQuery, conn, transaction))
                        {
                            cartCmd.Parameters.AddWithValue("@UserID", userId);
                            using (SqlDataReader reader = cartCmd.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    int bookId = Convert.ToInt32(reader["BookId"]);
                                    decimal price = Convert.ToDecimal(reader["Price"]);

                                    // 为每本书创建一个订单记录
                                    string orderQuery = @"INSERT INTO Orders 
                                                        (UserID, BookID, TotalPrice, PaymentMethod, OrderDate) 
                                                        VALUES 
                                                        (@UserID, @BookId, @TotalPrice, @PaymentMethod, GETDATE())";

                                    using (SqlCommand orderCmd = new SqlCommand(orderQuery, conn, transaction))
                                    {
                                        orderCmd.Parameters.AddWithValue("@UserID", userId);
                                        orderCmd.Parameters.AddWithValue("@BookId", bookId);
                                        orderCmd.Parameters.AddWithValue("@TotalPrice", price);
                                        orderCmd.Parameters.AddWithValue("@PaymentMethod", rdoCredit.Checked ? "Credit" : "Debit");

                                        orderCmd.ExecuteNonQuery();
                                    }
                                }
                            }
                        }

                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }

        private void ClearUserCart(int userId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM Cart WHERE UserID = @UserID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private bool ValidatePaymentDetails()
        {
            lblErrorMessage.Text = "";

            if (!rdoCredit.Checked && !rdoDebit.Checked)
            {
                lblErrorMessage.Text = "Please select a payment method.";
                return false;
            }

            if (rdoCredit.Checked)
            {
                return ValidateCreditCardDetails();
            }

            return ValidateDebitCardDetails();
        }

        private bool ValidateCreditCardDetails()
        {
            if (string.IsNullOrEmpty(txtCreditCardName.Text))
            {
                lblErrorMessage.Text = "Please enter the name on card.";
                return false;
            }

            if (string.IsNullOrEmpty(txtCreditCardNumber.Text) ||
                !txtCreditCardNumber.Text.All(char.IsDigit) ||
                txtCreditCardNumber.Text.Length != 16)
            {
                lblErrorMessage.Text = "Invalid Credit Card Number. Must be 16 digits.";
                return false;
            }

            if (string.IsNullOrEmpty(txtExpiry.Text) || !IsValidExpiry(txtExpiry.Text))
            {
                lblErrorMessage.Text = "Invalid Expiry Date. Use MM/YY format.";
                return false;
            }

            if (string.IsNullOrEmpty(txtCVC.Text) ||
                !txtCVC.Text.All(char.IsDigit) ||
                txtCVC.Text.Length != 3)
            {
                lblErrorMessage.Text = "Invalid CVC. Must be 3 digits.";
                return false;
            }

            return true;
        }

        private bool ValidateDebitCardDetails()
        {
            if (string.IsNullOrEmpty(txtDebitUsername.Text))
            {
                lblErrorMessage.Text = "Please enter your debit card username.";
                return false;
            }

            if (string.IsNullOrEmpty(txtDebitPassword.Text))
            {
                lblErrorMessage.Text = "Please enter your debit card password.";
                return false;
            }

            return true;
        }

        private bool IsValidExpiry(string expiry)
        {
            if (DateTime.TryParseExact(expiry, "MM/yy", null,
                System.Globalization.DateTimeStyles.None, out DateTime expiryDate))
            {
                expiryDate = expiryDate.AddMonths(1).AddDays(-1);
                return expiryDate > DateTime.Now;
            }
            return false;
        }
    }
}