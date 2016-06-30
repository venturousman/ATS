using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ATS.Data;

namespace ATS.BackOffice.Controllers
{
    public class EmployeeController : Controller
    {
        private ATSEntities db = null;

        public EmployeeController()
        {
            db = new ATSEntities();
        }
        // GET: Employee
        public ActionResult Index()
        {
            ViewBag.listEmployee = GetEmployees().ToList();
            //ViewBag.listEmployeeGlobals = GetEmployeeGlobals().ToList();
            return View();
        }
        public IQueryable<EmployeeGlobal> GetEmployeeGlobals()
        {
            var employeeGlobals = db.EmployeeGlobals.Select(p => p);
            return employeeGlobals;
        }

        public IQueryable<Employee> GetEmployees()
        {
            db = new ATSEntities();
            //var employees = db.Employees.Where(p=>p.IsActive==1).Select(p => p);
            var employees = db.Employees.Where(p => p.IsActive == true).Select(p => p);
            return employees;
        }
    }
}