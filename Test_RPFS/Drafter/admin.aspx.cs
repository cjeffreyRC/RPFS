using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MKB.TimePicker;
using DataAccessLayer;
using System.Data;

namespace Drafter
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DAL d = new DAL();
                LoadListControl(ddlSports, "sportname", "sportId", d.ExecuteProcedure("spGetSports"));
                //ddlSports.DataSource = d.ExecuteProcedure("spGetSports");
                //ddlSports.DataTextField = "sportName";
                //ddlSports.DataValueField = "sportId";
                //ddlSports.DataBind();

                LoadListControl(cblLeagueUsers, "username", "userId", d.ExecuteProcedure("spGetAllUsers"));
                //cblLeagueUsers.DataSource = d.ExecuteProcedure("spGetAllUsers");
                //cblLeagueUsers.DataTextField = "username";
                //cblLeagueUsers.DataValueField = "userId";
                //cblLeagueUsers.DataBind();

                LoadListControl(rblTypes, "leagueType", "leagueTypeId", d.ExecuteProcedure("spGetLeagueTypes"));
                //rblTypes.DataSource = d.ExecuteProcedure("spGetLeagueTypes");
                //rblTypes.DataTextField = "leagueType";
                //rblTypes.DataValueField = "leagueTypeId";
                //rblTypes.DataBind();
                gvRooms.DataSource = d.ExecuteProcedure("spGetRooms");
                gvRooms.DataBind();

                tsTime.SetTime(6, 00, TimeSelector.AmPmSpec.PM);
            }
        }

        private void LoadListControl(ListControl ctrl, string txt, string val, DataSet ds)
        {
            ctrl.DataSource = ds;
            ctrl.DataTextField = txt;
            ctrl.DataValueField = val;
            ctrl.DataBind();
            if (ctrl is DropDownList)
            {
                ctrl.Items.Insert(0, new ListItem("Select...", "-1"));
            }
            else if (ctrl is RadioButtonList)
            {
                ctrl.SelectedIndex = 1;
            }
            
        }

        protected void btnRooms_Click(object sender, EventArgs e)
        {
            pnlRooms.Visible = true;
            pnlTeams.Visible = false;
            pnlUsers.Visible = false;
        }

        protected void btnNewRoom_Click(object sender, EventArgs e)
        {
            pnlNewRoom.Visible = true;
        }

        protected void BtnCancelRoom_Click(object sender, EventArgs e)
        {
            pnlNewRoom.Visible = false;
            ddlSports.SelectedIndex = 0;
            cblLeagueUsers.SelectedIndex = -1;
            rblTypes.SelectedIndex = 1;
            hfRoomId.Value = "";
        }

        protected void btnSaveRoom_Click(object sender, EventArgs e)
        {
            DAL d = new DAL();
            d.AddParam("sportId", ddlSports.SelectedValue);
            d.AddParam("startDateTime", new DateTime(calDate.SelectedDate.Year, calDate.SelectedDate.Month, calDate.SelectedDate.Day, tsTime.Hour, tsTime.Minute, tsTime.Second));
            d.AddParam("leagueTypeId", rblTypes.SelectedValue);
            string roomId = "";
            if (hfRoomId.Value == "")
            {
                roomId = d.ExecuteScalar("spAddRoom");
            }
            else
            {
                roomId = hfRoomId.Value;
                d.AddParam("roomId", roomId);
                d.ExecuteNonQuery("spUpdateRoom");
            }

            d.AddParam("roomId", roomId);
            DataSet dsTeamUserIds = d.ExecuteProcedure("spGetLeagueUserIds");
            foreach (ListItem User in cblLeagueUsers.Items)
            {
                int count = 0;
                d.AddParam("userId", User.Value);
                d.AddParam("roomId", roomId);

                foreach (DataRow row in dsTeamUserIds.Tables[0].Rows)
                {
                    if (row["userId"].ToString() == User.Value)
                    {
                        count++;
                    }
                }
                if (User.Selected)
                {
                    if (count == 0)
                    {
                        d.ExecuteNonQuery("spAddUserToLeague");
                    }
                }
                else
                {
                    if (count > 0)
                    {
                        d.ExecuteNonQuery("spRemoveUserFromLeague");
                    }
                }
            }
        }

        protected void calDate_SelectionChanged(object sender, EventArgs e)
        {
            txtDate.Text = calDate.SelectedDate.ToLongDateString();
        }

        protected void gvRooms_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int roomId = int.Parse(e.CommandArgument.ToString());
            string cmd = e.CommandName;

            switch (cmd)
            {
                case "ed":
                    EditRoom(roomId);
                    break;
            }

        }

        public void EditRoom(int roomId)
        {
            pnlNewRoom.Visible = true;
            DAL d = new DAL();
            d.AddParam("roomId", roomId);
            DataSet dsRoom = d.ExecuteProcedure("spGetLeagueAndRoom");
            DataRow dr = dsRoom.Tables[0].Rows[0];
            DateTime dt = Convert.ToDateTime(dr["startDateTime"].ToString());

            calDate.SelectedDate = dt;
            tsTime.SetTime(dt.Hour, dt.Minute, TimeSelector.AmPmSpec.PM);

            ddlSports.SelectedValue = dr["sportId"].ToString();
            rblTypes.SelectedValue = dr["leagueTypeId"].ToString();
            hfRoomId.Value = roomId.ToString();

            cblLeagueUsers.DataSource = d.ExecuteProcedure("spGetAllUsers");
            cblLeagueUsers.DataTextField = "username";
            cblLeagueUsers.DataValueField = "userId";
            cblLeagueUsers.DataBind();

            d.AddParam("roomId", roomId);
            DataSet dsTeamUserIds = d.ExecuteProcedure("spGetLeagueUserIds");

            foreach (ListItem user in cblLeagueUsers.Items)
            {
                foreach (DataRow roomUser in dsTeamUserIds.Tables[0].Rows)
                {
                    if (user.Value == roomUser["userId"].ToString())
                    {
                        user.Selected = true;
                    }
                }
            }
        }
    }
}