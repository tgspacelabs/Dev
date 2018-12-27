using System.Windows.Forms;
using WindowsFormsApplicationLocalization.Properties;

namespace WindowsFormsApplicationLocalization
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, System.EventArgs e)
        {
            MessageBox.Show(this, button1.Name + Resources.Clicked, Resources.LookAtMe, MessageBoxButtons.OKCancel, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
        }

        private void button2_Click(object sender, System.EventArgs e)
        {
            MessageBox.Show(this, button2.Name + Resources.Clicked, Resources.LookAtMe, MessageBoxButtons.OKCancel, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
        }
    }
}
