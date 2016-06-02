using System;
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
    public class TrainingController : ApiController
    {
        private ATSEntities db = new ATSEntities();

        // GET: api/Training
        public IQueryable<TrainingViewModel> Get()
        {
            //return new string[] { "value1", "value2" };
            var trainings = from t in db.TrainingEmployees
                            select new TrainingViewModel()
                            {
                                ID = t.ID,
                            };

            return trainings;
        }

        // GET: api/Training/5
        [ResponseType(typeof(TrainingViewModel))]
        public async Task<IHttpActionResult> Get(Guid id)
        {
            var training = await db.TrainingEmployees.Include(t => t.Schedule).Select(t =>
                new TrainingViewModel()
                {
                    ID = t.ID,
                }).SingleOrDefaultAsync(t => t.ID == id);
            if (training == null)
            {
                return NotFound();
            }

            return Ok(training);

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

        // POST: api/Training        
        [ResponseType(typeof(TrainingViewModel))]
        public async Task<IHttpActionResult> Post(TrainingViewModel training)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var trainingEmployee = new TrainingEmployee
            {
                ID = training.ID
            };

            db.TrainingEmployees.Add(trainingEmployee);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (TrainingExists(trainingEmployee.ID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = trainingEmployee.ID }, trainingEmployee);
        }

        // PUT: api/Training/5        
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> Put(Guid id, TrainingViewModel training)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != training.ID)
            {
                return BadRequest();
            }

            TrainingEmployee trainingEmployee = await db.TrainingEmployees.FindAsync(id);
            if (trainingEmployee == null)
            {
                return NotFound();
            }

            db.Entry(trainingEmployee).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TrainingExists(id))
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

        // DELETE: api/Training/5
        [ResponseType(typeof(TrainingViewModel))]
        public async Task<IHttpActionResult> Delete(Guid id)
        {
            TrainingEmployee trainingEmployee = await db.TrainingEmployees.FindAsync(id);
            if (trainingEmployee == null)
            {
                return NotFound();
            }

            db.TrainingEmployees.Remove(trainingEmployee);
            await db.SaveChangesAsync();

            return Ok(trainingEmployee);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool TrainingExists(Guid id)
        {
            return db.TrainingEmployees.Count(e => e.ID == id) > 0;
        }
    }
}
