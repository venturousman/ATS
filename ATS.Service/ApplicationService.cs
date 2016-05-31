using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace ATS.Service
{
    public interface IApplicationService<T> : IDisposable where T : class
    {
        IEnumerable<T> Get(
            Expression<Func<T, bool>> filter = null,
            Func<IQueryable<T>, IOrderedQueryable<T>> orderBy = null,
            string includeProperties = "");

        T GetById(object id);
        T Insert(T entity);
        IEnumerable<T> Insert(IEnumerable<T> entities);
        void Update(T entity);
        void Delete(T entity);
        void Delete(object id);
    }

    //public abstract class ApplicationService<T> : IApplicationService<T> where T : class
    //{
    //    //DbContext context;
    //    IUnitOfWork unitOfWork;
    //    IApplicationRepository<T> repository;

    //    public ApplicationService(IUnitOfWork unitOfWork, IApplicationRepository<T> repository)
    //    {
    //        this.unitOfWork = unitOfWork;
    //        this.repository = repository;
    //    }

    //    public virtual IEnumerable<T> Get(
    //        Expression<Func<T, bool>> filter = null,
    //        Func<IQueryable<T>,
    //        IOrderedQueryable<T>> orderBy = null,
    //        string includeProperties = "")
    //    {
    //        return repository.Get(filter, orderBy, includeProperties);
    //    }

    //    public virtual T GetById(object id)
    //    {
    //        return repository.GetById(id);
    //    }

    //    public virtual T Insert(T role)
    //    {
    //        var entity = repository.Insert(role);
    //        unitOfWork.Save();
    //        return entity;
    //    }

    //    public virtual IEnumerable<T> Insert(IEnumerable<T> roles)
    //    {
    //        var entities = repository.Insert(roles);
    //        unitOfWork.Save();
    //        return entities;
    //    }

    //    public virtual void Update(T role)
    //    {
    //        repository.Update(role);
    //        unitOfWork.Save();
    //    }

    //    public virtual void Delete(T role)
    //    {
    //        repository.Delete(role);
    //        unitOfWork.Save();
    //    }

    //    public virtual void Delete(object id)
    //    {
    //        repository.Delete(id);
    //        unitOfWork.Save();
    //    }

    //    public void Dispose()
    //    {
    //        this.unitOfWork.Dispose();
    //    }
    //}
}
