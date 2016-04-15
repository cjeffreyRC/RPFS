using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using DataAccessLayer;

namespace Drafter
{
    public class RoomHub : Hub
    {
        public void JoinRoom(int userId)
        {
            DAL d = new DAL();
            d.AddParam("userId", userId);            
            Clients.All.NewUserInRoom(d.ExecuteScalar("spGetUsername"));
        }

        
    }
}