using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RPFS_AllstarTracker
{
    public partial class MvpResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadPlayers();
            }
        }

        private DataTable loadPlayers()
        {
            DAL d = new DAL();
            DataTable dt = d.ExecuteProcedure("spGetMvpVotes").Tables[0];
            gvVotes.DataSource = dt;
            gvVotes.DataBind();
            return dt;
        }

        protected void gvVotes_Sorting(object sender, GridViewSortEventArgs e)
        {
            loadPlayers();
            string expr = e.SortExpression;
            string direction = string.Empty;
            DataTable dt = (DataTable)gvVotes.DataSource;

            if (SortDirection == SortDirection.Ascending)
            {
                SortDirection = SortDirection.Descending;
                direction = " DESC";
            }
            else
            {
                SortDirection = SortDirection.Ascending;
                direction = " ASC";
            }
            dt.DefaultView.Sort = expr + direction;

            gvVotes.DataSource = dt;
            gvVotes.DataBind();

        }

        public SortDirection SortDirection
        {
            get
            {
                if (ViewState["SortDirection"] == null)
                {
                    ViewState["SortDirection"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["SortDirection"];
            }
            set
            {
                ViewState["SortDirection"] = value;
            }
        }
    }
}