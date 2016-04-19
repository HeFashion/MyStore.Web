using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using MyStore.App.Models.MyData;

using PagedList;

namespace MyStore.App.Controllers
{
    public class BlogController : Controller
    {
        private MyStoreEntities db = new MyStoreEntities();

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
            return View(blog);
        }

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

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}