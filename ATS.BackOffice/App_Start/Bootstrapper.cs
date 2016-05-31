using Autofac;
using Autofac.Integration.Mvc;
using System.Reflection;
using System.Web.Mvc;

namespace ATS.BackOffice.App_Start
{
    public class Bootstrapper
    {
        public static void Run()
        {
            SetAutofacContainer();
        }

        private static void SetAutofacContainer()
        {
            var builder = new ContainerBuilder();
            builder.RegisterControllers(Assembly.GetExecutingAssembly());
            //builder.RegisterType<UnitOfWork>().As<IUnitOfWork>().InstancePerRequest();
            //builder.RegisterType<DbFactory>().As<IDbFactory>().InstancePerRequest();

            // Repositories
            //builder.RegisterAssemblyTypes(typeof(GadgetRepository).Assembly)
            //    .Where(t => t.Name.EndsWith("Repository"))
            //    .AsImplementedInterfaces().InstancePerRequest();

            // Services
            //builder.RegisterAssemblyTypes(typeof(GadgetService).Assembly)
            //   .Where(t => t.Name.EndsWith("Service"))
            //   .AsImplementedInterfaces().InstancePerRequest();

            IContainer container = builder.Build();
            DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
        }
    }

    //public class Bootstrapper
    //{
    //    public static IContainer ApplicationContainerBuider { get; set; }

    //    public static void Run()
    //    {
    //        SetAutofacContainer();
    //    }

    //    private static void SetAutofacContainer()
    //    {
    //        //Autofac Configuration
    //        var builder = new Autofac.ContainerBuilder();

    //        builder.RegisterControllers(typeof(MvcApplication).Assembly).PropertiesAutowired();

    //        builder.RegisterModule(new RepositoryModule());
    //        builder.RegisterModule(new ServiceModule());
    //        builder.RegisterModule(new EFModule());

    //        ApplicationContainerBuider = builder.Build();

    //        DependencyResolver.SetResolver(new AutofacDependencyResolver(ApplicationContainerBuider));
    //    }
    //}


    //public class RepositoryModule : Autofac.Module
    //{
    //    protected override void Load(ContainerBuilder builder)
    //    {
    //        builder.RegisterAssemblyTypes(typeof(RoleRepository).Assembly)
    //               .Where(t => t.Name.EndsWith("Repository"))
    //               .AsImplementedInterfaces()
    //              .InstancePerLifetimeScope();
    //    }
    //}

    //public class ServiceModule : Autofac.Module
    //{
    //    protected override void Load(ContainerBuilder builder)
    //    {

    //        builder.RegisterAssemblyTypes(typeof(RoleService).Assembly)
    //                  .Where(t => t.Name.EndsWith("Service"))
    //                  .AsImplementedInterfaces()
    //                  .InstancePerLifetimeScope();
    //    }
    //}

    //public class EFModule : Autofac.Module
    //{
    //    protected override void Load(ContainerBuilder builder)
    //    {
    //        builder.RegisterModule(new RepositoryModule());
    //        builder.RegisterType(typeof(ApplicationDbContext)).As(typeof(DbContext)).InstancePerLifetimeScope();
    //        builder.RegisterType(typeof(UnitOfWork)).As(typeof(IUnitOfWork)).InstancePerLifetimeScope();
    //    }
    //}
}