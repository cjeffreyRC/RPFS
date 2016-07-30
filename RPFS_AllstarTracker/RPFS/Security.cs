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



        static public User Login(string userEmail, string userPassword)
        {
            DAL d = new DAL();
            d.AddParam("userEmail", userEmail);
            d.AddParam("userPassword", userPassword);
            int userId = int.Parse(d.ExecuteScalar("spLogin"));
            User currentUser;

            if (userId != -1)
            {
                //isLoggedIn = true;
                currentUser = new User(userId);
            }
            else
            {
                //isLoggedIn = false;
                currentUser = new User();
            }
            return currentUser;
        }
    }
}
