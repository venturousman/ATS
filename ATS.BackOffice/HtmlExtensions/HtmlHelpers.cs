
using System.Web.Mvc;
using System.Security.Principal;

namespace ATS.BackOffice
{
    public static class HtmlHelperExtensions
    {
        public static string GetCurrentLoginUser(this HtmlHelper helper)
        {
            WindowsIdentity user = WindowsIdentity.GetCurrent();
            return GetNTID(user.Name);            
        }
        public static string GetCurrentLoginUserAvatar(this HtmlHelper helper)
        {
            WindowsIdentity user = WindowsIdentity.GetCurrent();
            return string.Format("https://rb-owa.apac.bosch.com/ews/exchange.asmx/s/GetUserPhoto?email={0}&size=HR240x240",
                GetNTID(user.Name));
        }
        public static string GetCurrentLoginUserName(this HtmlHelper helper)
        {
            WindowsIdentity user = WindowsIdentity.GetCurrent();
            string ntid = helper.GetCurrentLoginUser();
            return ntid  == "DRT1HC" ? "Dang Dinh Trung" : ntid;
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