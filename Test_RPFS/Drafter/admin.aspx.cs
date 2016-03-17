using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;

namespace Drafter
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DAL d = new DAL();
                ddlSports.DataSource = d.ExecuteProcedure("spGetSports");
                ddlSports.DataTextField = "sportName";
                ddlSports.DataValueField = "sportId";
                ddlSports.DataBind();
                ddlSports.Items.Insert(0, new ListItem("Select a Sport...", "-1"));

                cblRoomUsers.DataSource = d.ExecuteProcedure("spGetUsers");
                cblRoomUsers.DataTextField = "username";
                cblRoomUsers.DataValueField = "userId";
                cblRoomUsers.DataBind();
            }
        }

        protected void btnRooms_Click(object sender, EventArgs e)
        {
            pnlRooms.Visible = true;
        }

        protected void btnNewRoom_Click(object sender, EventArgs e)
        {
            pnlNewRoom.Visible = true;
        }

        protected void BtnCancelRoom_Click(object sender, EventArgs e)
        {
            pnlNewRoom.Visible = false;
            ddlSports.SelectedIndex = 0;
            cblRoomUsers.SelectedIndex = -1;
        }

        protected void btnSaveRoom_Click(object sender, EventArgs e)
        {
            tsTime.
        }
    }
}