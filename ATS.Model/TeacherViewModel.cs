using System;

namespace ATS.Model
{
    public class TeacherViewModel
    {
        public Guid TeacherID { get; set; }
        public string Name { get; set; }
        public bool IsExternal { get; set; }
        public string Email { get; set; }
        public string Initiator { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string EmlpoyeeID { get; set; }
    }
}
