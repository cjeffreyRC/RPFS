using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Testing
{
    class Program
    {
        static void Main(string[] args)
        {
            StreamReader sr = new StreamReader(@"C:\Users\Chris\Desktop\Repositories\RPFS\RPWeb\RPWeb\Spreadsheets\test_basketball.csv");
            int row = 0;
            while (!sr.EndOfStream)
            {
                row++;
                Console.WriteLine("Row " + row + ": ");
                string playerLine = sr.ReadLine();

                string[] playerInfo = playerLine.Split(';');
                for (int x = 0; x < playerInfo.Length; x++)
                {
                    Console.WriteLine("Col " + x + ": " + playerInfo[x]);
                }
                Console.WriteLine("");
            }
            Console.ReadLine();
        }
    }
}
