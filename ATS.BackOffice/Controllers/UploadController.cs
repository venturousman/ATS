using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Excel;
using ATS.Data;
using System.Data.SqlClient;

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
            catch (Exception ex)
            {

                throw;
            }
        }

        private void UpdateEmployeeGlobal(DataTable dataTable)
        {
            try
            {
                dataTable.Columns[0].ColumnName = "UserID";
                dataTable.Columns[1].ColumnName = "EmpStatus";
                dataTable.Columns[2].ColumnName = "EmpType";
                dataTable.Columns[3].ColumnName = "JobLocation";
                dataTable.Columns[4].ColumnName = "JobCode";
                dataTable.Columns[5].ColumnName = "DomainID";
                dataTable.Columns[7].ColumnName = "UserName";
                dataTable.Columns[11].ColumnName = "State";
                dataTable.Columns[12].ColumnName = "PostsalCode";
                dataTable.Columns[15].ColumnName = "HireDate";
                dataTable.Columns[17].ColumnName = "Email";
                dataTable.Columns[18].ColumnName = "HasAccess";
                dataTable.Columns[20].ColumnName = "RegionID";
                dataTable.Columns[21].ColumnName = "RoleID";
                dataTable.Columns[22].ColumnName = "ProfileStatus";
                dataTable.Columns[23].ColumnName = "PositionID";
                dataTable.Columns[24].ColumnName = "IsFullTime";
                dataTable.Columns[25].ColumnName = "NativeDeeplinkUser";
                dataTable.Columns[25].ColumnName = "GamificationUserID";
                dataTable.Columns[25].ColumnName = "Regular";

                using (var context = new ATSEntities())
                {
                    var param = new SqlParameter("@DataTable", SqlDbType.Structured);
                    param.Value = dataTable;
                    param.TypeName = "GlobalEmployee";

                    context.Database.ExecuteSqlCommand("EXEC USP_IMPORT_GLOBALEMPLOYEE @DataTable", param);
                }
            }
            catch (Exception ex)
            {

                throw;
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

                        if (dataTrainingGlobal.Tables.Count > 0)
                        {
                            DataTable dataTable = new DataTable();
                            dataTable = dataTrainingGlobal.Tables[0];
                            UpdateTrainingDataGlobal(dataTable);
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

        private void UpdateTrainingDataGlobal(DataTable dataTable)
        {
            try
            {
                dataTable.Columns[0].ColumnName = "ScheduledOfferingID";
                dataTable.Columns[2].ColumnName = "ItemType";
                dataTable.Columns[3].ColumnName = "ItemID";
                dataTable.Columns[4].ColumnName = "RevisionDate";
                dataTable.Columns[5].ColumnName = "RevisionNumber";
                dataTable.Columns[6].ColumnName = "Seg";
                dataTable.Columns[8].ColumnName = "StartTime";
                dataTable.Columns[9].ColumnName = "EndTime";
                dataTable.Columns[10].ColumnName = "InstructorFirstName";
                dataTable.Columns[11].ColumnName = "InstructorLastName";
                dataTable.Columns[12].ColumnName = "InstructorMiddleName";
                dataTable.Columns[14].ColumnName = "GlobalID";
                dataTable.Columns[15].ColumnName = "LastName";
                dataTable.Columns[16].ColumnName = "FirstName";
                dataTable.Columns[17].ColumnName = "MiddleName";
                dataTable.Columns[19].ColumnName = "Legal Entity";

                //for (int i = 0; i < dataTable.Rows.Count; i++)
                //{
                //    for (int j = 0; j < dataTable.Rows[i].ItemArray.Count(); j++)
                //    {
                //        if (dataTable.Rows[i].ItemArray[j].GetType() == typeof(DBNull))
                //        {
                //            dataTable.Rows[i].ItemArray[j] = "N/A";
                //        }
                //    }
                //}

                using (var context = new ATSEntities())
                {
                    context.Database.Connection.Open();

                    var param = new SqlParameter("@DataTable", SqlDbType.Structured);
                    param.Value = dataTable;
                    param.TypeName = "TrainingBasicData";

                    context.Database.ExecuteSqlCommand("EXEC USP_IMPORT_TRAININGBASICDATA @DataTable", param);
                }
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}