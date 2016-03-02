using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SignalR_MVC.Startup))]
namespace SignalR_MVC
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            app.MapSignalR();
        }
    }
}
