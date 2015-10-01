using AccountAtAGlance.Repository;
using Microsoft.Practices.Unity;

namespace AccountAtAGlance.Model
{
    //This is a simplified version of the code shown in the videos
    //The instance of UnityContainer is created in the constructor 
    //rather than checking in the Instance property and performing a lock if needed
    public static class ModelContainer
    {
        private static IUnityContainer _Instance;

        //Private constructor: When the class is first accessed the constructor will still be invoked (because the class is static) - Cant call it outside of the class
        //Then when the instance is called by the consumer, we can still get to the registerde types
        //Allows us to leverage compiler features, since we know that a static class will call the constructor the first time it is called, but it is not publically accessible, so it is safe
        static ModelContainer()
        {
            _Instance = new UnityContainer();
        }

        //Unity Container maps interfaces to the concrete classes that you want to use
        //When you want to find "this" interface and resolve it, user "that" class
        
        //UnityDependecyResolver - Possible that instances do not get disposed of properly
        //Therefore we have to manage the lifetime of the instances to be per request so that when they die at the end of a request, they get disposed of properly
        //If a database connection does not get closed, we could get orphan connections which will eat up resources in your database
        //Must therefore make sure that the classes are disposed of properly so that database connections get closed
        //Database connections are unmanaged connections, so they might not get cleaned up by the garbage collector
        //[Unity.MVC3 - Creates a child container per http request and then disposes of the contained resolved IDisposible instances at the end of the request]
        //HierarchicalLifetimeManager => Track the instance and ensure that dispose it called combined with the code that was written for Unity.MVC3
        public static IUnityContainer Instance
        {
            get
            {
                _Instance.RegisterType<IAccountRepository, AccountRepository>(new HierarchicalLifetimeManager());
                _Instance.RegisterType<ISecurityRepository, SecurityRepository>(new HierarchicalLifetimeManager());
                _Instance.RegisterType<IMarketsAndNewsRepository, MarketsAndNewsRepository>(new HierarchicalLifetimeManager());
                return _Instance;
            }
        }
    }
}
