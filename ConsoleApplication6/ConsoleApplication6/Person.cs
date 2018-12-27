using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication6
{
    public class Person
    {
        [Key]
        public int PersonID { get; set; }

        [Required,StringLength(50)]
        public string FirstName { get; set; }

        [Required, StringLength(50)]
        public string LastName { get; set; }

        [Column(TypeName = "DATE")]
        public DateTime DateOfBirth { get; set; }

        [Column(TypeName = "DATETIME2")]
        public DateTime Created { get; set; }

    }
}
