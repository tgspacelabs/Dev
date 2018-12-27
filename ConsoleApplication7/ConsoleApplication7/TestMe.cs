using System;

namespace ConsoleApplication7
{
    class TestMe : ITestMe
    {
        void ITestMe.Display()
        {
            //throw new NotImplementedException();
            Console.WriteLine("void ITestMe.Display() implementation");
        }

        void ITestMe.Receive()
        {
            throw new NotImplementedException();
        }
    }
}
