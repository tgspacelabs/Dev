using System;

namespace ITestMe
{
    class Program
    {
        static void Main(string[] args)
        {
            ITestMe testMe = new TestMe();
            testMe.Display();

            Console.ReadLine();
        }
    }
}
