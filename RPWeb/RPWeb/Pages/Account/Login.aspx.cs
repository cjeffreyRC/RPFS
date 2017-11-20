using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RPWeb.Pages.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submit_Click(object sender, EventArgs e)
        {
            var emailAddress = email.Text;
            var pass = password.Text;
            string queryString;

            //TODO: check for existing user in the database and return success or failure
            bool success; // = database result (0 or 1/true or false)

            if (/*success == */true)
            {
                queryString = "?login=success";
                //TODO: Update "user" Session to contain "User" object
                Session["user"] = emailAddress;
            }
            else
            {
                queryString = "?login=failed";
            }

            Response.Redirect("~/Pages/home.aspx"+queryString);
        }
    }
}