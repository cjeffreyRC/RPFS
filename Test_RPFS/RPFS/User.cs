using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using System.Data;

namespace RPFS
{
    public class User
    {
        private int userId;
        private string userEmail;
        private string userFirstName;
        private string userLastName;
        private int userTeamId;

        public User()
        {
            userId = -1;
            userEmail = "";
            userFirstName = "";
            userLastName = "";
            userTeamId = -1;
        }
        public User(int userId)
        {
            DAL d = new DAL();
            d.AddParam("userId", userId);
            DataRow dr = d.ExecuteProcedure("spGetUser").Tables[0].Rows[0];

            this.userId = userId;
            userEmail = dr[1].ToString();
            userFirstName = dr[2].ToString();
            userLastName = dr[3].ToString();
            userTeamId = Convert.ToInt32(dr[4]);
        }

        public int getUserId()
        {
            return this.userId;
        }
        public string getUserEmail()
        {
            return this.userEmail;
        }
        public string getUserName()
        {
            return this.userFirstName + " " + userLastName;
        }
        public int getUserTeamId()
        {
            return this.userTeamId;
        }
    }
}
