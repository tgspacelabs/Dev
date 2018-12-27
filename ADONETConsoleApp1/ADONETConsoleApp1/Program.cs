using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ADONETConsoleApp1
{
    class Program
    {
        static string connectionString =
            "Data Source=(local);Initial Catalog=AdventureWorks2012;"
            + "Integrated Security=true;";
        //static string connectionString =
        //    "Data Source=per730xd.devtest.local;Initial Catalog=AdventureWorks2012;"
        //    + "Integrated Security=true;";

        static void Main(string[] args)
        {
            Console.WriteLine(@"{0} - START TIME", DateTime.Now.ToString(@"MM/dd/yyyy HH:mm:ss.fffffff"));
            Console.WriteLine(@"");

            WriteTest();

            //ReadTest();
        }

        private static void ReadTest()
        {
            bool showOutput = false;
            DateTime startTime = DateTime.Now;
            Int64 totalBytes = 0;
            int rowCount = 0;

            // Provide the query string with a parameter placeholder.
            string queryString1 =
                "SELECT [p].[BusinessEntityID],[p].[PersonType],[p].[NameStyle],[p].[Title],[p].[FirstName],[p].[MiddleName],[p].[LastName],"
                    + "[p].[Suffix],[p].[EmailPromotion],[p].[AdditionalContactInfo],[p].[Demographics],[p].[rowguid],[p].[ModifiedDate],[PersonID],[ufnGetContactInformation].[FirstName],[ufnGetContactInformation].[LastName],[JobTitle],[BusinessEntityType] "
                    + "FROM [Person].[Person] AS [p] CROSS APPLY[dbo].[ufnGetContactInformation]([p].[BusinessEntityID]);";
            string queryString2 =
                "SELECT [SalesOrderHeaderEnlarged].[SalesOrderID], [RevisionNumber], [OrderDate], [DueDate], [ShipDate], [Status], [OnlineOrderFlag], [SalesOrderNumber], [PurchaseOrderNumber], [AccountNumber], [CustomerID], [SalesPersonID], [TerritoryID], "
                + "[BillToAddressID], [ShipToAddressID], [ShipMethodID], [CreditCardID], [CreditCardApprovalCode], [CurrencyRateID], [SubTotal], [TaxAmt], [Freight], [TotalDue], [Comment], [SalesOrderHeaderEnlarged].[rowguid], [SalesOrderHeaderEnlarged].[ModifiedDate], "
                + "[SalesOrderDetailEnlarged].[SalesOrderID], [SalesOrderDetailID], [CarrierTrackingNumber], [OrderQty], [ProductID], [SpecialOfferID], [UnitPrice], [UnitPriceDiscount], [LineTotal], [SalesOrderDetailEnlarged].[rowguid], [SalesOrderDetailEnlarged].[ModifiedDate] "
                + "FROM [Sales].[SalesOrderHeaderEnlarged] LEFT OUTER JOIN[Sales].[SalesOrderDetailEnlarged] ON [SalesOrderHeaderEnlarged].[SalesOrderID] = [SalesOrderDetailEnlarged].[SalesOrderID];";

            // Create and open the connection in a using block. This
            // ensures that all resources will be closed and disposed
            // when the code exits.
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Create the Command and Parameter objects.
                SqlCommand command = new SqlCommand(queryString2, connection);
                //command.Parameters.AddWithValue("@pricePoint", paramValue);

                // Open the connection in a try/catch block. 
                // Create and execute the DataReader, writing the result
                // set to the console window.
                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        rowCount++;

                        //Console.WriteLine("\t{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}\t{12}\t{13}\t{14}\t{15}\t{16}\t{17}",
                        //    reader[0], reader[1], reader[2], reader[3], reader[4], reader[5],
                        //    reader[6], reader[7], reader[8], reader[9], reader[10], reader[11],
                        //    reader[12], reader[13], reader[14], reader[15], reader[16], reader[17]
                        //    );

                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            totalBytes += reader[i].ToString().Length;

                            if (showOutput)
                            {
                                Console.Write("{0}\t", reader[i]);
                            }

                        }

                        if (showOutput)
                        {
                            Console.WriteLine("");
                        }

                        if (rowCount % 10000 == 0)
                        {
                            Console.Write("\r{0} - Rows: {1}", DateTime.Now.ToString(@"MM/dd/yyyy HH:mm:ss.fffffff"), rowCount);
                        }
                    }

                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }

                Console.WriteLine("");
                Console.WriteLine("Total rows read: {0}", rowCount);
                Console.WriteLine("Total bytes: {0}", totalBytes);
                TimeSpan timeSpan = DateTime.Now - startTime;
                Console.WriteLine("Total elapsed time: {0}", timeSpan);
                Console.WriteLine("Bytes per second: {0}", totalBytes / timeSpan.TotalSeconds);
                Console.ReadLine();
            }
        }

        private static void WriteTest()
        {
            bool showOutput = false;
            DateTime startTime = DateTime.Now;
            Int64 totalBytes = 0;
            Int64 rowCount = 0;

            // Provide the query string with a parameter placeholder.
            string queryString1 =
                "SELECT [p].[BusinessEntityID],[p].[PersonType],[p].[NameStyle],[p].[Title],[p].[FirstName],[p].[MiddleName],[p].[LastName],"
                    + "[p].[Suffix],[p].[EmailPromotion],[p].[AdditionalContactInfo],[p].[Demographics],[p].[rowguid],[p].[ModifiedDate],[PersonID],[ufnGetContactInformation].[FirstName],[ufnGetContactInformation].[LastName],[JobTitle],[BusinessEntityType] "
                    + "FROM [Person].[Person] AS [p] CROSS APPLY[dbo].[ufnGetContactInformation]([p].[BusinessEntityID]);";
            string queryString2 =
                "SELECT [SalesOrderHeaderEnlarged].[SalesOrderID], [RevisionNumber], [OrderDate], [DueDate], [ShipDate], [Status], [OnlineOrderFlag], [SalesOrderNumber], [PurchaseOrderNumber], [AccountNumber], [CustomerID], [SalesPersonID], [TerritoryID], "
                + "[BillToAddressID], [ShipToAddressID], [ShipMethodID], [CreditCardID], [CreditCardApprovalCode], [CurrencyRateID], [SubTotal], [TaxAmt], [Freight], [TotalDue], [Comment], [SalesOrderHeaderEnlarged].[rowguid], [SalesOrderHeaderEnlarged].[ModifiedDate], "
                + "[SalesOrderDetailEnlarged].[SalesOrderID], [SalesOrderDetailID], [CarrierTrackingNumber], [OrderQty], [ProductID], [SpecialOfferID], [UnitPrice], [UnitPriceDiscount], [LineTotal], [SalesOrderDetailEnlarged].[rowguid], [SalesOrderDetailEnlarged].[ModifiedDate] "
                + "FROM [Sales].[SalesOrderHeaderEnlarged] LEFT OUTER JOIN[Sales].[SalesOrderDetailEnlarged] ON [SalesOrderHeaderEnlarged].[SalesOrderID] = [SalesOrderDetailEnlarged].[SalesOrderID];";

            string insertString1 = @"
INSERT INTO[Sales].[SalesOrderHeaderEnlarged]
        ([RevisionNumber],
         [OrderDate],
         [DueDate],
         [ShipDate],
         [Status],
         [OnlineOrderFlag],
         [PurchaseOrderNumber],
         [AccountNumber],
         [CustomerID],
         [SalesPersonID],
         [TerritoryID],
         [BillToAddressID],
         [ShipToAddressID],
         [ShipMethodID],
         [CreditCardID],
         [CreditCardApprovalCode],
         [CurrencyRateID],
         [SubTotal],
         [TaxAmt],
         [Freight],
         [Comment],
         [rowguid],
         [ModifiedDate])
VALUES
";

            string valuesString2 = @"
    (99, --RevisionNumber - tinyint
     GETDATE(), --OrderDate - datetime
     GETDATE(), --DueDate - datetime
     GETDATE(), --ShipDate - datetime
     0, --Status - tinyint
     1, --OnlineOrderFlag - Flag
     'PO18444174044-99999', --PurchaseOrderNumber - OrderNumber
     '10-4020-000510-', --AccountNumber - AccountNumber
     29580, --CustomerID - int
     280, --SalesPersonID - int
     5, --TerritoryID - int
     1000, --BillToAddressID - int
     900, --ShipToAddressID - int
     5, --ShipMethodID - int
     10370, --CreditCardID - int
     '35568Vi78804-99', --CreditCardApprovalCode - varchar(15)
     4, --CurrencyRateID - int
     9999.99, --SubTotal - money
     99.99, --TaxAmt - money
     199.99, --Freight - money
     N'This is a test value for performance testing of inserts into a table.', --Comment - nvarchar(128)
     NEWID(), --rowguid - uniqueidentifier
     GETDATE()-- ModifiedDate - datetime
     )
     ";

            // Specify the parameter value.
            //int paramValue = 5;

            const int multipleRowCount = 10;

            // Create and open the connection in a using block. This
            // ensures that all resources will be closed and disposed
            // when the code exits.
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Create the Command and Parameter objects.
                string values = string.Concat(string.Join(@",", Enumerable.Repeat(valuesString2, multipleRowCount)));
                SqlCommand command = new SqlCommand(insertString1 + values, connection);
                //command.Parameters.AddWithValue("@pricePoint", paramValue);

                // Open the connection in a try/catch block. 
                // Create and execute the DataReader, writing the result
                // set to the console window.
                try
                {
                    connection.Open();

                    for (rowCount = 0; rowCount < 5000000; rowCount += multipleRowCount)
                    {
                        command.ExecuteNonQuery();

                        if (rowCount % 1000 == 0)
                        {
                            Console.Write("\r{0} - Rows: {1}", DateTime.Now.ToString(@"MM/dd/yyyy HH:mm:ss.fffffff"), rowCount);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }

                Console.WriteLine("");
                Console.WriteLine("Total rows written: {0}", rowCount);
                Console.WriteLine("Total bytes: {0}", totalBytes);
                TimeSpan timeSpan = DateTime.Now - startTime;
                Console.WriteLine("Total elapsed time: {0}", timeSpan);
                Console.WriteLine("Bytes per second: {0}", totalBytes / timeSpan.TotalSeconds);
                Console.ReadLine();
            }
        }
    }
}
