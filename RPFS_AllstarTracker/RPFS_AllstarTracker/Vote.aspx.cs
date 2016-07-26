using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RPFS_AllstarTracker
{
    public partial class Vote : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((string)Session["userId"] == "-1")
            {
                Response.Redirect("Home.aspx?msg=Must log in to make your vote");
            }
        }
    }
}