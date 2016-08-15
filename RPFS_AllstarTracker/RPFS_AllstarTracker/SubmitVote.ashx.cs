using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;

namespace RPFS_AllstarTracker
{
    /// <summary>
    /// Summary description for SubmitVote
    /// </summary>
    public class SubmitVote : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/html";
            //HtmlGenericControl RightPage = context.Request.QueryString["data"];
            context.Response.Write("Hello World");
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