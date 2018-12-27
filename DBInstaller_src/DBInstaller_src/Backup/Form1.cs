using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.IO;
using System.Diagnostics;

namespace DBI
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		# region Declarations 
		private System.Windows.Forms.PictureBox pictureBox1;
		private System.Windows.Forms.GroupBox groupBox1;
		private System.Windows.Forms.Button btnCancel;
		private System.Windows.Forms.ComboBox cmbServList;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox txtUserName;
		private System.Windows.Forms.TextBox txtPass;
		private System.Windows.Forms.Button btnConn;
		// Create an SQLDMO application 
		SQLDMO.Application sqlApp = new SQLDMO.ApplicationClass(); 		 
		// Create an Server, which resembles to your actual server
		SQLDMO.SQLServer srv = new SQLDMO.SQLServerClass();  
		string strDatabaseName = "";	
		// Create Database
		SQLDMO.Database nDatabase = new SQLDMO.Database();
		// Create Data Files
		SQLDMO.DBFile nDBFileData = new SQLDMO.DBFile();
		// Create Log Files
		SQLDMO.LogFile nLogFile = new SQLDMO.LogFile();
		
		private System.Windows.Forms.TextBox txtDBName;
		private System.Windows.Forms.Label label4;
		string strYes="1";
		private System.Windows.Forms.RadioButton rb1;
		private System.Windows.Forms.RadioButton rb2;
		private System.Windows.Forms.ComboBox cmbDataName;
		private System.Windows.Forms.Button btnData;
		private System.Windows.Forms.TextBox txtServName;
		private System.Windows.Forms.RadioButton rbNetwork;
		private System.Windows.Forms.RadioButton rbLocal;
		private System.Windows.Forms.GroupBox gbLocation;
		private System.Windows.Forms.GroupBox gbAction;
		private System.Windows.Forms.ToolTip toolTip1;
		private System.ComponentModel.IContainer components;

		# endregion

		# region Constructor 

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			Application.EnableVisualStyles();
			Application.DoEvents();
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}
		# endregion

		# region Destructor

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		# endregion

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(Form1));
			this.pictureBox1 = new System.Windows.Forms.PictureBox();
			this.groupBox1 = new System.Windows.Forms.GroupBox();
			this.gbAction = new System.Windows.Forms.GroupBox();
			this.rb1 = new System.Windows.Forms.RadioButton();
			this.rb2 = new System.Windows.Forms.RadioButton();
			this.gbLocation = new System.Windows.Forms.GroupBox();
			this.rbLocal = new System.Windows.Forms.RadioButton();
			this.rbNetwork = new System.Windows.Forms.RadioButton();
			this.txtServName = new System.Windows.Forms.TextBox();
			this.btnData = new System.Windows.Forms.Button();
			this.cmbDataName = new System.Windows.Forms.ComboBox();
			this.label4 = new System.Windows.Forms.Label();
			this.txtPass = new System.Windows.Forms.TextBox();
			this.txtUserName = new System.Windows.Forms.TextBox();
			this.label3 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.label1 = new System.Windows.Forms.Label();
			this.cmbServList = new System.Windows.Forms.ComboBox();
			this.txtDBName = new System.Windows.Forms.TextBox();
			this.btnCancel = new System.Windows.Forms.Button();
			this.btnConn = new System.Windows.Forms.Button();
			this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
			this.groupBox1.SuspendLayout();
			this.gbAction.SuspendLayout();
			this.gbLocation.SuspendLayout();
			this.SuspendLayout();
			// 
			// pictureBox1
			// 
			this.pictureBox1.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
			this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
			this.pictureBox1.Location = new System.Drawing.Point(0, 0);
			this.pictureBox1.Name = "pictureBox1";
			this.pictureBox1.Size = new System.Drawing.Size(496, 68);
			this.pictureBox1.TabIndex = 0;
			this.pictureBox1.TabStop = false;
			// 
			// groupBox1
			// 
			this.groupBox1.Controls.Add(this.gbAction);
			this.groupBox1.Controls.Add(this.gbLocation);
			this.groupBox1.Controls.Add(this.txtServName);
			this.groupBox1.Controls.Add(this.btnData);
			this.groupBox1.Controls.Add(this.cmbDataName);
			this.groupBox1.Controls.Add(this.label4);
			this.groupBox1.Controls.Add(this.txtPass);
			this.groupBox1.Controls.Add(this.txtUserName);
			this.groupBox1.Controls.Add(this.label3);
			this.groupBox1.Controls.Add(this.label2);
			this.groupBox1.Controls.Add(this.label1);
			this.groupBox1.Controls.Add(this.cmbServList);
			this.groupBox1.Controls.Add(this.txtDBName);
			this.groupBox1.Location = new System.Drawing.Point(0, 64);
			this.groupBox1.Name = "groupBox1";
			this.groupBox1.Size = new System.Drawing.Size(504, 272);
			this.groupBox1.TabIndex = 2;
			this.groupBox1.TabStop = false;
			// 
			// gbAction
			// 
			this.gbAction.Controls.Add(this.rb1);
			this.gbAction.Controls.Add(this.rb2);
			this.gbAction.Location = new System.Drawing.Point(96, 56);
			this.gbAction.Name = "gbAction";
			this.gbAction.Size = new System.Drawing.Size(312, 48);
			this.gbAction.TabIndex = 19;
			this.gbAction.TabStop = false;
			this.gbAction.Text = "Action";
			this.gbAction.Visible = false;
			// 
			// rb1
			// 
			this.rb1.Checked = true;
			this.rb1.Location = new System.Drawing.Point(72, 12);
			this.rb1.Name = "rb1";
			this.rb1.Size = new System.Drawing.Size(57, 24);
			this.rb1.TabIndex = 12;
			this.rb1.TabStop = true;
			this.rb1.Text = "Install";
			this.toolTip1.SetToolTip(this.rb1, "Use this option, if you want to install new Database.");
			this.rb1.CheckedChanged += new System.EventHandler(this.rb1_CheckedChanged);
			// 
			// rb2
			// 
			this.rb2.Location = new System.Drawing.Point(192, 12);
			this.rb2.Name = "rb2";
			this.rb2.Size = new System.Drawing.Size(65, 24);
			this.rb2.TabIndex = 13;
			this.rb2.Text = "Connect";
			this.toolTip1.SetToolTip(this.rb2, "Use this option, if you want to connect to existing Database.");
			this.rb2.CheckedChanged += new System.EventHandler(this.rb2_CheckedChanged);
			// 
			// gbLocation
			// 
			this.gbLocation.Controls.Add(this.rbLocal);
			this.gbLocation.Controls.Add(this.rbNetwork);
			this.gbLocation.Location = new System.Drawing.Point(96, 8);
			this.gbLocation.Name = "gbLocation";
			this.gbLocation.Size = new System.Drawing.Size(312, 48);
			this.gbLocation.TabIndex = 18;
			this.gbLocation.TabStop = false;
			this.gbLocation.Text = "Location";
			// 
			// rbLocal
			// 
			this.rbLocal.Checked = true;
			this.rbLocal.Location = new System.Drawing.Point(72, 12);
			this.rbLocal.Name = "rbLocal";
			this.rbLocal.TabIndex = 17;
			this.rbLocal.TabStop = true;
			this.rbLocal.Text = "Local Installation";
			this.toolTip1.SetToolTip(this.rbLocal, "Use this option for standalone machines");
			this.rbLocal.Click += new System.EventHandler(this.rbLocal_Click);
			// 
			// rbNetwork
			// 
			this.rbNetwork.Location = new System.Drawing.Point(192, 12);
			this.rbNetwork.Name = "rbNetwork";
			this.rbNetwork.TabIndex = 16;
			this.rbNetwork.Text = "Network Installation";
			this.toolTip1.SetToolTip(this.rbNetwork, "Use this option for machines in network");
			this.rbNetwork.Click += new System.EventHandler(this.rbNetwork_Click);
			// 
			// txtServName
			// 
			this.txtServName.Location = new System.Drawing.Point(176, 120);
			this.txtServName.Name = "txtServName";
			this.txtServName.Size = new System.Drawing.Size(296, 20);
			this.txtServName.TabIndex = 5;
			this.txtServName.Text = "(local)";
			this.toolTip1.SetToolTip(this.txtServName, "Enter the name of local SQL Server or keep the default text as it is.");
			// 
			// btnData
			// 
			this.btnData.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnData.Location = new System.Drawing.Point(440, 200);
			this.btnData.Name = "btnData";
			this.btnData.Size = new System.Drawing.Size(32, 23);
			this.btnData.TabIndex = 15;
			this.btnData.Text = "...";
			this.toolTip1.SetToolTip(this.btnData, "Click this button to list the existing Database.");
			this.btnData.Visible = false;
			this.btnData.Click += new System.EventHandler(this.btnData_Click);
			// 
			// cmbDataName
			// 
			this.cmbDataName.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.cmbDataName.Location = new System.Drawing.Point(176, 240);
			this.cmbDataName.Name = "cmbDataName";
			this.cmbDataName.Size = new System.Drawing.Size(296, 21);
			this.cmbDataName.TabIndex = 8;
			this.toolTip1.SetToolTip(this.cmbDataName, "Select the existing Database to which you want to connect.");
			this.cmbDataName.Visible = false;
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(32, 240);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(100, 20);
			this.label4.TabIndex = 4;
			this.label4.Text = "Database Name:";
			this.label4.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// txtPass
			// 
			this.txtPass.Location = new System.Drawing.Point(176, 200);
			this.txtPass.Name = "txtPass";
			this.txtPass.Size = new System.Drawing.Size(296, 20);
			this.txtPass.TabIndex = 7;
			this.txtPass.Text = "";
			this.toolTip1.SetToolTip(this.txtPass, "Enter the appropriate password for the User Name in above Text Box");
			// 
			// txtUserName
			// 
			this.txtUserName.Location = new System.Drawing.Point(176, 160);
			this.txtUserName.Name = "txtUserName";
			this.txtUserName.Size = new System.Drawing.Size(296, 20);
			this.txtUserName.TabIndex = 6;
			this.txtUserName.Text = "sa";
			this.toolTip1.SetToolTip(this.txtUserName, "Enter the User Name having Administrative Rights");
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(32, 200);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(100, 20);
			this.label3.TabIndex = 3;
			this.label3.Text = "Password:";
			this.label3.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(32, 160);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(100, 20);
			this.label2.TabIndex = 1;
			this.label2.Text = "User Name:";
			this.label2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(32, 120);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(120, 21);
			this.label1.TabIndex = 1;
			this.label1.Text = "SQL Server List:";
			this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// cmbServList
			// 
			this.cmbServList.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.cmbServList.Location = new System.Drawing.Point(176, 120);
			this.cmbServList.Name = "cmbServList";
			this.cmbServList.Size = new System.Drawing.Size(296, 21);
			this.cmbServList.TabIndex = 5;
			this.toolTip1.SetToolTip(this.cmbServList, "Select the Server on which you want to create the Database");
			this.cmbServList.Visible = false;
			// 
			// txtDBName
			// 
			this.txtDBName.Location = new System.Drawing.Point(176, 240);
			this.txtDBName.Name = "txtDBName";
			this.txtDBName.Size = new System.Drawing.Size(296, 20);
			this.txtDBName.TabIndex = 8;
			this.txtDBName.Text = "";
			this.toolTip1.SetToolTip(this.txtDBName, "Enter the name for Database.");
			// 
			// btnCancel
			// 
			this.btnCancel.Cursor = System.Windows.Forms.Cursors.Hand;
			this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.btnCancel.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnCancel.Location = new System.Drawing.Point(288, 347);
			this.btnCancel.Name = "btnCancel";
			this.btnCancel.Size = new System.Drawing.Size(88, 23);
			this.btnCancel.TabIndex = 9;
			this.btnCancel.Text = "Cancel";
			this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
			// 
			// btnConn
			// 
			this.btnConn.Cursor = System.Windows.Forms.Cursors.Hand;
			this.btnConn.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btnConn.Location = new System.Drawing.Point(384, 347);
			this.btnConn.Name = "btnConn";
			this.btnConn.Size = new System.Drawing.Size(88, 23);
			this.btnConn.TabIndex = 9;
			this.btnConn.Text = "Install";
			this.toolTip1.SetToolTip(this.btnConn, "Click this button to Install new or Connect to existing Database.");
			this.btnConn.Click += new System.EventHandler(this.btnConn_Click);
			// 
			// Form1
			// 
			this.AcceptButton = this.btnConn;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.btnCancel;
			this.ClientSize = new System.Drawing.Size(496, 390);
			this.Controls.Add(this.btnConn);
			this.Controls.Add(this.pictureBox1);
			this.Controls.Add(this.groupBox1);
			this.Controls.Add(this.btnCancel);
			this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.MaximizeBox = false;
			this.Name = "Form1";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Database Installer";
			this.groupBox1.ResumeLayout(false);
			this.gbAction.ResumeLayout(false);
			this.gbLocation.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		# region Main() Method 
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]

		
		static void Main() 
		{
			Application.Run(new Form1());
		}

		# endregion

		# region Code for Install or Connect Button 
		private void btnConn_Click(object sender, System.EventArgs e)
		{
			
			try
			{
				
				if(rbLocal.Checked==true)
				srv.Connect(this.txtServName.Text,this.txtUserName.Text,this.txtPass.Text); 
				else
				srv.Connect(this.cmbServList.Text,this.txtUserName.Text,this.txtPass.Text); 
				
				if(rbLocal.Checked==true ||  rb1.Checked==true)
				{	
					// This Function first creates the Database
					createDB();		
					// This Function creates Table with Primary Key and Default Values
					tblEmployees();						
					// This Function creates Stored Procedure
					SP_Employees();	
					// This Function creates Stored Procedure for creating table
					SP_Students();
					// Execute the stored procedure to create table
					nDatabase.ExecuteImmediate("InsStudents",0,0);
					// Remove the stored procedure from database. The index starts from 1.
					nDatabase.StoredProcedures.Remove(2,"");

					// This function creates Connection String and stores it on C: drive
					// You can read this file in your application while using ADO.NET
					createConnString();
										
				}
				else if (rbNetwork.Checked==true ||  rb2.Checked==true)
				{
					System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.AppStarting;
					createConnString1();
				}					

			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			finally
			{
				srv.DisConnect();	
				System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Default;
				this.Close();
			}
		}

		# endregion

		# region Function for creating Database  

		// This function creates Database
		private void createDB()
		{
			strDatabaseName = txtDBName.Text.ToString();
			if (strDatabaseName == "")
			{
				MessageBox.Show("Enter the Name");
			} 
			try
			{
				// Assign a name to database
				nDatabase.Name = strDatabaseName;
				// Assign a name to datafile
				nDBFileData.Name = strDatabaseName;
				nDBFileData.PhysicalName = srv.Registry.SQLDataRoot + "\\DATA\\" + strDatabaseName + "_Data.mdf";
				nDBFileData.PrimaryFile = true;
				nDBFileData.Size = 2;

				nDBFileData.FileGrowthType = SQLDMO.SQLDMO_GROWTH_TYPE.SQLDMOGrowth_MB;
				nDBFileData.FileGrowth = 1;

				//Add the DBFile object
				nDatabase.FileGroups.Item("PRIMARY").DBFiles.Add(nDBFileData);

				// Assign name to Log files
				nLogFile.Name = strDatabaseName + "Log";
				nLogFile.PhysicalName = srv.Registry.SQLDataRoot + "\\DATA\\" + strDatabaseName + "_Log.ldf";
				nLogFile.Size = 2;
				nDatabase.TransactionLog.LogFiles.Add(nLogFile);


				srv.Databases.Add(nDatabase);
				//srv.DisConnect();
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
				return;
			}
			finally
			{
				
			}


		}

		# endregion

		# region Code for Cancel Button 
		private void btnCancel_Click(object sender, System.EventArgs e)	
		{
			try
			{			
				srv.DisConnect();
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
		}
		
		# endregion

		# region Function for creating Table 

		// This function creates a Table
		private void tblEmployees()
		{
			try
			{
				// Create a new Table
				SQLDMO.Table table = new SQLDMO.Table();

				// Give Name to the Table
				table.Name="Employees";
				
				
				// Create Columns for tables
				// Column 1
				// Create new column
				SQLDMO.Column Col1 = new SQLDMO.Column();
				// Give name to the column
				Col1.Name="EmpNo";
				// Assign datatype to the column
				Col1.Datatype="int";
				// Mention whether NULL values are allowed or not
				Col1.AllowNulls=false;

				// Column 2
				SQLDMO.Column Col2 = new SQLDMO.Column();
				Col2.Name="Name";
				Col2.Datatype="varchar";
				// Decide the length of varchar datatype
				Col2.Length=50;
				Col2.AllowNulls=false;

				// Column 3
				SQLDMO.Column Col3 = new SQLDMO.Column();
				Col3.Name="Surname";
				Col3.Datatype="varchar";
				Col3.Length=50;
				Col3.AllowNulls=true;

				// Column 4
				SQLDMO.Column Col4 = new SQLDMO.Column();
				Col4.Name="isPermanent";
				Col4.Datatype="char";
				Col4.Length=10;
				// Assign default value to the column
				Col4.DRIDefault.Text=strYes; 
				Col4.AllowNulls=true;				


				// Add Columns to the table
				table.Columns.Add(Col1);
				table.Columns.Add(Col2);
				table.Columns.Add(Col3);
				table.Columns.Add(Col4);
				

				// Create PRIMARY KEY
				SQLDMO.Key PK = new SQLDMO.Key();				
				PK.Clustered=true;
				PK.Type= SQLDMO.SQLDMO_KEY_TYPE.SQLDMOKey_Primary;
				// Add Primary Key to 'EmpNo' column
				PK.KeyColumns.Add("EmpNo");


				// Add primary key to table
				table.Keys.Add(PK);

				// Add table to Database
				nDatabase.Tables.Add(table);

			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			finally
			{
			}
		}
						
		# endregion

		# region Function for creating Stored Procedure 
		// This function creates a Stored Procedure
		private void SP_Employees()
		{
			try
			{
				// Create a Stored Procedure
				SQLDMO.StoredProcedure strProc = new SQLDMO.StoredProcedure();
				// Assign a name to stored procedure
				strProc.Name="InsEmployees";
				// Write a Stored Procedure Script and pass it as a string.
				strProc.Text="CREATE procedure InsEmployees(" + 
				  
				"@v_EmpNo int,@v_Name varchar(50),@v_Surname varchar(50),@v_isPermanent char(10))"+
				"as "+
				"Begin Insert Into PersonalInfo(EmpNo,Name,Surname,isPermanent)"+
				"values (@v_EmpNo,@v_Name,@v_Surname ,@v_isPermanent) end";
			
                // Add the Stored Procedure to Database
				nDatabase.StoredProcedures.Add(strProc);
				
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
			}

		}
		
		private void SP_Students()
		{
			try
			{
				// Create a Stored Procedure
				SQLDMO.StoredProcedure strProc = new SQLDMO.StoredProcedure();
				// Assign a name to stored procedure
				strProc.Name="InsStudents";
				// Write a Stored Procedure Script and pass it as a string.
				strProc.Text="CREATE procedure InsStudents as begin create table Students(Name Varchar(50),Surname Varchar(50)) end";			
				// Add the Stored Procedure to Database
				nDatabase.StoredProcedures.Add(strProc);
				
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
			}

		}
		
		# endregion

		# region Function for creating Connection String When Install button is clicked 

		// This function creates connection string when "Install" Button is clicked
		private void createConnString()
		{
			try
			{
	
				FileStream fsOutput = new FileStream("C:\\conStr.txt",FileMode.Create, FileAccess.Write);
				StreamWriter srOutput = new StreamWriter (fsOutput);
				string s1;
				if(rbLocal.Checked==true)
					s1="integrated security=SSPI;\npacket size=4096;\ndata source=" + this.txtServName.Text.Trim() + ";user id="+txtUserName.Text+";pwd="+txtPass.Text+";persist security info=False;initial catalog="+txtDBName.Text.Trim() +"";
				else
					s1="integrated security=SSPI;\npacket size=4096;\ndata source=" + this.cmbServList.Text.Trim() + ";user id="+txtUserName.Text+";pwd="+txtPass.Text+";persist security info=False;initial catalog="+txtDBName.Text.Trim() +"";
				srOutput.WriteLine(s1.ToString());
				srOutput.Close ();
				fsOutput.Close ();		
				
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);   
			}
			finally
			{

			}
		}
				
		# endregion

		# region Code for Install RadioButton CheckedChanged  
		private void rb1_CheckedChanged(object sender, System.EventArgs e)
		{
			try
			{
				cmbDataName.Visible=false;
				btnData.Visible=false;
				txtDBName.Visible=true;
				txtPass.Size=new Size(296,20);
				btnConn.Text="Install";
			}
		
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
			}

		}

		# endregion

		# region Code for Connect RadioButton CheckedChanged  
		private void rb2_CheckedChanged(object sender, System.EventArgs e)
		{
			try
			{
				cmbDataName.Visible=true;
				btnData.Visible=true;
				txtPass.Size=new Size(256,20);
				txtDBName.Visible=false;
				btnConn.Text="Connect";
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
		}

		#endregion

		# region Code for Database List Button 
		private void btnData_Click(object sender, System.EventArgs e)
		{
			try
			{
				System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.AppStarting;
				if(rbLocal.Checked==true)
					srv.Connect(this.txtServName.Text.Trim(),this.txtUserName.Text,this.txtPass.Text);			
				else
					srv.Connect(this.cmbServList.Text.Trim(),this.txtUserName.Text,this.txtPass.Text);		
				// Navigate through each database in the server and add it to combo box
				foreach(SQLDMO.Database db in srv.Databases) 
				{ 
					if(db.Name!=null) 
						this.cmbDataName.Items.Add(db.Name); 
				}

				if(this.cmbDataName.Items.Count!=0)
					cmbDataName.SelectedIndex=0;
			
				System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Default;
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			finally
			{
					srv.DisConnect();
			}
		
		}

		# endregion

		# region Function for creating Connection String When Connect button is clicked 
		// This function creates connection string when "Connect" Button is clicked
		private void createConnString1()
		{
			ArrayList szContents = new ArrayList ();
			try
			{

				FileStream fsOutput = new FileStream("C:\\conStr.txt",FileMode.Create, FileAccess.Write);
				StreamWriter srOutput = new StreamWriter (fsOutput);
				string s1;
				s1="integrated security=SSPI;packet size=4096;data source=" + this.cmbServList.Text.Trim() + ";user id="+txtUserName.Text+";pwd="+txtPass.Text+";persist security info=False;initial catalog="+cmbDataName.Text.Trim() +"";
				srOutput.WriteLine(s1.ToString());
				srOutput.Close ();
				fsOutput.Close ();		
				
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);   
			}
			finally
			{

			}
		}
		
		# endregion

		# region Code for Local RadioButton Click event  
		private void rbLocal_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(rbLocal.Checked==true)
				{
					gbAction.Visible=false;
					cmbServList.Visible=false;
					txtServName.Visible=true;
					cmbDataName.Visible=false;
					btnData.Visible=false;
					txtDBName.Visible=true;
					txtPass.Size=new Size(296,20);
					btnConn.Text="Install";
				}
				else
				{
					System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.AppStarting;
					gbAction.Visible=true;
					cmbServList.Visible=true;
					txtServName.Visible=false;
					// Call the function to populate the Server Combo Box
					fillCmbServerList();
					if(rb2.Checked==true)
					{
						
						cmbDataName.Visible=true;
						btnData.Visible=true;
						txtPass.Size=new Size(256,20);
						txtDBName.Visible=false;
						btnConn.Text="Connect";
					}
					System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Default;
				}
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
			}

		}

		# endregion

		# region Code for Network RadioButton Click event  
		private void rbNetwork_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(rbNetwork.Checked==true)
				{
					System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.AppStarting;
					gbAction.Visible=true;
					cmbServList.Visible=true;
					txtServName.Visible=false;
					// Call the function to populate the Server Combo Box
					fillCmbServerList();
					if(rb2.Checked==true)
					{
						
						cmbDataName.Visible=true;
						btnData.Visible=true;
						txtPass.Size=new Size(256,20);
						txtDBName.Visible=false;
						btnConn.Text="Connect";
					}
					System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Default;
				}
				else
				{
					gbAction.Visible=false;
					cmbServList.Visible=false;
					txtServName.Visible=true;
					cmbDataName.Visible=false;
					btnData.Visible=false;
					txtDBName.Visible=true;
					txtPass.Size=new Size(296,20);
					btnConn.Text="Install";
				}
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
		}

		# endregion

		# region Function for populating combo with existing servers  
		private void fillCmbServerList()
		{
			try
			{
				// Create SQL Servers Collection
				SQLDMO.NameList sqlServers = sqlApp.ListAvailableSQLServers(); 
				// Navigate through collection, one by one
				for(int i=0;i<sqlServers.Count;i++) 
				{ 
					object srv = sqlServers.Item(i + 1); 
					if(srv != null) 
					{ 
						this.cmbServList.Items.Add(srv);                         
					} 
				} 
				if(this.cmbServList.Items.Count > 0) 
					this.cmbServList.SelectedIndex = 0; 
				else 
					this.cmbServList.Text = "<No available SQL Servers>"; 
			}
			catch(Exception ex)
            {
				MessageBox.Show(ex.Message);
			}
		}

		# endregion
	}
}
