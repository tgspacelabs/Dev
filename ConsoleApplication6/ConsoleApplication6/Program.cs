using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication6
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var db = new PeopleContext())
            {
                Person p = new Person();
                p.PersonID = 1;
                p.FirstName = "Tony";
                p.LastName = "Green";
                p.Created = DateTime.Now;

                db.Persons.Add(p);

                db.SaveChanges();
            }

        }
    }
}
