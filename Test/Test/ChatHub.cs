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
        public void Send(string name, string message)
        {
            // Call the broadcastMessage method to update clients.
            DAL d = new DAL();
            d.AddParam("username", name);
            d.AddParam("message", message);
            d.ExecuteNonQuery("spSaveMessage");
            Clients.All.broadcastMessage(name, message);
        }

        public void SaveUser(string username)
        {
            DAL d = new DAL();
            d.AddParam("username", username);
            d.ExecuteNonQuery("spSaveUser");
        }
    }
}