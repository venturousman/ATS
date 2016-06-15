using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ATS.Model
{
    public class CourseViewModel
    {
        public Guid CourseID { get; set; }
        public String Name { get; set; }
        public String Note { get; set; }
        public bool IsActive { get; set; }
    }
}
