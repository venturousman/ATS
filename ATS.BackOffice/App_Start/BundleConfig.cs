using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Optimization;

namespace ATS.BackOffice
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            /*bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                "~/Scripts/jquery-{version}.js"));
            */

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                "~/Scripts/jquery.unobtrusive*",
                "~/Scripts/jquery.validate*"));

            #region not used, disable temporarily
            //bundles.Add(new ScriptBundle("~/bundles/knockout").Include(
            //    "~/Scripts/knockout-{version}.js",
            //    "~/Scripts/knockout.validation.js"));

            //bundles.Add(new ScriptBundle("~/bundles/app").Include(
            //    "~/Scripts/sammy-{version}.js",
            //    "~/Scripts/app/common.js",
            //    "~/Scripts/app/app.datamodel.js",
            //    "~/Scripts/app/app.viewmodel.js",
            //    "~/Scripts/app/home.viewmodel.js",
            //    "~/Scripts/app/_run.js")); 
            #endregion

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                "~/Scripts/modernizr-*"));

            #region not used, disable temporarily
            /*bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                   "~/Scripts/bootstrap.js",
                   "~/Scripts/respond.js"));
               */

            //bundles.Add(new StyleBundle("~/Content/css").Include(
            //     "~/Content/bootstrap.css",
            //     "~/Content/Site.css")); 
            #endregion

            #region AdminLTE main scripts and plugins
            bundles.Add(new ScriptBundle("~/bundles/AdminLTEScripts").Include(
                    "~/Themes/AdminLTE-2.3.3/plugins/jQuery/jQuery-2.2.0.min.js",
                    "~/Themes/AdminLTE-2.3.3/plugins/jQueryUI/jQuery-ui.min.js",
                    //Bootstrap 3.3.6
                    "~/Themes/AdminLTE-2.3.3/bootstrap/js/bootstrap.min.js",
                    //plugins
                    //Morris.js charts
                    "~/Themes/AdminLTE-2.3.3/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js",
                    //Sparkline
                    "~/Themes/AdminLTE-2.3.3/plugins/sparkline/jquery.sparkline.min.js",
                    //jvectormap
                    "~/Themes/AdminLTE-2.3.3/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js",
                    "~/Themes/AdminLTE-2.3.3/plugins/jvectormap/jquery-jvectormap-world-mill-en.js",
                    //jQuery Knob Chart
                    "~/Themes/AdminLTE-2.3.3/plugins/knob/jquery.knob.js",
                    //daterangepicker
                    "~/Themes/AdminLTE-2.3.3/plugins/daterangepicker/moment.min.js",
                    "~/Themes/AdminLTE-2.3.3/plugins/daterangepicker/daterangepicker.js",
                    //datepicker
                    "~/Themes/AdminLTE-2.3.3/plugins/datepicker/bootstrap-datepicker.js",
                    //Bootstrap WYSIHTML5
                    "~/Themes/AdminLTE-2.3.3/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js",
                    //Slimscroll
                    "~/Themes/AdminLTE-2.3.3/plugins/slimScroll/jquery.slimscroll.min.js",
                    //FastClick
                    "~/Themes/AdminLTE-2.3.3/plugins/fastclick/fastclick.js",
                    //AdminLTE App
                    "~/Themes/AdminLTE-2.3.3/dist/js/app.min.js"));
            #endregion

            #region AdminLTE CSS           

            var lessBundle = new StyleBundle("~/bundles/AdminLTEStyles").Include(
                "~/Themes/AdminLTE-2.3.3/bootstrap/css/bootstrap.min.css",
                "~/Themes/AdminLTE-2.3.3/build/less/AdminLTE.less",
                "~/Themes/AdminLTE-2.3.3/build/less/skins/_all-skins.less",
                //iCheck
                "~/Themes/AdminLTE-2.3.3/plugins/iCheck/flat/blue.css",
                //Morris chart
                "~/Themes/AdminLTE-2.3.3/plugins/morris/morris.css",                
                //Date Picker
                "~/Themes/AdminLTE-2.3.3/plugins/datepicker/datepicker3.css",
                //jvectormap
                "~/Themes/AdminLTE-2.3.3/plugins/jvectormap/jquery-jvectormap-1.2.2.css",
                //Daterange picker
                "~/Themes/AdminLTE-2.3.3/plugins/daterangepicker/daterangepicker-bs3.css",
                //bootstrap wysihtml5
                "~/Themes/AdminLTE-2.3.3/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css",
                //our style
                "~/Themes/ATS.less"
                );
            
            lessBundle.Transforms.Add(new CssMinify());
            bundles.Add(lessBundle);
            #endregion

            //BundleTable.EnableOptimizations = true;


        }
    }
}
