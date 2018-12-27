using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FileStreamImageViewer
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            LoadImageFromDatabase();
        }

        private void LoadImageFromDatabase()
        {
            // Create a connection to the database
            string ConStr = @"Data Source=(local);Initial Catalog=NorthPole;Integrated Security=True";
            SqlConnection conn = new SqlConnection(ConStr);
            conn.Open();

            // Retrieve the FilePath() of the image file
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Connection = conn;
            sqlcmd.CommandText = @"SELECT [ItemImage] FROM [dbo].[Items] WHERE [ItemNumber] = 'MS1001';";
            byte[] buffer = (byte[])sqlcmd.ExecuteScalar();

            // Bind the image data to an image control
            MemoryStream ms = new MemoryStream(buffer);
            Bitmap bmp = new Bitmap(ms);
            pictureBox1.Image = bmp;

            // Cleanup
            conn.Close();
        }

        private void SqlFileStreamTest()
        {
            // Create a connection to the database
            string ConStr = @"Data Source=(local);Initial Catalog=NorthPole;Integrated Security=True";
            SqlConnection con = new SqlConnection(ConStr);
            con.Open();

            // Retrieve the FilePath() of the image file
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = con;
            sqlCmd.CommandText = "SELECT [ItemImage].PathName() AS [PathName] FROM [dbo].[Items] WHERE [ItemNumber] = 'MS1001';";
            string filePath = (string)sqlCmd.ExecuteScalar();

            // Obtain a Transaction Context
            SqlTransaction transaction = con.BeginTransaction("ItemTran");
            sqlCmd.Transaction = transaction;
            sqlCmd.CommandText = "SELECT GET_FILESTREAM_TRANSACTION_CONTEXT()";
            byte[] txContext = (byte[])sqlCmd.ExecuteScalar();

            // Open and read file using SqlFileStream Class
            SqlFileStream sqlFileStream = new SqlFileStream(filePath, txContext, FileAccess.Read);
            byte[] buffer = new byte[sqlFileStream.Length];
            sqlFileStream.Read(buffer, 0, buffer.Length);

            // Bind the image data to an image control
            MemoryStream ms = new MemoryStream(buffer);
            Bitmap bmp = new Bitmap(ms);
            pictureBox1.Image = bmp;

            // Cleanup
            sqlFileStream.Close();
            sqlCmd.Transaction.Commit();
            con.Close();
        }
    }
}
