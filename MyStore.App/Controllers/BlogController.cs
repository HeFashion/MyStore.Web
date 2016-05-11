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
        private int _minId = 1;
        private int _maxId = 1;

        public BlogController()
        {
            db = new MyStoreEntities();
            _maxId = db.Blogs.Max(p => p.blog_id);
            _minId = db.Blogs.Min(p => p.blog_id);
        }
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        //
        // GET: /Blog/

        public ActionResult Index(int? pageNo)
        {
            int pageSize = 3;
            int pageNum = pageNo ?? 1;
            var blogs = db.Blogs.OrderByDescending(p => p.blog_id);

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

            ViewBag.MaxId = _maxId;
            ViewBag.MinId = _minId;

            if (blog.blog_total_vote == null || blog.blog_total_vote.Value == 0)
                ViewBag.BlogRate = 0;
            else
                ViewBag.BlogRate = ((float)(blog.blog_total_score ?? 0) / (float)(blog.blog_total_vote ?? 1));
            return View("Details", blog);
        }

        public ActionResult NextBlog(int currentId = 0)
        {
            int id = currentId + 1;
            return Details(id);
        }

        public ActionResult PrevBlog(int currentId = 1)
        {
            int id = currentId - 1;
            return Details(id);
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

        /*
        //
        // GET: /Blog/Create
        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Blog/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Blog blog)
        {
            if (ModelState.IsValid)
            {
                db.Blogs.Add(blog);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(blog);
        }

        //
        // GET: /Blog/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Blog blog = db.Blogs.Find(id);
            if (blog == null)
            {
                return HttpNotFound();
            }
            return View(blog);
        }

        //
        // POST: /Blog/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Blog blog)
        {
            if (ModelState.IsValid)
            {
                db.Entry(blog).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(blog);
        }

        //
        // GET: /Blog/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Blog blog = db.Blogs.Find(id);
            if (blog == null)
            {
                return HttpNotFound();
            }
            return View(blog);
        }

        //
        // POST: /Blog/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Blog blog = db.Blogs.Find(id);
            db.Blogs.Remove(blog);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        */
    }
}