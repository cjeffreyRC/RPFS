using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;

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
            DAL d = new DAL();
            d.AddParam("userEmail", txtEmail.Text);
            d.AddParam("userPassword", txtPassword.Text);
            string value = d.ExecuteScalar("spLogin");  //need sp ----- pass: userEmail, userPassword ----- return: -1 or userId
            Session["userId"] = value;

            if (value == "-1")
            {
                lblError.Text = "Login failed, try again.";
            }
            else
            {                
                Response.Redirect("Vote.aspx");
            }
        }
    }
}