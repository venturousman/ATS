using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ATS.Data;
using X.PagedList;


namespace ATS.BackOffice.Controllers
{
    public class CourseMgtController : Controller
    {
        public const string INDEX_PAGE = "Index";
        private ATSEntities db = null;
        public CourseMgtController(ATSEntities entites)
        {
            db = entites;
        }
        // GET: CourseMgt
        public async Task<ActionResult> Index(string sortOrder, string currentFilter, string searchString, int? page)
        {

            var courses = db.Courses.AsQueryable();

            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParm = String.IsNullOrEmpty(sortOrder) ? "name_desc" : "";
            ViewBag.ActiveSortParm = sortOrder == "Active" ? "active_desc" : "Active";            

            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            ViewBag.CurrentFilter = searchString;
           
            if (!String.IsNullOrEmpty(searchString))
            {
                courses = courses.Where(c => c.Name.Contains(searchString)
                                       || c.Note.Contains(searchString));
            }
            switch (sortOrder)
            {
                case "name_desc":
                    courses = courses.OrderByDescending(s => s.Name);
                    break;
                case "Active":
                    courses = courses.OrderBy(s => s.IsActive);
                    break;
                case "active_desc":
                    courses = courses.OrderByDescending(c => c.IsActive);
                    break;
                default:  // Name ascending 
                    courses = courses.OrderBy(c => c.Name);
                    break;
            }

            int pageNumber = (page ?? 1);
            return View(await courses.ToPagedListAsync(pageNumber, HtmlHelperExtensions.PAGE_SIZE));
            
        }

        // GET: CourseMgt/Details/5
        public async Task<ActionResult> Details(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Course course = await db.Courses.FindAsync(id);
            if (course == null)
            {
                return HttpNotFound();
            }
            return View(course);
        }

        // GET: CourseMgt/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: CourseMgt/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create(Course course)
        {
            if (ModelState.IsValid)
            {
                course.CourseID = Guid.NewGuid();
                db.Courses.Add(course);
                await db.SaveChangesAsync();
                return RedirectToAction(INDEX_PAGE);
            }

            return View(course);
        }

        // GET: CourseMgt/Edit/5
        public async Task<ActionResult> Edit(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Course course = await db.Courses.FindAsync(id);
            if (course == null)
            {
                return HttpNotFound();
            }
            return View(course);
        }

        // POST: CourseMgt/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit(Course course)
        {
            if (ModelState.IsValid)
            {
                db.Entry(course).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction(INDEX_PAGE);
            }
            return View(course);
        }

        // GET: CourseMgt/Delete/5
        public async Task<ActionResult> Delete(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Course course = await db.Courses.FindAsync(id);
            if (course == null)
            {
                return HttpNotFound();
            }
            return View(course);
        }

        // POST: CourseMgt/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(Guid id)
        {
            Course course = await db.Courses.FindAsync(id);
            db.Courses.Remove(course);
            await db.SaveChangesAsync();
            return RedirectToAction(INDEX_PAGE);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
