using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;

using MyStore.App.Models.MyData;

namespace MyStore.App.Controllers
{
    public class VoteController : Controller
    {
        private MyStoreEntities db = null;
        public VoteController()
        {
            db = new MyStoreEntities();
        }
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        [HttpPost]
        public JsonResult VoteTo(short voteType, int id = 0, int score = 1)
        {
            try
            {
                //try get VoteType
                VoteType currentType = VoteType.Product;
                Enum.TryParse<VoteType>(voteType.ToString(), out currentType);

                if (!WebSecurity.IsAuthenticated)
                    return Json(new
                    {
                        isSuccess = false,
                        message = Utilities.MessageBoxHelper.GetLoginMessage()
                    });

                string ip = Request.UserHostAddress;
                bool isVoted = db.Votes
                                 .Any(p => p.ip_address == ip &&
                                      p.vote_type == currentType &&
                                      p.vote_object_id == id);
                //Check user has already vote to this object
                if (isVoted)
                    return Json(new
                    {
                        isSuccess = false,
                        message = Utilities.MessageBoxHelper.GetVotedMessage()
                    });

                Vote newVote = new Vote()
                {
                    ip_address = ip,
                    vote_object_id = id,
                    vote_type = currentType,
                    vote_score = score
                };
                db.Votes.Add(newVote);
                db.SaveChanges();


                int totalScore = db.Votes.Where(p => p.vote_object_id == id && p.vote_type == currentType).Sum(p => p.vote_score) ?? 0;
                int totalVote = db.Votes.Where(p => p.vote_object_id == id && p.vote_type == currentType).Count();

                switch (currentType)
                {
                    case VoteType.Product:
                        Product product = db.Products.Find(id);
                        product.total_vote_score = totalScore;
                        product.total_vote_count = totalVote;
                        break;
                    case VoteType.Blog:
                        Blog blog = db.Blogs.Find(id);
                        blog.blog_total_score = totalScore;
                        blog.blog_total_vote = totalVote;
                        break;
                    default:
                        break;
                }

                db.SaveChanges();

                return Json(new
                {
                    isSuccess = true,
                    message = Utilities.MessageBoxHelper.GetThanksMessage(),

                    votedUrl = Url.Action("BlogVotePartial",
                                          "Blog",
                                          new
                                          {
                                              totalScore = totalScore,
                                              totalVoted = totalVote
                                          })
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    isSuccess = false,
                    message = Utilities.MessageBoxHelper.GetFailMessage()
                });
            }
        }

    }
}
