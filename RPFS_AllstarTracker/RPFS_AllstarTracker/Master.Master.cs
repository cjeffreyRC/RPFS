using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RPFS;

namespace RPFS_AllstarTracker
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != null)
            {
                User currUser = (User)Session["user"];
                lblUserName.Text = "Hello " + currUser.getUserName() + "! Go " + currUser.getUserTeamName() + "!";
                lbLogout.Visible = true;
            }
            else
            {
                lbLogout.Visible = false;
                lblUserName.Text = "";
            }
        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("home.aspx");
        }
    }
}