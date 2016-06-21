using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ATS.Model
{
    public class EmployeeViewModel
    {
        public string EmployeeID { get; set; }
        public int GlobalID { get; set; }
        public string CardID { get; set; }
        public DateTime CreatedDate { get; set; }
        public string EmailAddress { get; set; }
        public string NTID { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string OrganizationName { get; set; }
        public string Supervisor { get; set; }
    }
}
