
using System.Web.Mvc;
using System.Security.Principal;

namespace ATS.BackOffice
{
    public static class HtmlHelperExtensions
    {
        public const int PAGE_SIZE = 3;
        
        public static string GetTitlePage(this HtmlHelper helper, string title= "")
        {
            return string.Format("Attendance Tracking System {0}", (string.IsNullOrEmpty(title) ? "" : "- " + title)); 
        }
        public static string GetCurrentLoginUser(this HtmlHelper helper)
        {
            WindowsIdentity user = WindowsIdentity.GetCurrent();
            return GetNTID(user.Name);            
        }
        public static string GetCurrentLoginUserAvatar(this HtmlHelper helper)
        {
            WindowsIdentity user = WindowsIdentity.GetCurrent();
            return string.Format("https://rb-owa.apac.bosch.com/ews/exchange.asmx/s/GetUserPhoto?email=tri.nguyenminh2@vn.bosch.com&size=HR240x240",
                GetNTID(user.Name));
        }
        public static string GetCurrentLoginUserName(this HtmlHelper helper)
        {
            WindowsIdentity user = WindowsIdentity.GetCurrent();
            string ntid = helper.GetCurrentLoginUser();
            return ntid  == "DRT1HC" ? "Nguyen Minh Tri" : ntid;
        }        

        private static string GetNTID(string userNameWithDomain)
        {
            string[] name = null;
            if (!string.IsNullOrEmpty(userNameWithDomain))
            {
                name = userNameWithDomain.Split(new string[] { "\\" }, System.StringSplitOptions.RemoveEmptyEntries);
            }
            

            return name == null ? userNameWithDomain : (name.Length < 2 ? userNameWithDomain : name[1]);
        }
    }
}