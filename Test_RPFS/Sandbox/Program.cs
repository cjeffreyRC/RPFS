using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sandbox
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime dt = new DateTime(2016, 03, 16, 18, 09, 37);
            
            Console.WriteLine(dt.DayOfWeek + " " + dt.ToLongDateString() + " " + dt.ToShortTimeString());
            Console.ReadLine();
        }
    }
}
