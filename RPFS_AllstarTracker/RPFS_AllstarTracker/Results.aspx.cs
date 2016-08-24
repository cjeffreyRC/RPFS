using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;

namespace RPFS_AllstarTracker
{
    public partial class Results : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadPlayers();
            }
        }

        private void loadPlayers()
        {
            DAL d = new DAL();
            gvVotes.DataSource = d.ExecuteProcedure("spGetPlayers");
            gvVotes.DataBind();
        }
    }
}