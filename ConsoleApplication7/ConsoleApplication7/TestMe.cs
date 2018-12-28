using System;

namespace ITestMe
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
