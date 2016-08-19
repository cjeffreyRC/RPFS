using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;

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


            



            for (int i = 0; i < NVC.Count; i++)
            {
                string[] newarray = NVC.GetValues(i);
                string playerId = newarray[0];
                string playerPoints = newarray[1];
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