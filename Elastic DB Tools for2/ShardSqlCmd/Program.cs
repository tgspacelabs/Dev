/*
    Copyright 2014 Microsoft, Corp.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Microsoft.Azure.SqlDatabase.ElasticScale.Query;
using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;

namespace ShardSqlCmd
{
    internal static class Program
    {
        private static CommandLine commandLine;

        public static void Main(string[] args)
        {
            try
            {
                // Parse command line arguments
                commandLine = new CommandLine(args);
                if (!commandLine.IsValid)
                {
                    commandLine.WriteUsage();
                    return;
                }

                // Get Shard Map Manager
                ShardMapManager smm = ShardMapManagerFactory.GetSqlShardMapManager(
                    GetConnectionString(), ShardMapManagerLoadPolicy.Eager);
                Console.WriteLine("Connected to Shard Map Manager");

                // Get Shard Map
                ShardMap map = smm.GetShardMap(commandLine.ShardMap);
                Console.WriteLine("Found {0} shards", map.GetShards().Count());

                // Create connection string for MultiShardConnection
                string connectionString = GetCredentialsConnectionString();

                // REPL
                Console.WriteLine();
                while (true)
                {
                    // Read command from console
                    string commandText = GetCommand();
                    if (commandText == null)
                    {
                        // Exit requested
                        break;
                    }

                    // Evaluate command
                    string output;
                    using (MultiShardConnection conn = new MultiShardConnection(map.GetShards(), connectionString))
                    {
                        output = ExecuteCommand(conn, commandText);
                    }

                    // Print output
                    Console.WriteLine(output);
                }
            }
            catch (Exception e)
            {
                // Print exception and exit
                Console.WriteLine(e);
                return;
            }
        }

        /// <summary>
        /// Reads the next SQL command text from the console.
        /// </summary>
        private static string GetCommand()
        {
            StringBuilder sb = new StringBuilder();
            int lineNumber = 1;
            while (true)
            {
                Console.Write("{0}> ", lineNumber);

                string line = Console.ReadLine().Trim();

                switch (line.ToUpperInvariant())
                {
                    case "GO":
                        if (sb.Length == 0)
                        {
                            // "go" with empty command - reset line number
                            lineNumber = 1;
                        }
                        else
                        {
                            return sb.ToString();
                        }

                        break;

                    case "EXIT":
                        return null;

                    default:
                        if (!string.IsNullOrWhiteSpace(line))
                        {
                            sb.AppendLine(line);
                        }

                        lineNumber++;
                        break;
                }
            }
        }

        /// <summary>
        /// Executes the SQL command and returns the output in text format.
        /// </summary>
        private static string ExecuteCommand(MultiShardConnection conn, string commandText)
        {
            try
            {
                StringBuilder output = new StringBuilder();
                output.AppendLine();

                int rowsAffected = 0;

                Stopwatch sw;

                using (MultiShardCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = commandText;
                    cmd.CommandTimeout = commandLine.QueryTimeout;
                    cmd.CommandTimeoutPerShard = commandLine.QueryTimeout;

                    // Execute command and time with a stopwatch
                    sw = Stopwatch.StartNew();
                    cmd.ExecutionPolicy = commandLine.ExecutionPolicy;
                    cmd.ExecutionOptions = commandLine.ExecutionOptions;
                    using (MultiShardDataReader reader = cmd.ExecuteReader(CommandBehavior.Default))
                    {
                        sw.Stop();

                        // Get column names
                        IEnumerable<string> columnNames = GetColumnNames(reader).ToArray();

                        // Create table formatter
                        TableFormatter tableFormatter = new TableFormatter(columnNames.ToArray());

                        // Read results from db
                        while (reader.Read())
                        {
                            rowsAffected++;

                            // Add the row to the table formatter
                            object[] values = new object[reader.FieldCount];
                            reader.GetValues(values);
                            tableFormatter.AddRow(values);
                        }

                        // Write formatter output
                        output.AppendLine(tableFormatter.ToString());
                    }
                }

                output.AppendLine();
                output.AppendFormat("({0} rows affected - {1:hh}:{1:mm}:{1:ss} elapsed)", rowsAffected, sw.Elapsed);
                output.AppendLine();

                return output.ToString();
            }
            catch (MultiShardAggregateException e)
            {
                return e.ToString();
            }
        }

        /// <summary>
        /// Gets the column names from a data reader.
        /// </summary>
        private static IEnumerable<string> GetColumnNames(DbDataReader reader)
        {
            List<string> columnNames = new List<string>();
            foreach (DataRow r in reader.GetSchemaTable().Rows)
            {
                columnNames.Add(r[SchemaTableColumn.ColumnName].ToString());
            }

            return columnNames;
        }

        #region Command line parsing

        private class CommandLine
        {
            // Values that are read from the command line
            public string UserName { get; private set; }

            public string Password { get; private set; }

            public string ServerName { get; private set; }

            public string DatabaseName { get; private set; }

            public string ShardMap { get; private set; }

            public bool UseTrustedConnection { get; private set; }

            public MultiShardExecutionPolicy ExecutionPolicy { get; private set; }

            public MultiShardExecutionOptions ExecutionOptions { get; private set; }

            public int QueryTimeout { get; private set; }

            /// <summary>
            /// Gets a value indicating whether the command line is valid, i.e. parsing it succeeded.
            /// </summary>
            public bool IsValid
            {
                get
                {
                    // Verify that a correct combination of parameters were provided
                    return this.ServerName != null &&
                           this.DatabaseName != null &&
                           this.ShardMap != null &&
                           (this.UseTrustedConnection ||
                            (this.UserName != null && this.Password != null)) &&
                            !this.parseErrors;
                }
            }

            /// <summary>
            /// True if there were any errors while parsing.
            /// </summary>
            private bool parseErrors = false;

            /// <summary>
            /// Initializes a new instance of the <see cref="CommandLine" /> class and parses the provided arguments.
            /// </summary>
            public CommandLine(string[] args)
            {
                // Default values
                this.QueryTimeout = 60;
                this.ExecutionPolicy = MultiShardExecutionPolicy.CompleteResults;
                this.ExecutionOptions = MultiShardExecutionOptions.None;

                this.args = args;
                this.ParseInternal();
            }

            // Parsing state variables
            private readonly string[] args;
            private int parseIndex;

            /// <summary>
            /// Parses the given command line. Returns true for success.
            /// </summary>
            private void ParseInternal()
            {
                this.parseIndex = 0;

                string arg;
                while ((arg = this.GetNextArg()) != null)
                {
                    switch (arg)
                    {
                        case "-S": // Server
                            this.ServerName = this.GetNextArg();
                            break;

                        case "-d": // Shard Map Manager database
                            this.DatabaseName = this.GetNextArg();
                            break;

                        case "-sm": // Shard map
                            this.ShardMap = this.GetNextArg();
                            break;

                        case "-U": // User name
                            this.UserName = this.GetNextArg();
                            break;

                        case "-P": // Password
                            this.Password = this.GetNextArg();
                            break;

                        case "-E": // Use trusted connection (aka Windows Authentication)
                            this.UseTrustedConnection = true;
                            break;

                        case "-t": // Query timeout
                            string queryTimeoutString = this.GetNextArg();
                            if (queryTimeoutString != null)
                            {
                                int parsedQueryTimeout;
                                bool parseSuccess = int.TryParse(queryTimeoutString, out parsedQueryTimeout);
                                if (parseSuccess)
                                {
                                    this.QueryTimeout = parsedQueryTimeout;
                                }
                                else
                                {
                                    this.parseErrors = true;
                                }
                            }

                            break;

                        case "-pr": // Partial results
                            this.ExecutionPolicy = MultiShardExecutionPolicy.PartialResults;
                            break;

                        case "-sn": // $ShardName column
                            this.ExecutionOptions |= MultiShardExecutionOptions.IncludeShardNameColumn;
                            break;
                    }
                }
            }

            /// <summary>
            /// Returns the next argument, if it exists, and advances the index. Helper method for ParseInternal.
            /// </summary>
            private string GetNextArg()
            {
                string value = null;
                if (this.parseIndex < this.args.Length)
                {
                    value = this.args[this.parseIndex];
                }

                this.parseIndex++;
                return value;
            }

            /// <summary>
            /// Writes command line usage information to the console.
            /// </summary>
            public void WriteUsage()
            {
                Console.WriteLine(@"
Usage: 

ShardSqlCmd.exe
        -S  server
        -d  shard map manager database
        -sm shard map
        -U  login id
        -P  password
        -E  trusted connection
        -t  query timeout
        -pr PartialResults mode
        -sn include $ShardName column in results

  e.g.  ShardSqlCmd.exe -S myserver -d myshardmapmanagerdb -sm myshardmap -E
        ShardSqlCmd.exe -S myserver -d myshardmapmanagerdb -sm myshardmap -U mylogin -P mypasword
        ShardSqlCmd.exe -S myserver -d myshardmapmanagerdb -sm myshardmap -U mylogin -P mypasword -pr -sn
");
            }
        }

        #endregion

        #region Creating connection strings

        /// <summary>
        /// Returns a connection string that can be used to connect to the specified server and database.
        /// </summary>
        public static string GetConnectionString()
        {
            SqlConnectionStringBuilder connStr = new SqlConnectionStringBuilder(GetCredentialsConnectionString());
            connStr.DataSource = commandLine.ServerName;
            connStr.InitialCatalog = commandLine.DatabaseName;
            return connStr.ToString();
        }

        /// <summary>
        /// Returns a connection string containing just the credentials (i.e. UserID, Password, and IntegratedSecurity) to use for DDR and MSQ.
        /// </summary>
        public static string GetCredentialsConnectionString()
        {
            SqlConnectionStringBuilder connStr = new SqlConnectionStringBuilder
            {
                ApplicationName = "ESC_CMDv1.0",
                UserID = commandLine.UserName ?? string.Empty,
                Password = commandLine.Password ?? string.Empty,
                IntegratedSecurity = commandLine.UseTrustedConnection
            };
            return connStr.ToString();
        }

        #endregion
    }
}