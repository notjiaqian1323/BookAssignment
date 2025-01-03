using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookAssignment.Admin
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNotifications();
            }
        }

        private void LoadNotifications()
        {
            StringBuilder sb = new StringBuilder();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringA"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Load Order Notifications
                    string orderQuery = @"
                    SELECT 
                        o.OrderID,
                        o.UserID,
                        u.Name AS UserName,
                        od.Title AS BookTitle,
                        o.OrderDate
                    FROM Orders o
                    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
                    INNER JOIN [User] u ON o.UserID = u.Id
                    ORDER BY o.OrderDate DESC";

                    using (SqlCommand orderCmd = new SqlCommand(orderQuery, connection))
                    using (SqlDataReader orderReader = orderCmd.ExecuteReader())
                    {
                        while (orderReader.Read())
                        {
                            string userName = orderReader["UserName"].ToString();
                            string bookTitle = orderReader["BookTitle"].ToString();
                            DateTime orderDate = Convert.ToDateTime(orderReader["OrderDate"]);
                            string timeAgo = GetTimeAgo(orderDate);

                            // Check if order is within the last 24 hours
                            string unreadClass = (DateTime.Now - orderDate).TotalHours <= 24 ? "unread" : "";

                            sb.AppendFormat(@"
                        <div class='notif_card {3}'>
                            <img src='../ProfilePic/defaultpic.png'/>
                            <div class='description'>
                                <p class='user_activity'>
                                    <strong>{0}</strong> made an order of <b>{1}</b>
                                </p>
                                <p class='time'>{2}</p>
                            </div>
                        </div>", userName, bookTitle, timeAgo, unreadClass);
                        }
                    }

                    // Load Feedback Notifications
                    string feedbackQuery = @"
                    SELECT 
                        f.Id AS FeedbackID,
                        f.Name AS UserName,
                        f.FeedbackText,
                        f.SubmittedOn
                    FROM Feedback f
                    ORDER BY f.SubmittedOn DESC";

                    using (SqlCommand feedbackCmd = new SqlCommand(feedbackQuery, connection))
                    using (SqlDataReader feedbackReader = feedbackCmd.ExecuteReader())
                    {
                        while (feedbackReader.Read())
                        {
                            string userName = feedbackReader["UserName"].ToString();
                            string feedbackText = feedbackReader["FeedbackText"].ToString();
                            DateTime submittedOn = Convert.ToDateTime(feedbackReader["SubmittedOn"]);
                            string timeAgo = GetTimeAgo(submittedOn);

                            // Check if feedback is within the last 24 hours
                            string unreadClass = (DateTime.Now - submittedOn).TotalHours <= 24 ? "unread" : "";

                            sb.AppendFormat(@"
                        <div class='notif_card {3}'>
                            <div class='message_card'>
                                <img src='../ProfilePic/defaultpic.png'/>
                                <div class='description'>
                                    <p class='user_activity'>
                                        <strong>{0}</strong> sent you a feedback:
                                    </p>
                                    <div class='message'>
                                        <p>{1}</p>
                                    </div>
                                    <p class='time'>{2}</p>
                                </div>
                            </div>
                        </div>", userName, feedbackText, timeAgo, unreadClass);
                        }
                    }
                }

                notifContainer.Text = sb.ToString();
            }
            catch (Exception ex)
            {
                notifContainer.Text = $"<p>Error: {ex.Message}</p>";
            }
        }

        // Calculate Time Ago
        private string GetTimeAgo(DateTime dateTime)
        {
            TimeSpan timeSpan = DateTime.Now - dateTime;

            if (timeSpan.TotalMinutes < 60)
                return $"{(int)timeSpan.TotalMinutes}m ago";
            if (timeSpan.TotalHours < 24)
                return $"{(int)timeSpan.TotalHours}h ago";
            if (timeSpan.TotalDays < 7)
                return $"{(int)timeSpan.TotalDays}d ago";
            if (timeSpan.TotalDays < 30)
                return $"{(int)(timeSpan.TotalDays / 7)}w ago";

            return dateTime.ToString("dd MMM yyyy");
        }
    }
}