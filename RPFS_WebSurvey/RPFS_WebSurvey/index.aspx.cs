using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;
using System.Data;

namespace RPFS_WebSurvey
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DAL d = new DAL();
                loadRBL(rblAutoDraft, d.ExecuteProcedure("spGetAutoDraftRBL"));
                loadRBL(rblChat, d.ExecuteProcedure("spGetChatRBL"));
            }            
        }

        private void loadRBL(ListControl lc, DataSet ds)
        {
            lc.DataSource = ds;
            lc.DataTextField = "selection";
            lc.DataValueField = "value";
            lc.DataBind();
            lc.SelectedIndex = -1;
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            if (rblAutoDraft.SelectedIndex == -1 || rblChat.SelectedIndex == -1)
            {
                lblError.Text = "Must Select Autodraft choice, and Chat choice to submit.";
            }
            else
            {
                DAL d = new DAL();
                d.AddParam("firstName", txtFirstName.Text);
                d.AddParam("lastName", txtLastName.Text);
                d.AddParam("pickTrades", txtPickTrades.Text);
                d.AddParam("playerTrades", txtPlayerTrades.Text);
                d.AddParam("playerPickTrades", txtPlayerPickTrades.Text);
                d.AddParam("multiTeamTrades", txtMultiTeamTrades.Text);
                d.AddParam("dragNDrop", txtQDragNDrop.Text);
                d.AddParam("autoDraft", rblAutoDraft.SelectedValue);
                d.AddParam("chat", rblChat.SelectedValue);
                d.ExecuteNonQuery("spSave");

                Response.Redirect("results.aspx");
            }
        }
    }
}