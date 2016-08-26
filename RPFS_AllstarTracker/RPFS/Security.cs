using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;

namespace RPFS
{
    static public class Security
    {
        //private bool isLoggedIn;
        //public User currentUser;



        static public User Login(string userEmail, string userPassword,string ip)
        {
            DAL d = new DAL();
            d.AddParam("ip", ip);
            d.AddParam("userEmail", userEmail);
            d.AddParam("userPassword", userPassword);
            int userId = int.Parse(d.ExecuteScalar("spLogin"));
            User currentUser;

            if (userId != -1)
            {
                currentUser = new User(userId);
            }
            else
            {
                currentUser = new User();
            }
            return currentUser;
        }
    }
}
