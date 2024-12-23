using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;

namespace BookAssignment
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SendEmail("qwoo70749@gmail.com", "Test Email", "This is a test email from ASP.NET");
        }

        public void SendEmail(string recipientEmail, string subject, string body)
            {
                try
                {
                    MailMessage mail = new MailMessage
                    {
                        From = new MailAddress("q12w15e2003@gmail.com"), // Sender Email
                        Subject = subject,
                        Body = body,
                        IsBodyHtml = true
                    };

                    mail.To.Add(recipientEmail);

                    SmtpClient smtp = new SmtpClient();
                    smtp.Send(mail);

                    Console.WriteLine("Email sent successfully!");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Failed to send email: {ex.Message}");
                }
            }


        }
}