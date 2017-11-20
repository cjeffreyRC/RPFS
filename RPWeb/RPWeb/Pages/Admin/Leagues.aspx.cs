using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;

namespace RPWeb.Pages.Admin
{
    public partial class Leagues : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DAL d = new DAL();
                gvLeagues.DataSource = d.ExecuteProcedure("spGetAllLeagues");
                gvLeagues.DataBind();

                ddlSport.DataSource = d.ExecuteProcedure("spGetAllSports");
                ddlSport.DataTextField = ("Name");
                ddlSport.DataValueField = ("ID");
                ddlSport.DataBind();

                rblType.DataSource = d.ExecuteProcedure("spGetAllLeagueTypes");
                rblType.DataTextField = "Type";
                rblType.DataValueField = "ID";
                rblType.DataBind();

                cblLeagueUsers.DataSource = d.ExecuteProcedure("spGetAllUsers");
                cblLeagueUsers.DataTextField = "Name";
                cblLeagueUsers.DataValueField = "ID";
                cblLeagueUsers.DataBind();
            }
        }


        protected void updateSubmit_Click(object sender, EventArgs e)
        {
            var sportId = ddlSport.SelectedValue;
            var typeId = rblType.SelectedValue;
            var draftDate = txtDate.Text;
            var title = txtTitle.Text;
            List<int> userIds = new List<int>();
            List<int> leagueTeamIds = new List<int>();

            DAL d = new DAL();
            d.AddParam("leagueSportId", sportId);
            d.AddParam("leagueTypeId", typeId);
            d.AddParam("leagueDraftDate", draftDate);
            d.AddParam("leagueTitle", title);

            var leagueId = d.ExecuteScalar("spAddLeague");

            //Create Teams
            foreach (ListItem li in cblLeagueUsers.Items)
            {
                if (li.Selected)
                {
                    userIds.Add(Convert.ToInt32(li.Value));
                }
            }

            for (int i = 0; i < userIds.Count; i++)
            {
                d.AddParam("userId", userIds[i]);
                d.AddParam("leagueId", leagueId);
                leagueTeamIds.Add(Convert.ToInt32(d.ExecuteScalar("spAddTeam")));
            }




            //Create Games
            for (int x = leagueTeamIds.Count-1; x > 0; x--)
            {
                var homeTeamId = leagueTeamIds[x];
                for (int y = 0; y < x; y++)
                {
                    d.AddParam("leagueId", leagueId);
                    d.AddParam("homeTeamId", homeTeamId);
                    d.AddParam("awayTeamId", leagueTeamIds[y]);
                    d.ExecuteNonQuery("spAddGame");
                }
            }

            //Create Free Agency team
            d.AddParam("leagueId", leagueId);
            d.AddParam("userId", 0);
            d.AddParam("teamName", "Free Agency");
            d.AddParam("teamLocation", "N/A");
            d.ExecuteScalar("spAddTeam");

            //TODO: validate roster from file upload and save roster
        }

        protected void gvLeagues_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string evnt = e.CommandName;
            string leagueId = e.CommandArgument as string;
            

            if (evnt == "viewLeagueTeams")
            {
                Response.Redirect("~/Pages/Admin/Teams.aspx?leagueId=" + leagueId);
            }
        }
    }
}