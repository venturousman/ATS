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
using ATS.Model;
using Microsoft.Ajax.Utilities;

namespace ATS.BackOffice.Controllers
{
    public class UploadController : Controller
    {
        private ATSEntities db;
        // GET: Upload
        private string notSupportFile = null;

        public UploadController()
        {
            notSupportFile = "This file format is not supported, Please choose Excel file!";
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult UploadGlobalEmployee(HttpPostedFileBase upload)
        {
            string result = "";
            try
            {
                if (ModelState.IsValid)
                {
                    if (upload != null && upload.ContentLength > 0)
                    {
                        // We return the interface, so that
                        IExcelDataReader reader = getExcelData(upload);
                        if (reader == null)
                        {
                            result = "notSupportFile";
                        }
                        reader.IsFirstRowAsColumnNames = true;
                        DataSet employeeGlobal = reader.AsDataSet();
                        reader.Close();
                        if (employeeGlobal.Tables.Count > 0)
                        {
                            DataTable dataTable = new DataTable();
                            dataTable = employeeGlobal.Tables[0];
                            result = UpdateGlobalEmployee(dataTable);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                result = "Cannot upload this file!";
            }
            ViewBag.MessageUploadGlobalEmployee = result;
            return View("Index");
        }

        private string UpdateGlobalEmployee(DataTable dataTable)
        {
            try
            {
                db = new ATSEntities();
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

                var param = new SqlParameter("@DataTable", SqlDbType.Structured);
                param.Value = dataTable;
                param.TypeName = "GlobalEmployee";
                db.Database.ExecuteSqlCommand("EXEC USP_IMPORT_GLOBALEMPLOYEE @DataTable", param);
                return "success";
            }
            catch (Exception ex)
            {
                return "Please choose global employee file excel";
            }
        }

        public ActionResult UploadGlobalTraining(HttpPostedFileBase upload)
        {
            string result = "";
            try
            {
                if (ModelState.IsValid)
                {
                    if (upload != null && upload.ContentLength > 0)
                    {
                        IExcelDataReader reader = getExcelData(upload);
                        if (reader == null)
                        {
                            result = notSupportFile;
                        }
                        else
                        {
                            reader.IsFirstRowAsColumnNames = true;

                            DataSet dataTrainingGlobal = reader.AsDataSet();
                            reader.Close();

                            if (dataTrainingGlobal.Tables.Count > 0)
                            {
                                DataTable dataTable = new DataTable();
                                dataTable = dataTrainingGlobal.Tables[0];
                                result = UpdateGlobalTraining(dataTable);
                            }
                        }
                    }
                    else
                    {
                        // ModelState.AddModelError("File", "Please Upload Your file");
                    }
                }
             
            }
            catch (Exception)
            {
                result = "Upload not success!";
            }
            ViewBag.MessageGlobalTraining = result;
            return View("Index");
        }

        private string UpdateGlobalTraining(DataTable dataTable)
        {
            string result = "";
            try
            {
                db = new ATSEntities();
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

                var param = new SqlParameter("@DataTable", SqlDbType.Structured);
                param.Value = dataTable;
                param.TypeName = "TrainingBasicData";
                db.Database.ExecuteSqlCommand("EXEC USP_IMPORT_TRAININGBASICDATA @DataTable", param);
                result = "success";
            }
            catch (Exception ex)
            {
                result = "Could please choose excel file of tranning!";
            }
            return result;
        }

        public ActionResult UploadLocalEmployee(HttpPostedFileBase upload)
        {
            string result = "";
            try
            {
                if (ModelState.IsValid)
                {
                    if (upload != null && upload.ContentLength > 0)
                    {
                        IExcelDataReader reader = getExcelData(upload);
                        if (reader == null)
                        {
                            result = notSupportFile;
                        }
                        else
                        {
                            reader.IsFirstRowAsColumnNames = true;
                            reader.Close();
                            DataSet dataTrainingGlobal = reader.AsDataSet();
                            if (dataTrainingGlobal.Tables.Count > 0)
                            {
                                DataTable dataTable = new DataTable();
                                dataTable = dataTrainingGlobal.Tables[0];
                                result = UpdateLocalEmployee(dataTable);
                            }
                            else
                            {
                                result = "ExcelError";
                            }
                        }
                    }
                   
                }
            }
            catch (Exception)
            {
                result = "Upload not success!";
            }
            ViewBag.MessageUploadLocalEmpoyee = result;
            return View("Index");
        }

        private string UpdateLocalEmployee(DataTable dataTable)
        {
            string result = "";

            try
            {
                db = new ATSEntities();
                var param = new SqlParameter("@DataTable", SqlDbType.Structured);
                param.Value = dataTable;
                param.TypeName = "LocalEmployee";

                db.Database.ExecuteSqlCommand("EXEC USP_IMPORT_LOCALEMPLOYEE @DataTable", param);
                result = "success";
            }
            catch (Exception ex)
            {
                result = "Could please choose excel file of employee local!";
            }
            return result;
        }

        public IQueryable<Employee> GetEmployees()
        {
            //var employees = db.Employees.Where(p=>p.IsActive==1).Select(p => p);
            var employees = db.Employees.Where(p => p.IsActive == true).Select(p => p);
            return employees;
        }

        public ActionResult UploadScanTime(HttpPostedFileBase upload)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (upload != null && upload.ContentLength > 0)
                    {
                        // exceldatareader works with the binary excel file, so it needs a filestream
                        // to get started. this is how we avoid dependencies on ace or interop:
                        string _File = Path.Combine(Server.MapPath("~/TimeData"), upload.FileName);

                        bool blColsCreated = false;
                        DataTable Dt = new DataTable("Temp_RBVH_BadgeReaderData");
                        //string[] allLines = File.ReadAllLines(@"D:\RBVN\BadgeReader\Msg20130722.log");
                        string[] allLines = System.IO.File.ReadAllLines(_File);
                        {
                            for (int i = 0; i < allLines.Length; i++)
                            {
                                string line = allLines[i];
                                string[] items = allLines[i].Split(new char[] { ';' });

                                if (items.Length == 18)
                                {
                                    for (int j = 0; !blColsCreated && j < items.Length; j++)
                                    {
                                        Dt.Columns.Add("col" + Convert.ToString((j + 1)));
                                    }
                                    blColsCreated = true;
                                    DataRow Dr = Dt.NewRow();
                                    for (int k = 0; k < items.Length; k++)
                                    {
                                        Dr[k] = items[k];
                                    }
                                    Dt.Rows.Add(Dr);
                                }
                            }//System.Configuration.ConfigurationManager.ConnectionStrings["ATSEntities"].ToString(), 
                        }
                        BulkInsertData(Dt, "Temp_BadgeReaderData");

                        UpdateData();
                    }
                }
                return View("Index");
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private static void BulkInsertData(DataTable DT, string TableName)
        {
            // Establishing connection                
            SqlConnection cnn = new SqlConnection("Data Source=DESKTOP-37GQ4EC\\SQLEXPRESS;Initial Catalog=TranningManager;Integrated Security=True;MultipleActiveResultSets=True;Application Name=EntityFramework");

            // Getting source data
            //SqlCommand cmd = new SqlCommand("SELECT * FROM Temp_RBVH_BadgeReaderData",cnn); 
            cnn.Open();
            //SqlDataReader rdr = cmd.ExecuteReader(); 

            // Initializing an SqlBulkCopy object
            SqlBulkCopy sbc = new SqlBulkCopy(cnn);

            // Copying data to destination
            sbc.DestinationTableName = TableName;// "Temp_RBVH_BadgeReaderData"; 
            sbc.WriteToServer(DT);

            // Closing connection and the others
            sbc.Close();
            //rdr.Close(); 
            cnn.Close();
        }

        private void UpdateData()
        {
            try
            {
                var param = new SqlParameter("@SwipeDate", SqlDbType.VarChar);
                param.Value = "20160608";

                db.Database.ExecuteSqlCommand("EXEC USP_IMPORT_TIME @SwipeDate", param);
            }
            catch (Exception ex)
            {
                throw;
            }
        }


        private IExcelDataReader getExcelData(HttpPostedFileBase upload)
        {
            // ExcelDataReader works with the binary Excel file, so it needs a FileStream
            // to get started. This is how we avoid dependencies on ACE or Interop:
            Stream stream = upload.InputStream;
            IExcelDataReader reader = null;

            if (upload.FileName.EndsWith(".xls"))
            {
                reader = ExcelReaderFactory.CreateBinaryReader(stream);
            }
            else if (upload.FileName.EndsWith(".xlsx"))
            {
                reader = ExcelReaderFactory.CreateOpenXmlReader(stream);
            }

            return reader;
        }
    }
}