using System;

namespace ATS.Model
{
    public class ScheduleViewModel
    {
        public int ScheduleID { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public Guid TeacherID { get; set; }
        public int MaxPeople { get; set; }
        public int MinPeople { get; set; }
        public int CourseID { get; set; }
        public String CourseName { get; set; }
        public String Note { get; set; }
        public String Initiator { get; set; }
        public DateTime CreatedDate { get; set; }
        public String ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}
