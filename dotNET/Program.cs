using System;

namespace dotNET
{
    class Program
    {
        static void Main(string[] args)
        {
            HelloWorld wrld = new HelloWorld();
            Console.WriteLine(wrld.GetHelloMessage("Main"));
        }
    }
}
