namespace WindowsFormsApp1
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.portalBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.portalDataSet = new WindowsFormsApp1.portalDataSet();
            this.intorganizationBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.int_organizationTableAdapter = new WindowsFormsApp1.portalDataSetTableAdapters.int_organizationTableAdapter();
            this.organizationidDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.categorycdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.parentorganizationidDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.organizationcdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.organizationnmDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.indefaultsearchDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.monitordisableswDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.autocollectintervalDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.outboundintervalDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.printernameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.alarmprinternameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.portalBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.portalDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.intorganizationBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.organizationidDataGridViewTextBoxColumn,
            this.categorycdDataGridViewTextBoxColumn,
            this.parentorganizationidDataGridViewTextBoxColumn,
            this.organizationcdDataGridViewTextBoxColumn,
            this.organizationnmDataGridViewTextBoxColumn,
            this.indefaultsearchDataGridViewTextBoxColumn,
            this.monitordisableswDataGridViewTextBoxColumn,
            this.autocollectintervalDataGridViewTextBoxColumn,
            this.outboundintervalDataGridViewTextBoxColumn,
            this.printernameDataGridViewTextBoxColumn,
            this.alarmprinternameDataGridViewTextBoxColumn});
            this.dataGridView1.DataSource = this.intorganizationBindingSource;
            this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView1.Location = new System.Drawing.Point(0, 0);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.Size = new System.Drawing.Size(1500, 663);
            this.dataGridView1.TabIndex = 0;
            // 
            // portalDataSet
            // 
            this.portalDataSet.DataSetName = "portalDataSet";
            this.portalDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // intorganizationBindingSource
            // 
            this.intorganizationBindingSource.DataMember = "int_organization";
            this.intorganizationBindingSource.DataSource = this.portalDataSet;
            // 
            // int_organizationTableAdapter
            // 
            this.int_organizationTableAdapter.ClearBeforeFill = true;
            // 
            // organizationidDataGridViewTextBoxColumn
            // 
            this.organizationidDataGridViewTextBoxColumn.DataPropertyName = "organization_id";
            this.organizationidDataGridViewTextBoxColumn.HeaderText = "organization_id";
            this.organizationidDataGridViewTextBoxColumn.Name = "organizationidDataGridViewTextBoxColumn";
            this.organizationidDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // categorycdDataGridViewTextBoxColumn
            // 
            this.categorycdDataGridViewTextBoxColumn.DataPropertyName = "category_cd";
            this.categorycdDataGridViewTextBoxColumn.HeaderText = "category_cd";
            this.categorycdDataGridViewTextBoxColumn.Name = "categorycdDataGridViewTextBoxColumn";
            this.categorycdDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // parentorganizationidDataGridViewTextBoxColumn
            // 
            this.parentorganizationidDataGridViewTextBoxColumn.DataPropertyName = "parent_organization_id";
            this.parentorganizationidDataGridViewTextBoxColumn.HeaderText = "parent_organization_id";
            this.parentorganizationidDataGridViewTextBoxColumn.Name = "parentorganizationidDataGridViewTextBoxColumn";
            this.parentorganizationidDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // organizationcdDataGridViewTextBoxColumn
            // 
            this.organizationcdDataGridViewTextBoxColumn.DataPropertyName = "organization_cd";
            this.organizationcdDataGridViewTextBoxColumn.HeaderText = "organization_cd";
            this.organizationcdDataGridViewTextBoxColumn.Name = "organizationcdDataGridViewTextBoxColumn";
            this.organizationcdDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // organizationnmDataGridViewTextBoxColumn
            // 
            this.organizationnmDataGridViewTextBoxColumn.DataPropertyName = "organization_nm";
            this.organizationnmDataGridViewTextBoxColumn.HeaderText = "organization_nm";
            this.organizationnmDataGridViewTextBoxColumn.Name = "organizationnmDataGridViewTextBoxColumn";
            this.organizationnmDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // indefaultsearchDataGridViewTextBoxColumn
            // 
            this.indefaultsearchDataGridViewTextBoxColumn.DataPropertyName = "in_default_search";
            this.indefaultsearchDataGridViewTextBoxColumn.HeaderText = "in_default_search";
            this.indefaultsearchDataGridViewTextBoxColumn.Name = "indefaultsearchDataGridViewTextBoxColumn";
            this.indefaultsearchDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // monitordisableswDataGridViewTextBoxColumn
            // 
            this.monitordisableswDataGridViewTextBoxColumn.DataPropertyName = "monitor_disable_sw";
            this.monitordisableswDataGridViewTextBoxColumn.HeaderText = "monitor_disable_sw";
            this.monitordisableswDataGridViewTextBoxColumn.Name = "monitordisableswDataGridViewTextBoxColumn";
            this.monitordisableswDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // autocollectintervalDataGridViewTextBoxColumn
            // 
            this.autocollectintervalDataGridViewTextBoxColumn.DataPropertyName = "auto_collect_interval";
            this.autocollectintervalDataGridViewTextBoxColumn.HeaderText = "auto_collect_interval";
            this.autocollectintervalDataGridViewTextBoxColumn.Name = "autocollectintervalDataGridViewTextBoxColumn";
            this.autocollectintervalDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // outboundintervalDataGridViewTextBoxColumn
            // 
            this.outboundintervalDataGridViewTextBoxColumn.DataPropertyName = "outbound_interval";
            this.outboundintervalDataGridViewTextBoxColumn.HeaderText = "outbound_interval";
            this.outboundintervalDataGridViewTextBoxColumn.Name = "outboundintervalDataGridViewTextBoxColumn";
            this.outboundintervalDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // printernameDataGridViewTextBoxColumn
            // 
            this.printernameDataGridViewTextBoxColumn.DataPropertyName = "printer_name";
            this.printernameDataGridViewTextBoxColumn.HeaderText = "printer_name";
            this.printernameDataGridViewTextBoxColumn.Name = "printernameDataGridViewTextBoxColumn";
            this.printernameDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // alarmprinternameDataGridViewTextBoxColumn
            // 
            this.alarmprinternameDataGridViewTextBoxColumn.DataPropertyName = "alarm_printer_name";
            this.alarmprinternameDataGridViewTextBoxColumn.HeaderText = "alarm_printer_name";
            this.alarmprinternameDataGridViewTextBoxColumn.Name = "alarmprinternameDataGridViewTextBoxColumn";
            this.alarmprinternameDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1500, 663);
            this.Controls.Add(this.dataGridView1);
            this.Name = "Form1";
            this.Text = "Portal Organization";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.portalBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.portalDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.intorganizationBindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.BindingSource portalBindingSource;
        private portalDataSet portalDataSet;
        private System.Windows.Forms.BindingSource intorganizationBindingSource;
        private portalDataSetTableAdapters.int_organizationTableAdapter int_organizationTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn organizationidDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn categorycdDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn parentorganizationidDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn organizationcdDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn organizationnmDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn indefaultsearchDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn monitordisableswDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn autocollectintervalDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn outboundintervalDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn printernameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn alarmprinternameDataGridViewTextBoxColumn;
    }
}

