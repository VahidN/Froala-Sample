using System.IO;
using System.Web;
using System.Web.Mvc;
using FroalaMvcTest.Models;
using Microsoft.Security.Application;

namespace FroalaMvcTest.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// ذخيره سازي معمولي از طريق فرم
        /// </summary>
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Index(User editor1)
        {
            // todo: save body ...
            return RedirectToAction("Index");
        }

        /// <summary>
        /// ذخيره سازي خودكار
        /// </summary>
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult FroalaAutoSave(string body, int? postId) // نام پارامتر بادي را تغيير ندهيد
        {
            body = Sanitizer.GetSafeHtml(body);

            //todo: save body ...
            return new EmptyResult();
        }


        // todo: مسايل امنيتي آپلود را فراموش نكنيد
        /// <summary>
        /// ذخيره سازي تصاوير ارسالي
        /// </summary>
        [HttpPost]
        public ActionResult FroalaUploadImage(HttpPostedFileBase file, int? postId) // نام پارامتر فايل را تغيير ندهيد
        {
            var fileName = Path.GetFileName(file.FileName);
            var rootPath = Server.MapPath("~/images/");
            file.SaveAs(Path.Combine(rootPath, fileName));
            return Json(new { link = "images/" + fileName }, JsonRequestBehavior.AllowGet);
        }

        // todo: مسايل امنيتي آپلود را فراموش نكنيد
        /// <summary>
        /// ذخيره سازي فايل‌هاي ارسالي
        /// </summary>
        [HttpPost]
        public ActionResult FroalaUploadFile(HttpPostedFileBase file, int? postId) // نام پارامتر فايل را تغيير ندهيد
        {
            var fileName = Path.GetFileName(file.FileName);
            var rootPath = Server.MapPath("~/files/");
            file.SaveAs(Path.Combine(rootPath, fileName));
            return Json(new { link = "files/" + fileName }, JsonRequestBehavior.AllowGet);
        }
    }
}
