using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerColumnstoreSample
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                Console.WriteLine("*** SQL Server Columnstore demo ***");

                // Build connection string
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
                //builder.DataSource = "PER730XD";   //  update me
                //builder.UserID = "sa";              //  update me
                //builder.Password = "Sl_service";      // update me
                //builder.DataSource = @"SNODRND0055\SS2K16";   //  update me
                builder.DataSource = @"PER730XD";   //  update me
                builder.UserID = "sa";              //  update me
                builder.Password = "Sl_service";      // update me
                builder.InitialCatalog = "master";

                // Connect to SQL
                Console.Write("Connecting to SQL Server ... ");
                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {
                    connection.Open();
                    Console.WriteLine("Done.");

                    // Create a sample database
                    Console.Write("Dropping and creating database 'SampleDB' ... ");
                    //String sql = "DROP DATABASE IF EXISTS [SampleDB]; CREATE DATABASE [SampleDB]";
                    string sql = @"
IF (DB_ID(N'SampleDB') IS NOT NULL)
BEGIN
    EXEC [msdb].[dbo].[sp_delete_database_backuphistory]
        @database_name = N'SampleDB';
    USE [master];
    ALTER DATABASE [SampleDB] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [SampleDB];
END;

DROP DATABASE IF EXISTS [SampleDB]; 
CREATE DATABASE [SampleDB]
 CONTAINMENT = NONE
 ON  PRIMARY ( NAME = N'SampleDB', FILENAME = N'F:\SQLDATA16\SampleDB.mdf' , SIZE = 4096000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024000KB )
 LOG ON ( NAME = N'SampleDB_log', FILENAME = N'F:\SQLDATA16\SampleDB_log.ldf' , SIZE = 4096000KB , MAXSIZE = UNLIMITED , FILEGROWTH = 1024000KB);
";
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.ExecuteNonQuery();
                        Console.WriteLine("Done.");
                    }

                    // Insert 5 million rows into the table 'Table_with_5M_rows'
                    Console.Write("Inserting 5 million rows into table 'Table_with_5M_rows'. This takes ~1 minute, please wait ... ");
                    StringBuilder sb = new StringBuilder();
                    sb.Append("USE SampleDB; ");
                    sb.Append("WITH a AS (SELECT * FROM (VALUES(1),(2),(3),(4),(5),(6),(7),(8),(9),(10)) AS a(a))");
                    sb.Append("SELECT TOP (50000000)");
                    sb.Append("ROW_NUMBER() OVER (ORDER BY a.a) AS OrderItemId ");
                    sb.Append(",a.a + b.a + c.a + d.a + e.a + f.a + g.a + h.a AS OrderId ");
                    sb.Append(",a.a * 10 AS Price ");
                    sb.Append(",CONCAT(a.a, N' ', b.a, N' ', c.a, N' ', d.a, N' ', e.a, N' ', f.a, N' ', g.a, N' ', h.a) AS ProductName ");
                    sb.Append("INTO dbo.Table_with_5M_rows ");
                    sb.Append("FROM a, a AS b, a AS c, a AS d, a AS e, a AS f, a AS g, a AS h;");
                    sql = sb.ToString();
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.ExecuteNonQuery();
                        Console.WriteLine("Done.");
                    }

                    // Execute SQL query without columnstore index
                    double elapsedTimeWithoutIndex = SumPrice(connection);
                    Console.WriteLine("Query time WITHOUT columnstore index: " + elapsedTimeWithoutIndex + "ms");

                    // Add a Columnstore Index
                    Console.Write("Adding a columnstore to table 'Table_with_5M_rows'  ... ");
                    sql = "CREATE CLUSTERED COLUMNSTORE INDEX columnstoreindex ON dbo.Table_with_5M_rows;";
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.ExecuteNonQuery();
                        Console.WriteLine("Done.");
                    }

                    // Execute the same SQL query again after columnstore index was added
                    double elapsedTimeWithIndex = SumPrice(connection);
                    Console.WriteLine("Query time WITH columnstore index: " + elapsedTimeWithIndex + "ms");

                    // Calculate performance gain from adding columnstore index
                    Console.WriteLine("Performance improvement with columnstore index: "
                        + Math.Round(elapsedTimeWithoutIndex / elapsedTimeWithIndex) + "x!");
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }


            Console.WriteLine("All done. Press any key to finish...");
            Console.ReadKey(true);
        }

        public static double SumPrice(SqlConnection connection)
        {
            String sql = "SELECT SUM(Price) FROM dbo.Table_with_5M_rows;";
            long startTicks = DateTime.Now.Ticks;
            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                try
                {
                    var sum = command.ExecuteScalar();
                    TimeSpan elapsed = TimeSpan.FromTicks(DateTime.Now.Ticks) - TimeSpan.FromTicks(startTicks);
                    return elapsed.TotalMilliseconds;
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.ToString());
                }
            }
            return 0;
        }
    }
}