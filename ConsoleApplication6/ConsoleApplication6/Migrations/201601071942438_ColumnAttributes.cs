namespace ConsoleApplication6.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ColumnAttributes : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.People", "FirstName", c => c.String(nullable: false, maxLength: 50));
            AlterColumn("dbo.People", "LastName", c => c.String(nullable: false, maxLength: 50));
            AlterColumn("dbo.People", "Created", c => c.DateTime(nullable: false, precision: 7, storeType: "datetime2"));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.People", "Created", c => c.DateTime(nullable: false));
            AlterColumn("dbo.People", "LastName", c => c.String());
            AlterColumn("dbo.People", "FirstName", c => c.String());
        }
    }
}
