﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using ATS.Data;
using ATS.Model;
using System.Web.Http.Description;
using System.Threading.Tasks;
using System.Data.Entity.Infrastructure;
using System.Data.Entity;

namespace ATS.BackOffice.Controllers
{
    public class CourseController : ApiController
    {
        private ATSEntities db = new ATSEntities();

        // GET: api/Course
        public IQueryable<CourseViewModel> Get()
        {
            var courses = from t in db.Courses
                          //where t.IsActive == true
                          select new CourseViewModel()
                          {
                              CourseID = t.CourseID,
                              Name = t.Name,
                              Note = t.Note,
                              IsActive = t.IsActive
                          };

            return courses;
        }

        // GET: api/Course/5
        [ResponseType(typeof(CourseViewModel))]
        public async Task<IHttpActionResult> Get(Guid id)
        {
            var course = await db.Courses.Include(c => c.Schedules).Select(t =>
                new CourseViewModel()
                {
                    CourseID = t.CourseID,
                }).SingleOrDefaultAsync(t => t.CourseID == id);
            if (course == null)
            {
                return NotFound();
            }

            return Ok(course);

            //TrainingEmployee trainingEmployee = await db.TrainingEmployees.FindAsync(id);
            //if (trainingEmployee == null)
            //{
            //    return NotFound();
            //}

            //var training = new TrainingViewModel
            //{
            //    ID = trainingEmployee.ID
            //};

            //return Ok(training);
        }

        // POST: api/Course        
        [ResponseType(typeof(CourseViewModel))]
        public async Task<IHttpActionResult> Post(CourseViewModel course)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var _course = new Course
            {
                CourseID = course.CourseID
            };

            db.Courses.Add(_course);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (CourseExists(_course.CourseID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = _course.CourseID }, _course);
        }

        // PUT: api/Course/5        
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> Put(Guid id, CourseViewModel course)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != course.CourseID)
            {
                return BadRequest();
            }

            Course _course = await db.Courses.FindAsync(id);
            if (_course == null)
            {
                return NotFound();
            }

            db.Entry(_course).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CourseExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // DELETE: api/Course/5
        [ResponseType(typeof(CourseViewModel))]
        public async Task<IHttpActionResult> Delete(Guid id)
        {
            Course _course = await db.Courses.FindAsync(id);
            if (_course == null)
            {
                return NotFound();
            }

            db.Courses.Remove(_course);
            await db.SaveChangesAsync();

            return Ok(_course);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool CourseExists(Guid id)
        {
            return db.Courses.Count(e => e.CourseID == id) > 0;
        }
    }
}
