using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MultiRowInsert
{
    class Program
    {
        static void Main(string[] args)
        {
            #region Get Values

            //string[] array = { textBox1.Text + ":" + textBox5.Text, textBox2.Text + ":" + textBox6.Text, textBox3.Text + ":" + textBox7.Text, textBox4.Text + ":" + textBox8.Text };
            //string[] array = { { "Product 1', 101}, {"Product 2', 102}, {"Product 3', 103 } };

            //string product = "";
            //int qty = 0;
            DataTable dt = new DataTable();
            dt.Columns.Add("Product");
            dt.Columns.Add("Qty");
            //for (int i = 0; i < array.Length; i++)
            //{
            //    product = array[i].Substring(0, array[i].IndexOf(':'));
            //    qty = int.Parse(array[i].ToString().Substring(array[i].ToString().IndexOf(':') + 1));
            //dt.Rows.Add(product, qty);
            //dt.Rows.Add("Product x1", 1001);
            //dt.Rows.Add("Product x2", 1002);
            //dt.Rows.Add("Product x3", 1003);

            //dt.Rows.Add("Product x01", 2001);
            //dt.Rows.Add("Product x02", 2002);
            //dt.Rows.Add("Product x03", 2003);

            dt.Rows.Add("Product x001", 12001);
            dt.Rows.Add("Product x002", 12002);
            dt.Rows.Add("Product x003", 12003);
            //}

            #endregion

            string connect = "Data Source=localhost;Initial Catalog=JunkDB;Integrated Security=True";
            SqlConnection connection = new SqlConnection(connect);
            connection.Open();
            //string insert = "MultiInsertTVP";
            string insert = "[MultiInsert].[uspInsertProdQty]";
            SqlCommand command = new SqlCommand(insert, connection);
            SqlParameter parameter1 = new SqlParameter();
            //parameter1.ParameterName = "TVP";
            parameter1.ParameterName = "MultiProdQty";
            parameter1.Value = dt;
            parameter1.SqlDbType = SqlDbType.Structured;

            command.Parameters.Add(parameter1);
            command.CommandType = CommandType.StoredProcedure;

            command.ExecuteNonQuery();
            command.Dispose();

            connection.Close();
            connection.Dispose();
            //label5.Visible = true;
            //label5.Text = insert;
        }
    }
}
