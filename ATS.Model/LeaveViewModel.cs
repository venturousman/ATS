using System;

namespace ATS.Model
{
    public class LeaveViewModel
    {
        public Guid LeaveID { get; set; }
        public string EmployeeName { get; set; }
        public string Initiator { get; set; }
        public string Segment { get; set; }
        public string SegmentName { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string Reason { get; set; }
        public string Remark { get; set; }
        public DateTime CreatedDate { get; set; }
    }
}
