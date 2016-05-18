using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;

namespace RPFS_WebSurvey
{
    public partial class values : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DAL d = new DAL();
            gvValues.DataSource = d.ExecuteProcedure("spGetTotalValueAVGS");
            gvValues.DataBind();

            gvPerValues.DataSource = d.ExecuteProcedure("spGetTotalValues");
            gvPerValues.DataBind();

            lblCount.Text = d.ExecuteScalar("spGetCount");
        }
    }
}