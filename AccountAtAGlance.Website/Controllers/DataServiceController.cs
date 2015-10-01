using AccountAtAGlance.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AccountAtAGlance.Website.Controllers
{
    //When the website runs, it calls the default constructor - Dan Wahlin (Building ASP.NET MVC Apps: Mod 4, Vid 5)
    //Not required if you use a dependecy resolver
    public class DataServiceController : Controller
    {
        IAccountRepository _AccountRepository;
        ISecurityRepository _SecurityRepository;
        IMarketsAndNewsRepository _MarketRepository;

        //Dependency Injection => Dynamically figure out at runtime which classes to use  - Dan Wahlin (See Above)
        public DataServiceController(IAccountRepository acctRepo, ISecurityRepository secRepo, IMarketsAndNewsRepository marketRepo)
        {
            _AccountRepository = acctRepo;
            _SecurityRepository = secRepo;
            _MarketRepository = marketRepo;
        }

        //AllowGet - Json returns a Post by default, but we want to allow a get as well
        //Most Secure way would be to require the client to do a post operation, in which case you won't need AllowGet
        public ActionResult GetAccount(string acctNumber)
        {
            return Json(_AccountRepository.GetAccount(acctNumber), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetQuote(string symbol)
        {
            return Json(_SecurityRepository.GetSecurity(symbol), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetMarketIndexes()
        {
            return Json(_MarketRepository.GetMarkets(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetTickerQuotes()
        {
            var marketQuotes = _MarketRepository.GetMarketTickerQuotes();
            var securityQuotes = _SecurityRepository.GetSecurityTickerQuotes();
            marketQuotes.AddRange(securityQuotes);
            var news = _MarketRepository.GetMarketNews();

            //Returns a Json array
            //new {} => Annonymous type - Object with no name, because json does not care about object names, only about properties
            return Json(new { Markets = marketQuotes, News = news }, JsonRequestBehavior.AllowGet);
        }
    }
}
