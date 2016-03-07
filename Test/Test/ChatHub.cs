using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using System.Data;

namespace Test
{
    public class ChatHub : Hub
    {
        public void Send(string userId, string message, string username)
        {
            // Call the broadcastMessage method to update clients.
            DAL d = new DAL();
            d.AddParam("userId", userId);
            d.AddParam("message", message);
            d.ExecuteNonQuery("spSaveMessage");
            Clients.All.broadcastMessage(username, message);
        }

        public void SaveUser(string username)
        {
            DAL d = new DAL();
            d.AddParam("username", username);
            Clients.Caller.setUserId(int.Parse(d.ExecuteScalar("spSaveUser")));
        }
    }
}