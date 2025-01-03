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
            
            if (Session["UserID"] == null)
            {
                
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
            int userId = Convert.ToInt32(Session["UserId"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT o.OrderID, 
                   o.OrderDate, 
                   o.PaymentMethod, 
                   o.TotalPrice,
                   STRING_AGG(od.Title, ', ') as BookTitles 
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
                
                if (IsUserOrder(orderID))
                {
                    GenerateInvoice(orderID);
                }
                else
                {
                    
                    Response.Write("<script>alert('Unauthorized access');</script>");
                }
            }
        }

        
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
                
                string orderQuery = @"
            SELECT o.OrderID, 
                   o.OrderDate, 
                   o.PaymentMethod, 
                   o.TotalPrice,
                   u.Name as CustomerName,
                   u.Email as CustomerEmail
            FROM Orders o
            JOIN [User] u ON o.UserID = u.Id
            WHERE o.OrderID = @OrderID AND o.UserID = @UserId";

                
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
                            
                            invoiceHtml.Append("<!DOCTYPE html>");
                            invoiceHtml.Append("<html><head>");
                            invoiceHtml.Append("<style>");
                            invoiceHtml.Append(@"
                                body { 
                                    font-family: Arial, sans-serif; 
                                    background-color: #f5f5f5;
                                    margin: 0;
                                    padding: 40px;
                                    min-height: 100vh;
                                    display: flex;
                                    justify-content: center;
                                    align-items: flex-start;
                                }

                                .invoice-container {
                                    background: white;
                                    width: 100%;
                                    max-width: 800px;
                                    margin: 0 auto;
                                    padding: 40px;
                                    border-radius: 12px;
                                    box-shadow: 0 2px 12px rgba(0,0,0,0.1);
                                }

                                .invoice-header {
                                    text-align: center;
                                    margin-bottom: 30px;
                                    padding-bottom: 20px;
                                    border-bottom: 2px solid #eee;
                                }

                                .invoice-header h1 {
                                    font-size: 28px;
                                    color: #2c3e50;
                                    margin-bottom: 10px;
                                }

                                .customer-info {
                                    margin-bottom: 30px;
                                    padding: 20px;
                                    background: #f8f9fa;
                                    border-radius: 8px;
                                }

                                .info-label {
                                    font-weight: bold;
                                    color: #2c3e50;
                                    display: inline-block;
                                    width: 140px;
                                }

                                table {
                                    width: 100%;
                                    border-collapse: collapse;
                                    margin: 20px 0;
                                }

                                th, td {
                                    padding: 12px;
                                    text-align: left;
                                    border-bottom: 1px solid #eee;
                                }

                                th {
                                    background-color: #f8f9fa;
                                    color: #2c3e50;
                                    font-weight: 600;
                                }

                                .price-column {
                                    text-align: right;
                                }

                                .total {
                                    text-align: right;
                                    margin-top: 20px;
                                    padding-top: 20px;
                                    border-top: 2px solid #eee;
                                }

                                .total h3 {
                                    color: #2c3e50;
                                    font-size: 18px;
                                    margin: 0;
                                }

                                .footer {
                                    text-align: center;
                                    margin-top: 40px;
                                    padding-top: 20px;
                                    border-top: 1px solid #eee;
                                    color: #666;
                                    font-size: 14px;
                                }

                                .footer p {
                                    margin: 5px 0;
                                }
                            ");
                            invoiceHtml.Append("</style>");
                            invoiceHtml.Append("</head><body>");

                            
                            invoiceHtml.Append("<div class='invoice-container'>");
                            
                            invoiceHtml.Append("<div class='invoice-header'>");
                            invoiceHtml.Append("<h1>INVOICE</h1>");
                            invoiceHtml.Append($"<p>Order #: {orderReader["OrderID"]}</p>");
                            invoiceHtml.Append($"<p>Date: {Convert.ToDateTime(orderReader["OrderDate"]).ToString("dd/MM/yyyy HH:mm")}</p>");
                            invoiceHtml.Append("</div>");

                            
                            invoiceHtml.Append("<div class='customer-info'>");
                            invoiceHtml.Append($"<div><span class='info-label'>Customer Name:</span> {orderReader["CustomerName"]}</div>");
                            invoiceHtml.Append($"<div><span class='info-label'>Email:</span> {orderReader["CustomerEmail"]}</div>");
                            invoiceHtml.Append($"<div><span class='info-label'>Payment Method:</span> {orderReader["PaymentMethod"]}</div>");
                            invoiceHtml.Append("</div>");

                            
                            invoiceHtml.Append("<table>");
                            invoiceHtml.Append("<thead>");
                            invoiceHtml.Append("<tr><th>Book Title</th><th class='price-column'>Price (RM)</th></tr>");
                            invoiceHtml.Append("</thead><tbody>");


                            
                            orderReader.Close();

                            
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

                            
                            using (SqlCommand totalCmd = new SqlCommand(orderQuery, conn))
                            {
                                totalCmd.Parameters.AddWithValue("@OrderID", orderID);
                                totalCmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"]));
                                using (SqlDataReader totalReader = totalCmd.ExecuteReader())
                                {
                                    if (totalReader.Read())
                                    {
                                        invoiceHtml.Append("</tbody></table>");

                                        
                                        invoiceHtml.Append("<div class='total'>");
                                        invoiceHtml.Append($"<h3>Total Amount: RM {Convert.ToDecimal(totalReader["TotalPrice"]):F2}</h3>");
                                        invoiceHtml.Append("</div>");
                                    }
                                }
                            }

                            
                            invoiceHtml.Append("<div class='footer'>");
                            invoiceHtml.Append("<p>Thank you for shopping with Online Book Store</p>");
                            invoiceHtml.Append($"<p>Generated on {DateTime.Now:dd/MM/yyyy HH:mm}</p>");
                            invoiceHtml.Append("</div>");

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

