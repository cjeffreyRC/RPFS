using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using RPFS;
using System.Web.UI;

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
                    div.ID = i.ToString();
                }
                RightPage.Attributes.Add("ondrop", "drop(event)");
                LeftPage.Controls.Add(table);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string RightPageID = RightPage.UniqueID;

            HtmlGenericControl table = (HtmlGenericControl)FindControl(RightPageID);
            //if (ctrl is HtmlGenericControl)
            //{
            //    List<List<HtmlGenericControl>> Rows = new List<List<HtmlGenericControl>>();
            //    lblMsg.Text = "Table is Generic Control";
            //    HtmlGenericControl table = (HtmlGenericControl)ctrl;
            //    for (int i = 0; i < table.Controls.Count; i++)
            //    {
            //        List<HtmlGenericControl> Cols = new List<HtmlGenericControl>();
            //        for (int x = 0; x < table.Controls[i].Controls.Count; x++)
            //        {
            //            Cols.Add((HtmlGenericControl)table.Controls[i].Controls[x]);
            //        }
            //        Rows.Add(Cols);
            //    }
            //}
            //else if (ctrl is LiteralControl)
            //{
            //    lblMsg.Text = "Table is Literal Control";
            //}


            //List<List<string>> players = new List<List<string>>();

            //HtmlGenericControl div = RightPage.Controls;
            //for (int i = 0; i < div.Count; i++)
            //{
            //    if (div[i] is LiteralControl)
            //    {
            //        for (int x = 0; x < div[i].Controls.Count; x++)
            //        {
            //            lblMsg.Text = lblMsg.Text + (HtmlGenericControl)div[i].Controls[x];
            //        }
            //    }
            //}


        }
    }
}