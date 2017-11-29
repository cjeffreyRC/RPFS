using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Text.RegularExpressions;

namespace Testing
{
    class Program
    {
        static void Main(string[] args)
        {
            //StreamReader sr = new StreamReader(@"C:\Users\Chris\Desktop\Repositories\RPFS\RPWeb\RPWeb\Spreadsheets\test_basketball.csv");
            //int row = 0;
            //while (!sr.EndOfStream)
            //{
            //    row++;
            //    Console.WriteLine("Row " + row + ": ");
            //    string playerLine = sr.ReadLine();

            //    string[] playerInfo = playerLine.Split(';');
            //    for (int x = 0; x < playerInfo.Length; x++)
            //    {
            //        Console.WriteLine("Col " + x + ": " + playerInfo[x]);
            //    }
            //    Console.WriteLine("");
            //}
            //Console.ReadLine();
            while (true)
            {
                Console.WriteLine("Provide an example title of a csv file");
                if (Regex.IsMatch(Console.ReadLine(), "[^.]*[.]csv", RegexOptions.IgnoreCase))
                {
                    Console.WriteLine("Validated as CSV");
                }
                else
                {
                    Console.WriteLine("Invalid");
                }
                Console.WriteLine("Any key to try again...");
                Console.ReadLine();
                Console.Clear();
            }
        }
    }
}
