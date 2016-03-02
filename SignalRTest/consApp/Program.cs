using myTest;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNet.SignalR.Client;
using Microsoft.AspNet.SignalR;

namespace consApp
{
    class Program
    {
        private const string ServiceUri = "http://localhost:12722/echo";
        static void Main(string[] args)
        {
            var connection = new myTest.Connection(ServiceUri, "name=dzy");
            connection.Received += connection_Received;
            connection.StateChanged += connection_StateChanged;
            Console.WriteLine("Connecting...");
            connection.Start().Wait();
            string inputMsg;
            while (!string.IsNullOrEmpty(inputMsg = Console.ReadLine()))
            {
                connection.Send(inputMsg).Wait();
            }
            connection.Stop();
        }

        static void connection_StateChanged(StateChange state)
        {
            if (state.NewState == ConnectionState.Connected)
            {
                Console.WriteLine("Connected.");
            }
        }
        static void connection_Received(string data)
        {
            Console.WriteLine(data);
        }
    }
}
