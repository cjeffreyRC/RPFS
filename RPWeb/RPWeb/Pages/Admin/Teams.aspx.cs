using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;

namespace RPWeb.Pages.Admin
{
    public partial class Teams : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DAL d = new DAL();
                string leagueId = Request.QueryString["leagueId"];
                d.AddParam("leagueId", leagueId);
                string freeAgencyTeamId = d.ExecuteScalar("spGetLeagueFreeAgencyId");

                d.AddParam("teamId", freeAgencyTeamId);
                gvFreeAgents.DataSource = d.ExecuteProcedure("spGetTeamPlayers");
                gvFreeAgents.DataBind();
            }
        }
    }
}