using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text.RegularExpressions;
using System.Web;

namespace MyStore.App.ViewModels
{
    [DataContract]
    [Serializable]
    public class ProductModel
    {
        [DataMember]
        public int Id { get; set; }
        [DataMember]
        public string Type { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string UOM { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public decimal? Price { get; set; }
        [DataMember]
        public string Image { get; set; }
        [DataMember]
        public DateTime DateCreated { get; set; }
        [DataMember]
        public string OtherDetails { get; set; }
        [DataMember]
        public int Total_Voted { get; set; }
        [DataMember]
        public int Total_Score { get; set; }
        [DataMember]
        public Int16 Sale_Off { get; set; }

        protected internal ProductModel() { }

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