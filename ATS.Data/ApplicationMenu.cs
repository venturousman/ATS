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
    
    public partial class ApplicationMenu
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ApplicationMenu()
        {
            this.RoleMappings = new HashSet<RoleMapping>();
        }
    
        public System.Guid ID { get; set; }
        public string Name { get; set; }
        public string ParentCode { get; set; }
        public string Controller { get; set; }
        public bool IsActive { get; set; }
        public string Initiator { get; set; }
        public System.DateTime CreatedDate { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RoleMapping> RoleMappings { get; set; }
    }
}
