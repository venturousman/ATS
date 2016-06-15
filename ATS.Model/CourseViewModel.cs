using System;

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
