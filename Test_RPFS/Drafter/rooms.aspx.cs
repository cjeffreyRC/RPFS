using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;

namespace Drafter
{
    public partial class rooms : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadRooms();
        }
        private void LoadRooms()
        {
            DAL d = new DAL();
            dlRooms.DataSource = d.ExecuteProcedure("spGetRooms");
            dlRooms.DataBind();
        }

        protected void dlRooms_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string cmd = e.CommandName;
            string roomId = e.CommandArgument.ToString();

            switch (cmd)
            {
                case "join":
                    JoinRoom(roomId);
                    break;
            }
        }

        private void JoinRoom(string roomId)
        {
            Response.Redirect("room.aspx?roomId=" + roomId);
        }

        protected void btnJoin_Command(object sender, CommandEventArgs e)
        {
            JoinRoom(e.CommandArgument.ToString());
        }
    }
}