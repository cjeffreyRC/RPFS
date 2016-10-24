using DataAccessLayer;
using RPFS;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;

namespace RPFS_AllstarTracker
{
    /// <summary>
    /// Summary description for SubmitMvpVote
    /// </summary>
    public class SubmitMvpVote : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            if (HttpContext.Current.Session["user"] != null)
            {
                NameValueCollection NVC = context.Request.QueryString;
                DAL d = new DAL();
                bool allSuccess = true;
                string result = "";
                User currentUser = (User)HttpContext.Current.Session["user"];

                for (int i = 0; i < NVC.Count; i++)
                {
                    string[] newarray = NVC.GetValues(i);
                    d.AddParam("playerId", newarray[0]);
                    d.AddParam("vote", newarray[1]);
                    HttpContext.Current.Session["user"].ToString();
                    d.AddParam("userId", currentUser.getUserId());
                    result = d.ExecuteScalar("spVoteMvp");

                    if (result == "0")
                    {
                        allSuccess = false;
                    }
                }
                if (allSuccess)
                {
                    context.Response.Write(1);
                }
                else
                {
                    context.Response.Write(0);
                }
            }

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