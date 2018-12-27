using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PSClassLibrary1
{
    public class Class1
    {
        public string GetTextString()
        {
            return @"This is a text string from PSClassLibrary1.Class1.GetTextString().";
        }

        public DataSet GetDataSet()
        {
            DataSet ds = new DataSet("PSTestDataSet");
            DataTable dt = CreateRowsWithItemArray();
            ds.Tables.Add(dt);

            return ds;
        }

        private DataTable CreateRowsWithItemArray()
        {
            // Make a DataTable using the function below.
            DataTable dt = MakeTableWithAutoIncrement();
            DataRow dr;

            // Declare the array variable.
            object[] rowArray = new object[2];

            // Create 10 new rows and add to DataRowCollection.
            for (int i = 0; i < 10; i++)
            {
                rowArray[0] = null;
                rowArray[1] = "item " + i;
                dr = dt.NewRow();
                dr.ItemArray = rowArray;
                dt.Rows.Add(dr);
            }

            return dt;
        }

        private DataTable MakeTableWithAutoIncrement()
        {
            // Make a table with one AutoIncrement column.
            DataTable table = new DataTable("table");

            DataColumn idColumn = new DataColumn("id",
                Type.GetType("System.Int32"));
            idColumn.AutoIncrement = true;
            idColumn.AutoIncrementSeed = 1;
            table.Columns.Add(idColumn);

            DataColumn itemColumn = new DataColumn("Item",
                Type.GetType("System.String"));
            table.Columns.Add(itemColumn);
            return table;
        }
    }
}
