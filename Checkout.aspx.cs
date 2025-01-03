using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Linq;

namespace OnlineBookStore
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            // 获取 Session 中的已选商品
            DataTable selectedItems = Session["SelectedItems"] as DataTable;

            if (selectedItems != null && selectedItems.Rows.Count > 0)
            {
                gvOrderSummary.DataSource = selectedItems;
                gvOrderSummary.DataBind();
                Session["OrderSummary"] = selectedItems;

                // 计算并显示小计
                decimal subtotal = selectedItems.AsEnumerable()
                    .Sum(row => Convert.ToDecimal(row["Price"]));
                lblSubtotals.Text = $"RM {subtotal:F2}";
                lblTotals.Text = $"RM {subtotal:F2}"; // 初始总额等于小计
            }
            else
            {
                // 如果没有选中的商品，重定向回购物车页面
                Response.Redirect("Cart.aspx");
            }
        }

        private decimal CalculateSubtotal()
        {
            DataTable selectedItems = Session["OrderSummary"] as DataTable;
            if (selectedItems != null)
            {
                return selectedItems.AsEnumerable()
                    .Sum(row => Convert.ToDecimal(row["Price"]));
            }
            return 0m;
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
                ClearSelectedItemsFromCart(userId); // 保留这行，作为额外的清理机制
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
                        DataTable selectedItems = Session["SelectedItems"] as DataTable;
                        if (selectedItems != null && selectedItems.Rows.Count > 0)
                        {
                            decimal totalPrice = selectedItems.AsEnumerable()
                                .Sum(row => Convert.ToDecimal(row["Price"]));

                            string orderQuery = @"
                        INSERT INTO Orders (UserId, TotalPrice, PaymentMethod, OrderDate)
                        VALUES (@UserId, @TotalPrice, @PaymentMethod, GETDATE());
                        SELECT SCOPE_IDENTITY();";

                            int orderId;
                            using (SqlCommand orderCmd = new SqlCommand(orderQuery, conn, transaction))
                            {
                                orderCmd.Parameters.AddWithValue("@UserId", userId);
                                orderCmd.Parameters.AddWithValue("@TotalPrice", totalPrice);
                                orderCmd.Parameters.AddWithValue("@PaymentMethod", rdoCredit.Checked ? "Credit" : "Paypal");
                                orderId = Convert.ToInt32(orderCmd.ExecuteScalar());
                            }

                            string detailQuery = @"
                        INSERT INTO OrderDetails (OrderID, BookID, Title, Price)
                        VALUES (@OrderID, @BookID, @BookTitle, @Price)";

                            foreach (DataRow row in selectedItems.Rows)
                            {
                                using (SqlCommand detailCmd = new SqlCommand(detailQuery, conn, transaction))
                                {
                                    detailCmd.Parameters.AddWithValue("@OrderID", orderId);
                                    detailCmd.Parameters.AddWithValue("@BookID", Convert.ToInt32(row["BookId"]));
                                    detailCmd.Parameters.AddWithValue("@BookTitle", row["Title"]);
                                    detailCmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(row["Price"]));
                                    detailCmd.ExecuteNonQuery();
                                }
                            }

                            string deleteCartQuery = @"
                        DELETE FROM Cart 
                        WHERE BookId = @BookId AND UserId = @UserId";

                            foreach (DataRow row in selectedItems.Rows)
                            {
                                using (SqlCommand deleteCmd = new SqlCommand(deleteCartQuery, conn, transaction))
                                {
                                    deleteCmd.Parameters.AddWithValue("@BookId", Convert.ToInt32(row["BookId"]));
                                    deleteCmd.Parameters.AddWithValue("@UserId", userId);
                                    deleteCmd.ExecuteNonQuery();
                                }
                            }
                        }

                        transaction.Commit();
                        Session["SelectedItems"] = null;
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }

        private void ClearSelectedItemsFromCart(int userId)
        {
            DataTable selectedItems = Session["SelectedItems"] as DataTable;
            if (selectedItems == null || selectedItems.Rows.Count == 0) return;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                foreach (DataRow row in selectedItems.Rows)
                {
                    int bookId = Convert.ToInt32(row["BookId"]);

                    string query = "DELETE FROM Cart WHERE UserID = @UserID AND BookId = @BookId";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@BookId", bookId);
                        int rowsAffected = cmd.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine($"Backup cleanup: BookId={bookId}, UserID={userId}, Rows affected={rowsAffected}");
                    }
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
                lblErrorMessage.Text = "Please enter your Paypal username.";
                return false;
            }

            if (string.IsNullOrEmpty(txtDebitPassword.Text))
            {
                lblErrorMessage.Text = "Please enter your Paypal password.";
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