using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using DataAccessLayer;
using RPFS;

namespace RPFS_AllstarTracker
{
    /// <summary>
    /// Summary description for SubmitVote
    /// </summary>
    public class SubmitVote : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            if (HttpContext.Current.Session["user"] != null)
            {
                context.Response.ContentType = "text/plain";

                NameValueCollection NVC = context.Request.QueryString;
                string conferenceId = context.Request.QueryString["conf"];
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
                    result = d.ExecuteScalar("spVote");

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