using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.IO;
using System.Globalization;

namespace ADONETConnectionTest1
{
    class Program
    {
        const string ConnectionString = @"Data Source=(local);Initial Catalog=AdventureWorks2012;Integrated Security=SSPI;Application Name=ADONETConnectionTest1";

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA2204:Literals should be spelled correctly", MessageId = "BigTransactionHistory")]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA2204:Literals should be spelled correctly", MessageId = "BigProduct")]
        static void Main(/*string[] args*/)
        {
            SqlConnectionStringBuilder connBuilder = new SqlConnectionStringBuilder();
            connBuilder.DataSource = @"(local)";
            connBuilder.InitialCatalog = @"AdventureWorks2012";
            connBuilder.IntegratedSecurity = true;
            connBuilder.ApplicationName = @"ADNONETTest1";

            DateTime startTime = DateTime.Now;

            ReadPerson();

            ReadProduct();

            Console.WriteLine();
            Console.WriteLine("Read Person, Read Product - Elapsed Time: {0}", DateTime.Now - startTime);


            startTime = DateTime.Now;

            ReadPersonProduct();

            Console.WriteLine();
            Console.WriteLine("Read Person Product - Elapsed Time: {0}", DateTime.Now - startTime);


            startTime = DateTime.Now;

            ReadBigProduct();

            Console.WriteLine();
            Console.WriteLine("Read BigProduct - Elapsed Time: {0}", DateTime.Now - startTime);


            startTime = DateTime.Now;

            ReadBigTransactionHistory();

            Console.WriteLine();
            Console.WriteLine("Read BigTransactionHistory - Elapsed Time: {0}", DateTime.Now - startTime);


            Console.ReadLine();
        }

        private static void ReadPersonProduct()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(@"SELECT [BusinessEntityID], [PersonType], [NameStyle], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [EmailPromotion], [AdditionalContactInfo], [Demographics], [rowguid], [ModifiedDate] FROM [Person].[Person];", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader(System.Data.CommandBehavior.SingleResult))
                    {
                        while (reader.Read())
                        {
                            Stream stream = Stream.Null;
                            string formatted = String.Format(CultureInfo.CurrentCulture, @"{0} - {1} {2}", reader[@"BusinessEntityID"], reader[@"FirstName"], reader[@"LastName"]);
                            byte[] buffer = Encoding.ASCII.GetBytes(formatted.ToCharArray());
                            stream.Write(buffer, 0, buffer.Length);

                            //Console.WriteLine(reader[@"BusinessEntityID"].ToString() + @" - " + reader[@"FirstName"] + @" " + reader[@"LastName"]);
                        }
                    }
                }

                using (SqlCommand cmd = new SqlCommand(@"SELECT [ProductID], [Name], [ProductNumber], [MakeFlag], [FinishedGoodsFlag], [Color], [SafetyStockLevel], [ReorderPoint], [StandardCost], [ListPrice], [Size], [SizeUnitMeasureCode], [WeightUnitMeasureCode], [Weight], [DaysToManufacture], [ProductLine], [Class], [Style], [ProductSubcategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [rowguid], [ModifiedDate] FROM [Production].[Product];", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader(System.Data.CommandBehavior.SingleResult))
                    {
                        while (reader.Read())
                        {
                            Stream stream = Stream.Null;
                            string formatted = String.Format(CultureInfo.CurrentCulture, @"{0} - {1}", reader[@"ProductID"], reader[@"Name"]);
                            byte[] buffer = Encoding.ASCII.GetBytes(formatted.ToCharArray());
                            stream.Write(buffer, 0, buffer.Length);

                            //Console.WriteLine(reader[@"ProductID"].ToString() + @" - " + reader[@"Name"]);
                        }
                    }
                }
            }
        }

        private static void ReadPerson()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(@"SELECT [BusinessEntityID], [PersonType], [NameStyle], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [EmailPromotion], [AdditionalContactInfo], [Demographics], [rowguid], [ModifiedDate] FROM [Person].[Person];", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader(System.Data.CommandBehavior.SingleResult))
                    {
                        while (reader.Read())
                        {
                            Stream stream = Stream.Null;
                            string formatted = String.Format(CultureInfo.CurrentCulture, @"{0} - {1} {2}", reader[@"BusinessEntityID"], reader[@"FirstName"], reader[@"LastName"]);
                            byte[] buffer = Encoding.ASCII.GetBytes(formatted.ToCharArray());
                            stream.Write(buffer, 0, buffer.Length);

                            //Console.WriteLine(reader[@"BusinessEntityID"].ToString() + @" - " + reader[@"FirstName"] + @" " + reader[@"LastName"]);
                        }
                    }
                }
            }
        }

        private static void ReadProduct()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(@"SELECT [ProductID], [Name], [ProductNumber], [MakeFlag], [FinishedGoodsFlag], [Color], [SafetyStockLevel], [ReorderPoint], [StandardCost], [ListPrice], [Size], [SizeUnitMeasureCode], [WeightUnitMeasureCode], [Weight], [DaysToManufacture], [ProductLine], [Class], [Style], [ProductSubcategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [rowguid], [ModifiedDate] FROM [Production].[Product];", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader(System.Data.CommandBehavior.SingleResult))
                    {
                        while (reader.Read())
                        {
                            Stream stream = Stream.Null;
                            string formatted = String.Format(CultureInfo.CurrentCulture, @"{0} - {1}", reader[@"ProductID"], reader[@"Name"]);
                            byte[] buffer = Encoding.ASCII.GetBytes(formatted.ToCharArray());
                            stream.Write(buffer, 0, buffer.Length);

                            //Console.WriteLine(reader[@"ProductID"].ToString() + @" - " + reader[@"Name"]);
                        }
                    }
                }
            }
        }

        private static void ReadBigProduct()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(@"SELECT [ProductID], [Name], [ProductNumber], [MakeFlag], [FinishedGoodsFlag], [Color], [SafetyStockLevel], [ReorderPoint], [StandardCost], [ListPrice], [Size], [SizeUnitMeasureCode], [WeightUnitMeasureCode], [Weight], [DaysToManufacture], [ProductLine], [Class], [Style], [ProductSubcategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate] FROM [dbo].[BigProduct];", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader(System.Data.CommandBehavior.SingleResult))
                    {
                        while (reader.Read())
                        {
                            Stream stream = Stream.Null;
                            string formatted = String.Format(CultureInfo.CurrentCulture, @"{0} - {1}", reader[@"ProductID"], reader[@"Name"]);
                            byte[] buffer = Encoding.ASCII.GetBytes(formatted.ToCharArray());
                            stream.Write(buffer, 0, buffer.Length);

                            //Console.WriteLine(reader[@"ProductID"].ToString() + @" - " + reader[@"Name"]);
                        }
                    }
                }
            }
        }

        private static void ReadBigTransactionHistory() {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(@"SELECT [TransactionID], [ProductID], [TransactionDate], [Quantity], [ActualCost], [Filler] FROM [dbo].[bigTransactionHistory];", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader(System.Data.CommandBehavior.SingleResult))
                    {
                        while (reader.Read())
                        {
                            Stream stream = Stream.Null;
                            string formatted = String.Format(CultureInfo.CurrentCulture, @"{0} - {1} - {2}", reader[@"TransactionID"], reader[@"ProductID"], reader[@"TransactionDate"]);
                            byte[] buffer = Encoding.ASCII.GetBytes(formatted.ToCharArray());
                            stream.Write(buffer, 0, buffer.Length);

                            //Console.WriteLine(reader[@"TransactionID"].ToString() + @" - " + reader[@"ProductID"]);
                        }
                    }
                }
            }
        }
    }
}
