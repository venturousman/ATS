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

namespace ATS.BackOffice.Controllers
{
    public class ScheduleMgtController : Controller
    {
        private ATSEntities db = new ATSEntities();

        // GET: ScheduleMgt
        public async Task<ActionResult> Index()
        {
            var schedules = db.Schedules.Include(s => s.Course).Include(s => s.Teacher);
            return View(await schedules.ToListAsync());
        }

        // GET: ScheduleMgt/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Schedule schedule = await db.Schedules.FindAsync(id);
            if (schedule == null)
            {
                return HttpNotFound();
            }
            return View(schedule);
        }

        // GET: ScheduleMgt/Create
        public ActionResult Create()
        {
            ViewBag.CourseID = new SelectList(db.Courses, "CourseID", "Name");
            ViewBag.TeacherID = new SelectList(db.Teachers, "TeacherID", "Name");
            return View();
        }

        // POST: ScheduleMgt/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "ScheduleID,StartTime,EndTime,TeacherID,MinPeople,MaxPeople,CourseID,CourseName,Note,Initiator,CreatedDate,ModifiedBy,ModifiedDate")] Schedule schedule)
        {
            if (ModelState.IsValid)
            {
                db.Schedules.Add(schedule);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            ViewBag.CourseID = new SelectList(db.Courses, "CourseID", "Name", schedule.CourseID);
            ViewBag.TeacherID = new SelectList(db.Teachers, "TeacherID", "Name", schedule.TeacherID);
            return View(schedule);
        }

        // GET: ScheduleMgt/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Schedule schedule = await db.Schedules.FindAsync(id);
            if (schedule == null)
            {
                return HttpNotFound();
            }
            ViewBag.CourseID = new SelectList(db.Courses, "CourseID", "Name", schedule.CourseID);
            ViewBag.TeacherID = new SelectList(db.Teachers, "TeacherID", "Name", schedule.TeacherID);
            return View(schedule);
        }

        // POST: ScheduleMgt/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "ScheduleID,StartTime,EndTime,TeacherID,MinPeople,MaxPeople,CourseID,CourseName,Note,Initiator,CreatedDate,ModifiedBy,ModifiedDate")] Schedule schedule)
        {
            schedule.ModifiedDate = DateTime.Now;
            schedule.CourseName = db.Courses.Where(c => c.CourseID == schedule.CourseID).FirstOrDefault().Name;
            if (ModelState.IsValid)
            {
                db.Entry(schedule).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.CourseID = new SelectList(db.Courses, "CourseID", "Name", schedule.CourseID);
            ViewBag.TeacherID = new SelectList(db.Teachers, "TeacherID", "Name", schedule.TeacherID);
            return View(schedule);
        }

        // GET: ScheduleMgt/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Schedule schedule = await db.Schedules.FindAsync(id);
            if (schedule == null)
            {
                return HttpNotFound();
            }
            return View(schedule);
        }

        // POST: ScheduleMgt/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            Schedule schedule = await db.Schedules.FindAsync(id);
            db.Schedules.Remove(schedule);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
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
