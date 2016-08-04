using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using RPFS;

namespace RPFS_AllstarTracker
{
    public partial class Vote : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["user"] != null)
                {
                    User myUser = (User)Session["user"];

                    if (myUser.getUserId() == -1)
                    {
                        Response.Redirect("Home.aspx?msg=Must log in to make your vote");
                    }
                }
                else
                {
                    Response.Redirect("Home.aspx?msg=Must log in to make your vote");
                }
                HtmlGenericControl table = TableGenerator.CreateTable("spGetPlayers");
                for (int i = 0; i < table.Controls.Count; i++)
                {
                    HtmlGenericControl div = (HtmlGenericControl)table.Controls[i];
                    div.Attributes.Add("draggable", "true");
                    div.Attributes.Add("ondragstart", "drag(event)");
                    div.ID = table.Controls[i].Controls[0].ToString()+i;
                    div.Attributes.Add("ondrop", "return true");
                    div.Attributes.Add("ondragover", "return true");
                }
                RightPage.Attributes.Add("ondrop", "drop(event)");
                LeftPage.Controls.Add(table);
            }
        }

    }
}