using Microsoft.Practices.Unity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AccountAtAGlance.Website.Helpers
{
    //Acts as the mapping between the ModelContainer (your custom code) and the DependencyResolver.SetResolver code in Global.asax.cs that Asp.Net knows about
    //Provides a way for MVC to have standardized methods that it knows to call
    //Gateway of the mapping that Asp.NET MVC understands (IDependecyResolver) and our unity container

    //When a class sees that it needs to resolve an interface to a type, the unitycontainer will handle this
    public class UnityDependencyResolver : IDependencyResolver
    {
        IUnityContainer container;

        public UnityDependencyResolver(IUnityContainer container)
        {
            this.container = container;
        }

        //Service is the class that wants to resolve the dependency
        //Resolve the interfaces for the class
        public object GetService(Type serviceType)
        {
            if (!container.IsRegistered(serviceType) && (serviceType.IsAbstract || serviceType.IsInterface))
                return null;

            return container.Resolve(serviceType);
        }

        public IEnumerable<object> GetServices(Type serviceType)
        {
            return container.ResolveAll(serviceType);
        }
    }
}