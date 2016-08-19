using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using DataAccessLayer;

namespace RPFS_AllstarTracker
{
    /// <summary>
    /// Summary description for SubmitVote
    /// </summary>
    public class SubmitVote : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            NameValueCollection NVC = context.Request.QueryString;
            DAL d = new DAL();

            for (int i = 0; i < NVC.Count; i++)
            {
                string[] newarray = NVC.GetValues(i);
                d.AddParam("playerId", newarray[0]);
                d.AddParam("vote", newarray[1]);
            }
            context.Response.Write("");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}