using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DataAccessLayer;

namespace Sandbox
{
    class Program
    {
        static void Main(string[] args)
        {
            DAL d = new DAL();
            DataTable dt = d.ExecuteProcedure("spGetSports").Tables[0];
            int colCount = dt.Columns.Count;
            foreach (DataColumn dc in dt.Columns)
            {
                Console.Write(dc.ToString() + " | ");
            }
            Console.ReadLine();
            foreach (DataRow dr in dt.Rows)
            {
                for (int i = 0; i < colCount; i++)
                {
                    Console.Write(dr[i].ToString() + " | ");
                }
                Console.ReadLine();
            }

        }
    }
}
