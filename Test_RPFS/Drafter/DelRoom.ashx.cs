using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DataAccessLayer;

namespace Drafter
{
    /// <summary>
    /// Summary description for DelRoom
    /// </summary>
    public class DelRoom : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string roomId = context.Request.QueryString["roomId"];
            DAL d = new DAL();
            d.AddParam("roomId",roomId);
            string result = d.ExecuteScalar("spCloseRoom");
            context.Response.ContentType = "text/plain";
            if (result == "1")
            {
                context.Response.Write("0");
            }
            else
            {
                context.Response.Write("1");
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