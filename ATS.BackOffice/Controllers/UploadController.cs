using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Excel;
using ATS.Data;

namespace ATS.BackOffice.Controllers
{
    public class UploadController : Controller
    {
        // GET: Upload
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult UploadEmployeeGlobal(HttpPostedFileBase upload)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (upload != null && upload.ContentLength > 0)
                    {
                        // ExcelDataReader works with the binary Excel file, so it needs a FileStream
                        // to get started. This is how we avoid dependencies on ACE or Interop:
                        Stream stream = upload.InputStream;

                        // We return the interface, so that
                        IExcelDataReader reader = null;


                        if (upload.FileName.EndsWith(".xls"))
                        {
                            reader = ExcelReaderFactory.CreateBinaryReader(stream);
                        }
                        else if (upload.FileName.EndsWith(".xlsx"))
                        {
                            reader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                        }
                        else
                        {
                            //will check in javascript
                            ModelState.AddModelError("File", "This file format is not supported");
                        }

                        reader.IsFirstRowAsColumnNames = true;

                        DataSet employeeGlobal = reader.AsDataSet();
                        reader.Close();

                        if (employeeGlobal.Tables.Count > 0)
                        {
                            DataTable dataTable = new DataTable();
                            dataTable = employeeGlobal.Tables[0];
                            UpdateEmployeeGlobal(dataTable);
                        }
                    }
                    else
                    {
                        // ModelState.AddModelError("File", "Please Upload Your file");
                    }
                }
                return View("Index");
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void UpdateEmployeeGlobal(DataTable dataTable)
        {
            using (var context = new ATSEntities())
            {
                foreach (DataRow item in dataTable.Rows)
                {
                    context.EmployeeGlobals.Add(new EmployeeGlobal(item.ItemArray));
                }
                context.SaveChanges();
            }
          
        }

        public ActionResult UploadTrainingDataGlobal(HttpPostedFileBase upload)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (upload != null && upload.ContentLength > 0)
                    {
                        // ExcelDataReader works with the binary Excel file, so it needs a FileStream
                        // to get started. This is how we avoid dependencies on ACE or Interop:
                        Stream stream = upload.InputStream;
                        // We return the interface, so that
                        IExcelDataReader reader = null;

                        if (upload.FileName.EndsWith(".xls"))
                        {
                            reader = ExcelReaderFactory.CreateBinaryReader(stream);
                        }
                        else if (upload.FileName.EndsWith(".xlsx"))
                        {
                            reader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                        }
                        else
                        {
                            //will check in javascript
                            ModelState.AddModelError("File", "This file format is not supported");
                        }

                        reader.IsFirstRowAsColumnNames = true;

                        DataSet dataTrainingGlobal = reader.AsDataSet();
                        reader.Close();
                    }
                    else
                    {
                        // ModelState.AddModelError("File", "Please Upload Your file");
                    }
                }
                return View("Index");
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void UpdateTrainingDataGlobal(DataTable dataTable)
        {
            using (var context = new ATSEntities())
            {
                foreach (DataRow item in dataTable.Rows)
                {
                    //context.Schedules.Add(new Schedules(item.ItemArray));
                }
                context.SaveChanges();
            }

        }
    }
}