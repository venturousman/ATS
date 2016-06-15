using System;

namespace ATS.Model
{
    public class AttendanceViewModel
    {
        public Guid AttendantID { get; set; }
        public Guid SegmentID { get; set; }
        public Guid RoomID { get; set; }
        public string RoomName { get; set; }
        public string EmployeeID { get; set; }
        public DateTime TimeIn { get; set; }
        public DateTime TimeOut { get; set; }
        public string FullName { get; set; }
        public int ScheduleID { get; set; }
        public string CourseName { get; set; }
        public string OrganizationName { get; set; }
        public string Supervisor { get; set; }
        public DateTime AttendantDate { get; set; }
        public bool IsManual { get; set; }
    }
}
