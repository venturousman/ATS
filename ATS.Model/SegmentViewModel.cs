using System;

namespace ATS.Model
{
    public class SegmentViewModel
    {
        public Guid SegmentID { get; set; }
        public int ScheduleID { get; set; }
        public string CourseName { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public Guid RoomID { get; set; }
        public string Note { get; set; }
        public string Item { get; set; }
        public DateTime Date { get; set; }
        public bool IsActive { get; set; }
    }
}
