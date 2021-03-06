﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Globalization;
using System.Web.Security;

namespace MyStore.App.Models.Authentication
{
    public class UsersContext : DbContext
    {
        public UsersContext()
            : base("name=UserEntities")
        {

        }

        public DbSet<UserProfile> UserProfiles { get; set; }
        public DbSet<ExternalUserInformation> ExternalUsers { get; set; }
    }

    [Table("UserProfile")]
    public class UserProfile
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string EmailAddress { get; set; }
        public string FullName { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
    }

    public class RegisterExternalLoginModel
    {
        [Required]
        [Display(Name = "Tên Hiển Thị Trên Website")]
        public string UserName { get; set; }


        [Display(Name = "Họ & Tên")]
        public string FullName { get; set; }

        [Display(Name = "Địa chỉ email")]
        public string Email { get; set; }

        public bool Verified { get; set; }
        public string ExternalLoginData { get; set; }

    }

    [Table("ExtraUserInformation")]
    public class ExternalUserInformation
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string FullName { get; set; }
        public string Link { get; set; }
        public bool? Verified { get; set; }
    }

    public class LocalPasswordModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Current password")]
        public string OldPassword { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "New password")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm new password")]
        [Compare("NewPassword", ErrorMessage = "The new password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }

    public class LoginModel
    {
        [Required]
        [Display(Name = "Email")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [Display(Name = "Ghi nhớ đăng nhập?")]
        public bool RememberMe { get; set; }
    }

    public class RegisterModel
    {
        [Required]
        [Display(Name = "Tên đăng nhập")]
        [EmailAddress(ErrorMessage = "Địa chỉ email không hợp lệ.")]
        public string UserName { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "Mật khẩu {0} phải có ít nhất {2} ký tự.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "Mật khẩu và xác nhận mật khẩu không đúng.")]
        public string ConfirmPassword { get; set; }
        /*
        [Required]
        [Display(Name = "Email")]
        [StringLength(1000, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        public string EmailAddress { get; set; }
        public string FullName { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
         * */
    }

    public class ExternalLogin
    {
        public string Provider { get; set; }
        public string ProviderDisplayName { get; set; }
        public string ProviderUserId { get; set; }
    }

    public class RecoveryModel
    {
        [Required]
        [Display(Name = "Email")]
        [EmailAddress(ErrorMessage = "Địa chỉ email không hợp lệ")]
        public string UserName { get; set; }
    }

    public class RecoveryModelConfirmed
    {
        public string RecoveryToken { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "Mật khẩu {0} phải có ít nhất {2} ký tự.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Mật khẩu mới")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("NewPassword", ErrorMessage = "Mật khẩu và xác nhận mật khẩu không đúng.")]
        public string ConfirmPassword { get; set; }
    }
}
