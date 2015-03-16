using System.IO;
using System.Web;
using System.Web.Script.Serialization;

namespace FroalaWebFormsTest
{
    public class FroalaHandler : IHttpHandler
    {
        //todo: براي اينكارها بهتر است از وب اي پي آي استفاده شود
        //todo: يا دو هندلر مجزا يكي براي تصاوير و ديگري براي ذخيره سازي متن

        public void ProcessRequest(HttpContext context)
        {
            var body = context.Request.Form["body"];
            var postId = context.Request.Form["postId"];
            if (!string.IsNullOrWhiteSpace(body) && !string.IsNullOrWhiteSpace(postId))
            {
                //todo: save changes

                context.Response.ContentType = "text/plain";
                context.Response.Write("");
                context.Response.End();
            }

            var files = context.Request.Files;
            if (files.Keys.Count > 0)
            {
                foreach (string fileKey in files)
                {
                    var file = context.Request.Files[fileKey];
                    if (file == null || file.ContentLength == 0)
                        continue;

                    //todo: در اينجا مسايل امنيتي آپلود فراموش نشود
                    var fileName = Path.GetFileName(file.FileName);
                    var rootPath = context.Server.MapPath("~/images/");
                    file.SaveAs(Path.Combine(rootPath, fileName));


                    var json = new JavaScriptSerializer().Serialize(new { link = "images/" + fileName });
                    // البته اينجا يك فايل بيشتر ارسال نمي‌شود
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(json);
                    context.Response.End();
                }
            }

            context.Response.ContentType = "text/plain";
            context.Response.Write("");
            context.Response.End();
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}