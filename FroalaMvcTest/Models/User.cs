using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FroalaMvcTest.Models
{
    public class User
    {
        [Required]
        [AllowHtml]
        public string Description { set; get; }
    }
}