using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RPWeb
{
    public partial class RPWeb : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //TODO: If logged in, display name in nav (label id="username")
            //TODO: Conditionally display isLoggedIn or notLoggedIn
        }
    }
}