using System;
using System.Web.Mvc;
using AccountAtAGlance.Model;
using AccountAtAGlance.Model.Repository;
using AccountAtAGlance.Repository;
using Microsoft.Practices.Unity;

namespace AccountAtAGlance.Controllers
{
    public class DataServiceController : Controller
    {
        IAccountRepository _AccountRepository;
        ISecurityRepository _SecurityRepository;
        IMarketsAndNewsRepository _MarketRepository;

        public DataServiceController(IAccountRepository acctRepo, ISecurityRepository secRepo, IMarketsAndNewsRepository marketRepo)
        {
            _AccountRepository = acctRepo;
            _SecurityRepository = secRepo;
            _MarketRepository = marketRepo;
        }

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

            return Json(new { Markets = marketQuotes, News = news }, JsonRequestBehavior.AllowGet);
        }

    }
}
