//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ATS.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class Reason
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Reason()
        {
            this.Leaves = new HashSet<Leave>();
        }
    
        public System.Guid ID { get; set; }
        public string Name { get; set; }
        public System.DateTime CreatedDate { get; set; }
        public string Initiator { get; set; }
        public bool IsActive { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Leave> Leaves { get; set; }
    }
}