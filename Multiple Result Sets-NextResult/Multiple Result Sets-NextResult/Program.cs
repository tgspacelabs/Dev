using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Multiple_Result_Sets_NextResult
{
    class Program
    {
        static void Main(string[] args)
        {
            string connectionString =
                "Data Source=(local);Initial Catalog=AdventureWorks2012;"
                + "Integrated Security=true";

            SqlConnection connection = new SqlConnection(connectionString);
            RetrieveMultipleResults(connection);

            Console.ReadLine();
        }

        static void RetrieveMultipleResults(SqlConnection connection)
        {
            using (connection)
            {
                SqlCommand command = new SqlCommand(
                  "SELECT [ProductCategoryID], [Name], [rowguid], [ModifiedDate] FROM [Production].[ProductCategory];"
                  //+ "SELECT TOP (10) [BusinessEntityID], [PersonType], [NameStyle], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [EmailPromotion], [AdditionalContactInfo], [Demographics], [rowguid], [ModifiedDate] FROM [Person].[Person];",
                  +"SELECT TOP (10) [BusinessEntityID], [PersonType], [NameStyle], [FirstName], [LastName] FROM [Person].[Person];",
                  connection);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                while (reader.HasRows)
                {
                    Console.WriteLine("\t{0}\t{1}\t{2}\t{3}",
                        reader.GetName(0),
                        reader.GetName(1),
                        reader.GetName(2),
                        reader.GetName(3));

                    while (reader.Read())
                    {
                        Console.WriteLine("\t{0}\t{1}\t{2}\t{3}",
                            reader.GetInt32(0),
                            reader.GetString(1),
                            reader.GetGuid(2),
                            reader.GetDateTime(3));
                    }

                    Console.WriteLine();

                    reader.NextResult();

                    Console.WriteLine("\t{0}\t{1}\t{2}\t{3}\t{4}",
                        reader.GetName(0),
                        reader.GetName(1),
                        reader.GetName(2),
                        reader.GetName(3),
                        reader.GetName(4));

                    while (reader.Read())
                    {
                        Console.WriteLine("\t{0}\t{1}\t{2}\t{3}\t{4}",
                            reader.GetInt32(0),
                            reader.GetString(1),
                            reader.GetBoolean(2),
                            reader.GetString(3),
                            reader.GetString(4));
                    }

                    reader.NextResult();
                }
            }
        }
    }
}
