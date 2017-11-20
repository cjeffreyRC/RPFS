using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RPWeb.Pages
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString != null)
            {
                string[,] values = new string[Request.QueryString.Count,2];

                var i = 0;
                foreach (String key in Request.QueryString.AllKeys)
                {
                    //"Key: " + key + " Value: " + Request.QueryString[key];
                    values[i,0] = key;
                    values[i, 1] = Request.QueryString[key];

                    i++;
                }

                if (values != null && values.Length != 0)
                {
                    //There is an error or msg query string
                }
            }
        }
    }
}