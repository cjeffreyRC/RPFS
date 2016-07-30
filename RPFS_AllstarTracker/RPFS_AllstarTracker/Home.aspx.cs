using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RPFS;

namespace RPFS_AllstarTracker
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["msg"] != "")
                {
                    lblError.Text = Request.QueryString["msg"];
                    //Request.QueryString["msg"] = "";
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            User newUser = Security.Login(txtEmail.Text, txtPassword.Text);
            if (newUser.getUserId() == -1)
            {
                lblError.Text = "Login information invalid. Please try again.";
            }
            else
            {
                Session["user"] = newUser;
                Response.Redirect("Vote.aspx");
            }
            
        }
    }
}