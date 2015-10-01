using Microsoft.Practices.Unity;
using AccountAtAGlance.Model.Repository;

namespace AccountAtAGlance.Model
{
    public static class ModelContainer
    {
        private static readonly object _Key = new object();
        private static UnityContainer _Instance;

        public static UnityContainer Instance
        {
            get
            {
                if (_Instance == null)
                {
                    lock (_Key)
                    {
                        if (_Instance == null)
                        {
                            _Instance = new UnityContainer();
                            _Instance.RegisterType<IAccountRepository, AccountRepository>();
                            _Instance.RegisterType<ISecurityRepository, SecurityRepository>();
                            _Instance.RegisterType<IMarketsAndNewsRepository, MarketsAndNewsRepository>();
                        }
                    }
                }
                return _Instance;
            }
        }
    }
}
