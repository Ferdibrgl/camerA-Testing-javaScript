using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using PrjAutoShop.Test_Drive;
using System.ComponentModel.Design;
using System.Web.Configuration;

namespace PrjAutoShop.Test_Drive
{
    public partial class camera_testing : System.Web.UI.Page
    {
        private static int i;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod()]
        public static bool SaveCapturedImage(string data)
        {
            //string Raja9928 = @"G:\Upload";

            //if (!Directory.Exists(@"~/Raja9928"))
            //{
            //   Directory.CreateDirectory(@"~/Raja9925");
            //} 

            string fileName = DateTime.Now.ToString("dd-MM-yy hh-mm-ss");

            //Convert Base64 Encoded string to Byte Array.
            byte[] byteBuffer = Convert.FromBase64String(data.Split(',')[1].ToString());
            //byte[] imageBytes = Convert.FromBase64String(data.Split(',')[1]);

            //Save the Byte Array as Image File.
            string filePath = HttpContext.Current.Server.MapPath(string.Format("~/Upload/raja9928/{0}.jpg", fileName));
            System.IO.File.WriteAllBytes(filePath, byteBuffer);
            return true;

        }
    }
}
