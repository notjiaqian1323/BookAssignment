using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Twilio;
using Twilio.Rest.Api.V2010.Account;
using System.Threading.Tasks;

namespace BookAssignment
{
    public partial class WebForm9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            _ = Send();
        }

        public static async Task Send()
        {
            // Find your Account SID and Auth Token at twilio.com/console
            // and set the environment variables. See http://twil.io/secure
            string accountSid = Environment.GetEnvironmentVariable("ACb2b273446c7fe210fb620f98f9070790");
            string authToken = Environment.GetEnvironmentVariable("b662e666fe2ca129747448dd925300cf");

            TwilioClient.Init(accountSid, authToken);

            var message = await MessageResource.CreateAsync(
                body: "This is the ship that made the Kessel Run in fourteen parsecs?",
                from: new Twilio.Types.PhoneNumber("+12184928997"),
                to: new Twilio.Types.PhoneNumber("+60123836912"));

            Console.WriteLine(message.Body);
        }
    }
}