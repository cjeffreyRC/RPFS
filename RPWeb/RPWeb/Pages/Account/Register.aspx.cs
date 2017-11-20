using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RPWeb.Pages.Account
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            resultDisplay.Visible = true;

            var firstName = fName.Text;
            var lastName = lName.Text;
            var email = emailAddress.Text;
            var favSport = favoriteSport.Text;
            var pass = password.Text;

            lblName.Text = " "+firstName+" "+lastName;
            lblFullName.Text = " " + firstName + " " + lastName + " ";
            lblEmailAddress.Text = email;

            //TODO: Save user values to database, and output success or failure message
        }
    }
}