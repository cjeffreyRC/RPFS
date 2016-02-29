using System;
using System.Threading.Tasks;
using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(signalR.Startup1))]

namespace signalR
{
    public class Startup1
    {
        public void Configuration(IAppBuilder app)
        {
            Microsoft.AspNet.SignalR.StockTicker.Startup.ConfigureSignalR(app);
            // For more information on how to configure your application, visit http://go.microsoft.com/fwlink/?LinkID=316888
        }
    }
}
