using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RPWeb.Pages.Account
{
    public partial class Account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //TODO: If user is not logged in, redirect to home page
            if (Session["user"] == null)
            {
                Response.Redirect("~/Pages/home.aspx?error=not logged in");
            }

            if (!IsPostBack)
            {
                //TODO: Get logged in user's information from session variable

                //Below assumes session variable is an object of type "User" which contains the users information as properties
                name.Text = "";     //User.firstName+" "+User.lastName;
                email.Text = "";    //User.emailAddress;
                favSport.Text = ""; //User.favoriteSport;
            }
        }

        protected void logout_Click(object sender, EventArgs e)
        {
            //TODO: Remove session variable containing logged in user
            Session.Clear();
            Response.Redirect("~/Pages/home.aspx?msg=logged out");
        }


        protected void updateSubmit_Click(object sender, EventArgs e)
        {

        }
    }
}