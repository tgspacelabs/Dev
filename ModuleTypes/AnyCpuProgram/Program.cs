using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AnyCpuProgram
{
    class Program
    {
        // AnyCpu -> AnyCpu, X86 - if Prefer 32-bit is set
        // AnyCpu -> AnyCpu, X64 - if Prefer 32-bit is not set
        // X86 -> AnyCpu, X86
        // X64 -> AnyCpu, X64

        static void Main(string[] args)
        {
            TryAnyCpu();

            TryX86();

            TryX64();

            Console.ReadLine();
        }

        private static void TryX64()
        {
            try
            {
                X64Library.Class1 x64Class1 = new X64Library.Class1();
                Console.WriteLine("IdentificationNumber: " + x64Class1.IdentificationNumber.ToString());
            }
            catch (Exception ex)
            {
                Console.WriteLine("X64Library exception");
            }
            finally { }
        }

        private static void TryX86()
        {
            try
            {
                X86Library.Class1 x86Class1 = new X86Library.Class1();
                Console.WriteLine("IdentificationNumber: " + x86Class1.IdentificationNumber.ToString());
            }
            catch (Exception ex)
            {
                Console.WriteLine("X86Library exception");
            }
            finally { }
        }

        private static void TryAnyCpu()
        {
            try
            {
                AnyCpuLibrary.Class1 anyClass1 = new AnyCpuLibrary.Class1();
                //Console.WriteLine("IdentificationNumber: $(anyClass1.IdentificationNumber)");
                Console.WriteLine("IdentificationNumber: " + anyClass1.IdentificationNumber.ToString());
            }
            catch (Exception ex)
            {
                Console.WriteLine("AnyCpuLibrary exception");
            }
            finally { }
        }
    }
}
