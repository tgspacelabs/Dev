using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace AdventureWorksOrdersViewer
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {

            AdventureWorksOrdersViewer.AdventureWorks2012DataSet adventureWorks2012DataSet = ((AdventureWorksOrdersViewer.AdventureWorks2012DataSet)(this.FindResource("adventureWorks2012DataSet")));
            // Load data into the table SalesOrderHeader. You can modify this code as needed.
            AdventureWorksOrdersViewer.AdventureWorks2012DataSetTableAdapters.SalesOrderHeaderTableAdapter adventureWorks2012DataSetSalesOrderHeaderTableAdapter = new AdventureWorksOrdersViewer.AdventureWorks2012DataSetTableAdapters.SalesOrderHeaderTableAdapter();
            adventureWorks2012DataSetSalesOrderHeaderTableAdapter.Fill(adventureWorks2012DataSet.SalesOrderHeader);
            System.Windows.Data.CollectionViewSource salesOrderHeaderViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("salesOrderHeaderViewSource")));
            salesOrderHeaderViewSource.View.MoveCurrentToFirst();
            // Load data into the table SalesOrderDetail. You can modify this code as needed.
            AdventureWorksOrdersViewer.AdventureWorks2012DataSetTableAdapters.SalesOrderDetailTableAdapter adventureWorks2012DataSetSalesOrderDetailTableAdapter = new AdventureWorksOrdersViewer.AdventureWorks2012DataSetTableAdapters.SalesOrderDetailTableAdapter();
            adventureWorks2012DataSetSalesOrderDetailTableAdapter.Fill(adventureWorks2012DataSet.SalesOrderDetail);
            System.Windows.Data.CollectionViewSource salesOrderHeaderSalesOrderDetailViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("salesOrderHeaderSalesOrderDetailViewSource")));
            salesOrderHeaderSalesOrderDetailViewSource.View.MoveCurrentToFirst();
        }
    }
}
