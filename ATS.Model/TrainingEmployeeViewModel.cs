using System;

namespace ATS.Model
{
    public class TrainingEmployeeViewModel
    {
        public Guid TrainingEmployeeID { get; set; }
        public int ScheduleID { get; set; }
        public string EmployeeID { get; set; }
        public DateTime StopFrom { get; set; }
        public bool IsActive { get; set; }
    }
}
