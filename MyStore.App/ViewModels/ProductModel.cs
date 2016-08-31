using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace MyStore.App.ViewModels
{
    public class ProductModel
    {
        public int Id { get; set; }
        public string Type { get; set; }
        public string Name { get; set; }
        public string UOM { get; set; }
        public string Description { get; set; }
        public decimal? Price { get; set; }
        public string Image { get; set; }
        public DateTime DateCreated { get; set; }
        public string OtherDetails { get; set; }
        public int Total_Voted { get; set; }
        public int Total_Score { get; set; }
        public Int16 Sale_Off { get; set; }

        public string GenerateSlug()
        {
            string phrase = string.Format("{0}-{1}", Id, Description);

            string str = RemoveVietnameseSign(phrase).ToLower();
            // invalid chars           
            str = Regex.Replace(str, @"[^a-z0-9\s-]", "");
            // convert multiple spaces into one space   
            str = Regex.Replace(str, @"\s+", " ").Trim();
            // cut and trim 
            str = str.Substring(0, str.Length <= 45 ? str.Length : 45).Trim();
            str = Regex.Replace(str, @"\s", "-"); // hyphens   
            return str;
        }

        private string RemoveVietnameseSign(string text)
        {
            string[] arr1 = new string[] { 
                                    "á", "à", "ả", "ã", "ạ", "â", "ấ", "ầ", "ẩ", "ẫ", "ậ", "ă", "ắ", "ằ", "ẳ", "ẵ", "ặ",  
                                    "đ",  
                                    "é","è","ẻ","ẽ","ẹ","ê","ế","ề","ể","ễ","ệ",  
                                    "í","ì","ỉ","ĩ","ị",  
                                    "ó","ò","ỏ","õ","ọ","ô","ố","ồ","ổ","ỗ","ộ","ơ","ớ","ờ","ở","ỡ","ợ",  
                                    "ú","ù","ủ","ũ","ụ","ư","ứ","ừ","ử","ữ","ự",  
                                    "ý","ỳ","ỷ","ỹ","ỵ",};
            string[] arr2 = new string[] { 
                "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a",  
                "d",  
                "e","e","e","e","e","e","e","e","e","e","e",  
                "i","i","i","i","i",  
                "o","o","o","o","o","o","o","o","o","o","o","o","o","o","o","o","o",  
                "u","u","u","u","u","u","u","u","u","u","u",  
                "y","y","y","y","y",
            };
            for (int i = 0; i < arr1.Length; i++)
            {
                text = text.Replace(arr1[i], arr2[i]);
                text = text.Replace(arr1[i].ToUpper(), arr2[i].ToUpper());
            }
            return text;
        }
    }
}