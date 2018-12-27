using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace JunkDBWinForms
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void table1BindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.table1BindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.junkDBDataSet);

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'junkDBDataSet.Table2' table. You can move, or remove it, as needed.
            this.table2TableAdapter.Fill(this.junkDBDataSet.Table2);
            // TODO: This line of code loads data into the 'junkDBDataSet.Table1' table. You can move, or remove it, as needed.
            this.table1TableAdapter.Fill(this.junkDBDataSet.Table1);

        }
    }
}
