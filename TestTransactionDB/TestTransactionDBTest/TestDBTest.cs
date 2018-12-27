using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Transactions;

namespace TestTransactionDBTest
{
    [TestClass()]
    public class TestTransactionDBTest : SqlDatabaseTestClass
    {

        public TestTransactionDBTest()
        {
            InitializeComponent();
        }

        [TestInitialize()]
        public void TestInitialize()
        {
            base.InitializeTest();
        }
        [TestCleanup()]
        public void TestCleanup()
        {
            base.CleanupTest();
        }

        #region Designer support code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction dbo_AddOneTableValueFunctionTest_0_1_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(TestTransactionDBTest));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition rowCountCondition1;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition scalarValueCondition1;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction dbo_AddOneTest_0_1_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition scalarValueCondition2;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction dbo_Proc1Test_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition rowCountCondition2;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition rowCountCondition3;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition checksumCondition1;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction dbo_Proc1Test_PretestAction;
            this.dbo_AddOneTableValueFunctionTest_0_1Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.dbo_AddOneTest_0_1Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.dbo_Proc1TestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            dbo_AddOneTableValueFunctionTest_0_1_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            rowCountCondition1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            scalarValueCondition1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            dbo_AddOneTest_0_1_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            scalarValueCondition2 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            dbo_Proc1Test_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            rowCountCondition2 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            rowCountCondition3 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            checksumCondition1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition();
            dbo_Proc1Test_PretestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            // 
            // dbo_AddOneTableValueFunctionTest_0_1_TestAction
            // 
            dbo_AddOneTableValueFunctionTest_0_1_TestAction.Conditions.Add(rowCountCondition1);
            dbo_AddOneTableValueFunctionTest_0_1_TestAction.Conditions.Add(scalarValueCondition1);
            resources.ApplyResources(dbo_AddOneTableValueFunctionTest_0_1_TestAction, "dbo_AddOneTableValueFunctionTest_0_1_TestAction");
            // 
            // rowCountCondition1
            // 
            rowCountCondition1.Enabled = true;
            rowCountCondition1.Name = "rowCountCondition1";
            rowCountCondition1.ResultSet = 1;
            rowCountCondition1.RowCount = 1;
            // 
            // scalarValueCondition1
            // 
            scalarValueCondition1.ColumnNumber = 1;
            scalarValueCondition1.Enabled = true;
            scalarValueCondition1.ExpectedValue = "1";
            scalarValueCondition1.Name = "scalarValueCondition1";
            scalarValueCondition1.NullExpected = false;
            scalarValueCondition1.ResultSet = 1;
            scalarValueCondition1.RowNumber = 1;
            // 
            // dbo_AddOneTest_0_1_TestAction
            // 
            dbo_AddOneTest_0_1_TestAction.Conditions.Add(scalarValueCondition2);
            resources.ApplyResources(dbo_AddOneTest_0_1_TestAction, "dbo_AddOneTest_0_1_TestAction");
            // 
            // scalarValueCondition2
            // 
            scalarValueCondition2.ColumnNumber = 1;
            scalarValueCondition2.Enabled = true;
            scalarValueCondition2.ExpectedValue = "1";
            scalarValueCondition2.Name = "scalarValueCondition2";
            scalarValueCondition2.NullExpected = false;
            scalarValueCondition2.ResultSet = 1;
            scalarValueCondition2.RowNumber = 1;
            // 
            // dbo_Proc1Test_TestAction
            // 
            dbo_Proc1Test_TestAction.Conditions.Add(rowCountCondition2);
            dbo_Proc1Test_TestAction.Conditions.Add(rowCountCondition3);
            dbo_Proc1Test_TestAction.Conditions.Add(checksumCondition1);
            resources.ApplyResources(dbo_Proc1Test_TestAction, "dbo_Proc1Test_TestAction");
            // 
            // rowCountCondition2
            // 
            rowCountCondition2.Enabled = true;
            rowCountCondition2.Name = "rowCountCondition2";
            rowCountCondition2.ResultSet = 1;
            rowCountCondition2.RowCount = 5;
            // 
            // rowCountCondition3
            // 
            rowCountCondition3.Enabled = true;
            rowCountCondition3.Name = "rowCountCondition3";
            rowCountCondition3.ResultSet = 2;
            rowCountCondition3.RowCount = 5;
            // 
            // checksumCondition1
            // 
            checksumCondition1.Checksum = "1063571958";
            checksumCondition1.Enabled = true;
            checksumCondition1.Name = "checksumCondition1";
            // 
            // dbo_Proc1Test_PretestAction
            // 
            resources.ApplyResources(dbo_Proc1Test_PretestAction, "dbo_Proc1Test_PretestAction");
            // 
            // dbo_AddOneTableValueFunctionTest_0_1Data
            // 
            this.dbo_AddOneTableValueFunctionTest_0_1Data.PosttestAction = null;
            this.dbo_AddOneTableValueFunctionTest_0_1Data.PretestAction = null;
            this.dbo_AddOneTableValueFunctionTest_0_1Data.TestAction = dbo_AddOneTableValueFunctionTest_0_1_TestAction;
            // 
            // dbo_AddOneTest_0_1Data
            // 
            this.dbo_AddOneTest_0_1Data.PosttestAction = null;
            this.dbo_AddOneTest_0_1Data.PretestAction = null;
            this.dbo_AddOneTest_0_1Data.TestAction = dbo_AddOneTest_0_1_TestAction;
            // 
            // dbo_Proc1TestData
            // 
            this.dbo_Proc1TestData.PosttestAction = null;
            this.dbo_Proc1TestData.PretestAction = dbo_Proc1Test_PretestAction;
            this.dbo_Proc1TestData.TestAction = dbo_Proc1Test_TestAction;
        }

        #endregion


        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        #endregion

        [TestMethod()]
        public void dbo_AddOneTableValueFunctionTest_0_1()
        {
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.RequiresNew))
            {
                SqlDatabaseTestActions testActions = this.dbo_AddOneTableValueFunctionTest_0_1Data;
                // Execute the pre-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
                SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
                try
                {
                    // Execute the test script
                    // 
                    System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                    SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
                }
                finally
                {
                    // Execute the post-test script
                    // 
                    System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                    SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
                }
            }
        }

        [TestMethod()]
        public void dbo_AddOneTest_0_1()
        {
            SqlDatabaseTestActions testActions = this.dbo_AddOneTest_0_1Data;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }

        [TestMethod()]
        public void dbo_Proc1Test()
        {
            // Ensure that the Distributed Transaction Coordinator (DTC) service is running before executing tests with transactions.
            // Transactions require a reference to System.Transactions

            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.RequiresNew))
            {
                this.ExecutionContext.Connection.EnlistTransaction(Transaction.Current);
                this.PrivilegedContext.Connection.EnlistTransaction(Transaction.Current);

                SqlDatabaseTestActions testActions = this.dbo_Proc1TestData;
                // Execute the pre-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
                SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
                try
                {
                    // Execute the test script
                    // 
                    System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                    SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
                }
                finally
                {
                    // Execute the post-test script
                    // 
                    System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                    SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
                }

                //Because the transaction is not explicitly committed, it
                //is rolled back when the ambient transaction is disposed.
                //To commit the transaction, remove the comment delimiter
                //from the following statement:
                //ts.Complete()
            }
        }
        private SqlDatabaseTestActions dbo_AddOneTableValueFunctionTest_0_1Data;
        private SqlDatabaseTestActions dbo_AddOneTest_0_1Data;
        private SqlDatabaseTestActions dbo_Proc1TestData;
    }
}
