using System;

namespace ATS.Model
{
    public class TerminalViewModel
    {
        public string TerminalName { get; set; }
        public string Room { get; set; }
        public Guid CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
    }
}
