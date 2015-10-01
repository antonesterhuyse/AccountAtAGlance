using System.Web.Mvc;
using AccountAtAGlance.Model.Repository;
using AccountAtAGlance.Repository;

namespace AccountAtAGlance.Controllers
{
    public class UpdateController : Controller
    {

        public ActionResult Index()
        {
            var sr = new SecurityRepository();
            var opStatus = sr.InsertSecurityData();

            if (opStatus.Status)
            {
                var mr = new MarketsAndNewsRepository();
                opStatus = mr.InsertMarketData();

                if (opStatus.Status)
                {
                    var ar = new AccountRepository();
                    opStatus = ar.RefreshAccountsData();
                }
            }

            ViewBag.OperationStatus = opStatus;

            return View();
        }

    }
}
