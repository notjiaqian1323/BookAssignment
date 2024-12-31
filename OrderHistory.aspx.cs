using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Web;

namespace OnlineBookStore
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 检查用户是否登录
            if (Session["UserID"] == null)
            {
                // 如果用户未登录，重定向到登录页面
                Response.Redirect("CustomerLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrderHistory();
            }
        }

        private void LoadOrderHistory()
        {
            // 从Session中获取当前登录用户的ID
            int userID = Convert.ToInt32(Session["UserID"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT OrderID, BookTitle, TotalPrice, PaymentMethod, OrderDate 
                               FROM Orders 
                               WHERE UserID = @UserID 
                               ORDER BY OrderDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    DataTable dt = new DataTable();
                    conn.Open();

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }

                    if (dt.Rows.Count > 0)
                    {
                        rptOrders.DataSource = dt;
                        rptOrders.DataBind();
                        pnlNoOrders.Visible = false;
                    }
                    else
                    {
                        rptOrders.Visible = false;
                        pnlNoOrders.Visible = true;
                    }
                }
            }
        }

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "GenerateInvoice")
            {
                int orderID = Convert.ToInt32(e.CommandArgument);
                // 添加安全检查，确保用户只能访问自己的订单
                if (IsUserOrder(orderID))
                {
                    GenerateInvoice(orderID);
                }
                else
                {
                    // 可以添加错误消息提示
                    Response.Write("<script>alert('Unauthorized access');</script>");
                }
            }
        }

        // 新增方法：验证订单是否属于当前用户
        private bool IsUserOrder(int orderID)
        {
            if (Session["UserID"] == null)
                return false;

            int userID = Convert.ToInt32(Session["UserID"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(1) FROM Orders WHERE OrderID = @OrderID AND UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@OrderID", orderID);
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    conn.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    return count > 0;
                }
            }
        }

        private void GenerateInvoice(int orderID)
        {
            // 确保用户已登录
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userID = Convert.ToInt32(Session["UserID"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();
            StringBuilder invoiceHtml = new StringBuilder();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT o.OrderID, o.BookTitle, o.TotalPrice, 
                               o.PaymentMethod, o.OrderDate
                               FROM Orders o
                               WHERE o.OrderID = @OrderID AND o.UserID = @UserID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@OrderID", orderID);
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // 生成发票HTML
                            invoiceHtml.Append("<html><head>");
                            invoiceHtml.Append("<style>");
                            invoiceHtml.Append(@"
                                body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
                                .invoice { max-width: 800px; margin: 0 auto; padding: 20px; border: 1px solid #eee; }
                                .header { text-align: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 2px solid #eee; }
                                .details { margin: 20px 0; }
                                .info-row { display: flex; justify-content: space-between; margin-bottom: 10px; }
                                .info-label { font-weight: bold; color: #666; }
                                .table { width: 100%; border-collapse: collapse; margin: 20px 0; }
                                .table th { background: #f8f9fa; }
                                .table th, .table td { padding: 12px; border: 1px solid #ddd; text-align: left; }
                                .total { text-align: right; margin-top: 20px; padding-top: 20px; border-top: 2px solid #eee; }
                                .total h3 { color: #2563eb; margin: 0; }
                            ");
                            invoiceHtml.Append("</style></head><body>");
                            invoiceHtml.Append("<div class='invoice'>");

                            // 发票头部
                            invoiceHtml.Append("<div class='header'>");
                            invoiceHtml.Append("<h1>Online Book Store</h1>");
                            invoiceHtml.Append("<h2>Invoice</h2>");
                            invoiceHtml.Append("</div>");

                            // 发票详情
                            invoiceHtml.Append("<div class='details'>");
                            invoiceHtml.Append("<div class='info-row'>");
                            invoiceHtml.Append($"<div><span class='info-label'>Order ID:</span> {reader["OrderID"]}</div>");
                            invoiceHtml.Append($"<div><span class='info-label'>Date:</span> {Convert.ToDateTime(reader["OrderDate"]).ToString("dd/MM/yyyy HH:mm")}</div>");
                            invoiceHtml.Append("</div>");
                            invoiceHtml.Append("<div class='info-row'>");
                            invoiceHtml.Append($"<div><span class='info-label'>Payment Method:</span> {reader["PaymentMethod"]}</div>");
                            invoiceHtml.Append("</div>");

                            // 商品详情表格
                            invoiceHtml.Append("<table class='table'>");
                            invoiceHtml.Append("<thead>");
                            invoiceHtml.Append("<tr><th>Item Description</th><th>Price</th></tr>");
                            invoiceHtml.Append("</thead><tbody>");
                            invoiceHtml.Append($"<tr><td>{reader["BookTitle"]}</td><td>RM {Convert.ToDecimal(reader["TotalPrice"]):F2}</td></tr>");
                            invoiceHtml.Append("</tbody></table>");

                            // 总计
                            invoiceHtml.Append("<div class='total'>");
                            invoiceHtml.Append($"<h3>Total Amount: RM {Convert.ToDecimal(reader["TotalPrice"]):F2}</h3>");
                            invoiceHtml.Append("</div>");

                            invoiceHtml.Append("</div></div>");

                            // 添加页脚
                            invoiceHtml.Append("<div style='text-align: center; margin-top: 40px; color: #666; font-size: 0.875rem;'>");
                            invoiceHtml.Append("<p>Thank you for shopping with Online Book Store</p>");
                            invoiceHtml.Append($"<p>Generated on {DateTime.Now.ToString("dd/MM/yyyy HH:mm")}</p>");
                            invoiceHtml.Append("</div>");

                            invoiceHtml.Append("</body></html>");
                        }
                        else
                        {
                            // 如果找不到订单或订单不属于当前用户
                            Response.Write("<script>alert('Order not found or unauthorized access');</script>");
                            return;
                        }
                    }
                }
            }

            // 设置响应头和输出invoice（保持原有代码不变）
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "text/html";
            Response.AddHeader("content-disposition", $"attachment;filename=Invoice_{orderID}.html");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Write(invoiceHtml.ToString());
            Response.End();
        }
    }
}

