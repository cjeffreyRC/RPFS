using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Test
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DAL d = new DAL();
            DataSet ds = d.ExecuteProcedure("spGetMessages");
            
            for (int i = ds.Tables[0].Rows.Count; i > 0; i--)
            {
                DataRow row = ds.Tables[0].Rows[i-1];
                string name = row["username"].ToString();
                string message = row["message"].ToString();
                discussion.InnerHtml += "<li><strong>" + name + "</strong>:&nbsp;&nbsp;" + message + "</li>";
            }
        }
    }
}