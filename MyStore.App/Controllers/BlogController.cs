using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using MyStore.App.Models.MyData;
using MyStore.App.ViewModels;

using PagedList;
using WebMatrix.WebData;

namespace MyStore.App.Controllers
{
    public class BlogController : Controller
    {
        private MyStoreEntities db = null;

        public BlogController()
        {
            db = new MyStoreEntities();

        }
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        //
        // GET: /Blog/
        public ActionResult Index(int? page)
        {
            int pageSize = 3;
            int pageNum = page ?? 1;
            var blogs = db.Blogs
                          .OrderByDescending(p => p.blog_id);
            IDictionary<string, string> dCrumbs = new Dictionary<string, string>();
            dCrumbs.Add("Bài Viết", string.Empty);
            ViewData["BreadCrumbs"] = dCrumbs;
            return View(blogs.ToPagedList(pageNum, pageSize));
        }

        //
        // GET: /Blog/Details/5
        public ActionResult Details(int id = 0)
        {
            Blog blog = db.Blogs.Find(id);
            if (blog == null)
            {
                return HttpNotFound();
            }
            int nextId = db.Blogs
                          .Where(p => p.blog_id > id)
                          .OrderBy(p => p.blog_id)
                          .Select(p => p.blog_id)
                          .FirstOrDefault();
            int prvId = db.Blogs
                          .Where(p => p.blog_id < id)
                          .OrderByDescending(p => p.blog_id)
                          .Select(p => p.blog_id)
                          .FirstOrDefault();

            ViewBag.NextId = nextId;
            ViewBag.PrevId = prvId;

            if (blog.blog_total_vote == null || blog.blog_total_vote.Value == 0)
                ViewBag.BlogRate = 0;
            else
                ViewBag.BlogRate = ((float)(blog.blog_total_score ?? 0) / (float)(blog.blog_total_vote ?? 1));

            IDictionary<string, string> dCrumbs = new Dictionary<string, string>();
            dCrumbs.Add("Bài Viết", Url.Action("Index", "Blog"));
            dCrumbs.Add("Chi Tiết", string.Empty);
            ViewData["BreadCrumbs"] = dCrumbs;

            ViewData["BlogActor"] = db.Blog_Actors.Find(blog.actor_id);

            return View("Details", blog);
        }

        public PartialViewResult BlogVotePartial(int totalScore = 0, int totalVoted = 1)
        {
            var model = new BlogVoteViewModel()
            {
                TotalScore = totalScore,
                TotalVote = totalVoted
            };
            return PartialView("_BlogVotePartial", model);
        }
    }
}