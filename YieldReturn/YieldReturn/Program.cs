using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YieldReturn
{
    class Program
    {
        static void Main(string[] args)
        {
            var invoices = GetInvoices();
            DoubleAmounts(invoices);

            Console.WriteLine(invoices.First().Amount);

            Console.ReadLine();
        }
        static IEnumerable<Invoice> GetInvoices()
        {
            for (var i = 1; i < 11; i++)
                yield return new Invoice { Amount = i * 10 };
        }

        static void DoubleAmounts(IEnumerable<Invoice> invoices)
        {
            foreach (var invoice in invoices)
                invoice.Amount = invoice.Amount * 2;
        }

        class Invoice
        {
            public int Amount { get; set; }
        }
    }
}
