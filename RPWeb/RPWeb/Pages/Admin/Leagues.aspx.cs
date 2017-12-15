using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;
using System.Text.RegularExpressions;

namespace RPWeb.Pages.Admin
{
    public partial class Leagues : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DAL d = new DAL();
            gvLeagues.DataSource = d.ExecuteProcedure("spGetAllLeagues");
            gvLeagues.DataBind();

            //ddlSport.DataSource = d.ExecuteProcedure("spGetAllSports");
            //ddlSport.DataTextField = ("Name");
            //ddlSport.DataValueField = ("ID");
            //ddlSport.DataBind();

            //rblType.DataSource = d.ExecuteProcedure("spGetAllLeagueTypes");
            //rblType.DataTextField = "Name";
            //rblType.DataValueField = "ID";
            //rblType.DataBind();

            //cblLeagueUsers.DataSource = d.ExecuteProcedure("spGetAllUsers");
            //cblLeagueUsers.DataTextField = "Name";
            //cblLeagueUsers.DataValueField = "ID";
            //cblLeagueUsers.DataBind();

            loadList(cblLeagueUsers, "spGetAllUsers");
            loadList(rblType, "spGetAllLeagueTypes");
            loadList(ddlSport, "spGetAllSports");
        }

        private void loadList(ListControl ctrl, string procedureName)
        {
            DAL d = new DAL();
            ctrl.DataSource = d.ExecuteProcedure(procedureName);
            ctrl.DataTextField = "Name";
            ctrl.DataValueField = "ID";
            ctrl.DataBind();
        }


        protected void updateSubmit_Click(object sender, EventArgs e)
        {
            if (Regex.IsMatch(fupRoster.FileName, "[^.]*[.]csv", RegexOptions.IgnoreCase))
            {
                //File is CSV, open and validate for roster
                StreamReader sr = new StreamReader(fupRoster.FileContent);
                string[] line1 = sr.ReadLine().Split(';');

                if (line1[0] == "playerName" && line1[1] == "PositionId" && line1[2] == "Overall")
                {
                    //Headers validated, proceed with creating league + teams, and adding players to DB
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
                    for (int x = leagueTeamIds.Count - 1; x > 0; x--)
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

                    d.AddParam("leagueId", leagueId);
                    int freeAgencyId = Convert.ToInt32(d.ExecuteScalar("spGetLeagueFreeAgencyId"));

                    while (!sr.EndOfStream)
                    {
                        string[] player = sr.ReadLine().Split(';');
                        d.AddParam("playerName", player[0]);
                        d.AddParam("playerPositionId", player[1]);
                        d.AddParam("playerOverall", player[2]);
                        d.AddParam("playerTeamId", freeAgencyId);
                        d.ExecuteNonQuery("spAddPlayer");
                    }
                }
                else
                {
                    //Headers invalid, reject roster and do not create league + teams
                    backdrop.Style.Remove("display");
                    lblError.Text = "League was not created - CSV headers invalid. Check headers in row one match the following: " +
                        "Column 1: 'playerName', Column 2: 'PositionId', Column 3: Overall";
                }

            }
            else
            {
                //File is not CSV, return error
                backdrop.Style.Remove("display");
                lblError.Text = "League was not created - file not in CSV format. Please ensure uploaded file is a CSV file (example.csv)";
            }

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