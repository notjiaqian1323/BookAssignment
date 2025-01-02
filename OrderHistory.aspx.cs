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
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrderHistory();
            }
        }

        private void LoadOrderHistory()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT o.OrderID, 
                   o.OrderDate, 
                   o.PaymentMethod, 
                   o.TotalPrice,
                   STRING_AGG(od.Title, ', ') as BookTitles  -- 使用当前数据库中的实际列名
            FROM Orders o
            JOIN OrderDetails od ON o.OrderID = od.OrderID
            WHERE o.UserId = @UserId
            GROUP BY o.OrderID, o.OrderDate, o.PaymentMethod, o.TotalPrice
            ORDER BY o.OrderDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

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

        protected void GenerateInvoice(int orderID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();
            StringBuilder invoiceHtml = new StringBuilder();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // 首先获取订单和客户信息
                string orderQuery = @"
            SELECT o.OrderID, 
                   o.OrderDate, 
                   o.PaymentMethod, 
                   o.TotalPrice,
                   u.Name as CustomerName,
                   u.Email as CustomerEmail
            FROM Orders o
            JOIN Users u ON o.UserId = u.Id
            WHERE o.OrderID = @OrderID AND o.UserId = @UserId";

                // 然后获取订单详情
                string detailsQuery = @"
            SELECT b.Title,
                   od.Price
            FROM OrderDetails od
            JOIN Books b ON od.BookId = b.BookId
            WHERE od.OrderID = @OrderID
            ORDER BY b.Title";

                using (SqlCommand orderCmd = new SqlCommand(orderQuery, conn))
                {
                    orderCmd.Parameters.AddWithValue("@OrderID", orderID);
                    orderCmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"]));

                    conn.Open();
                    using (SqlDataReader orderReader = orderCmd.ExecuteReader())
                    {
                        if (orderReader.Read())
                        {
                            // 生成发票 HTML 头部
                            invoiceHtml.Append("<!DOCTYPE html>");
                            invoiceHtml.Append("<html><head>");
                            invoiceHtml.Append("<style>");
                            invoiceHtml.Append(@"
                        body { font-family: Arial, sans-serif; margin: 40px; }
                        .invoice-header { text-align: center; margin-bottom: 30px; }
                        .customer-info { margin-bottom: 20px; }
                        .info-label { font-weight: bold; }
                        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
                        th, td { padding: 10px; text-align: left; border-bottom: 1px solid #ddd; }
                        .price-column { text-align: right; }
                        .total { text-align: right; margin-top: 20px; font-weight: bold; }
                    ");
                            invoiceHtml.Append("</style>");
                            invoiceHtml.Append("</head><body>");

                            // 发票标题
                            invoiceHtml.Append("<div class='invoice-header'>");
                            invoiceHtml.Append("<h1>INVOICE</h1>");
                            invoiceHtml.Append($"<p>Order #: {orderReader["OrderID"]}</p>");
                            invoiceHtml.Append($"<p>Date: {Convert.ToDateTime(orderReader["OrderDate"]).ToString("dd/MM/yyyy HH:mm")}</p>");
                            invoiceHtml.Append("</div>");

                            // 客户信息
                            invoiceHtml.Append("<div class='customer-info'>");
                            invoiceHtml.Append($"<div><span class='info-label'>Customer Name:</span> {orderReader["CustomerName"]}</div>");
                            invoiceHtml.Append($"<div><span class='info-label'>Email:</span> {orderReader["CustomerEmail"]}</div>");
                            invoiceHtml.Append($"<div><span class='info-label'>Payment Method:</span> {orderReader["PaymentMethod"]}</div>");
                            invoiceHtml.Append("</div>");

                            // 商品详情表格头部
                            invoiceHtml.Append("<table>");
                            invoiceHtml.Append("<thead>");
                            invoiceHtml.Append("<tr><th>Book Title</th><th class='price-column'>Price (RM)</th></tr>");
                            invoiceHtml.Append("</thead><tbody>");

                            // 关闭第一个reader
                            orderReader.Close();

                            // 获取并显示订单详情
                            using (SqlCommand detailsCmd = new SqlCommand(detailsQuery, conn))
                            {
                                detailsCmd.Parameters.AddWithValue("@OrderID", orderID);
                                using (SqlDataReader detailsReader = detailsCmd.ExecuteReader())
                                {
                                    while (detailsReader.Read())
                                    {
                                        invoiceHtml.Append("<tr>");
                                        invoiceHtml.Append($"<td>{detailsReader["Title"]}</td>");
                                        invoiceHtml.Append($"<td class='price-column'>{Convert.ToDecimal(detailsReader["Price"]):F2}</td>");
                                        invoiceHtml.Append("</tr>");
                                    }
                                }
                            }

                            // 重新执行订单查询以获取总价
                            using (SqlCommand totalCmd = new SqlCommand(orderQuery, conn))
                            {
                                totalCmd.Parameters.AddWithValue("@OrderID", orderID);
                                totalCmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"]));
                                using (SqlDataReader totalReader = totalCmd.ExecuteReader())
                                {
                                    if (totalReader.Read())
                                    {
                                        invoiceHtml.Append("</tbody></table>");

                                        // 总计
                                        invoiceHtml.Append("<div class='total'>");
                                        invoiceHtml.Append($"<h3>Total Amount: RM {Convert.ToDecimal(totalReader["TotalPrice"]):F2}</h3>");
                                        invoiceHtml.Append("</div>");
                                    }
                                }
                            }

                            // 页脚
                            invoiceHtml.Append("<div style='text-align: center; margin-top: 40px; color: #666; font-size: 0.875rem;'>");
                            invoiceHtml.Append("<p>Thank you for shopping with Online Book Store</p>");
                            invoiceHtml.Append($"<p>Generated on {DateTime.Now:dd/MM/yyyy HH:mm}</p>");
                            invoiceHtml.Append("</div>");

                            invoiceHtml.Append("</body></html>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Order not found or unauthorized access');</script>");
                            return;
                        }
                    }
                }
            }

            // 设置响应头和输出发票
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

