using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Web.WebPages.OAuth;
using MyStore.App.Models;
using DotNetOpenAuth.GoogleOAuth2;

namespace MyStore.App
{
    public static class AuthConfig
    {
        public static void RegisterAuth()
        {
            // To let users of this site log in using their accounts from other sites such as Microsoft, Facebook, and Twitter,
            // you must update this site. For more information visit http://go.microsoft.com/fwlink/?LinkID=252166

            //OAuthWebSecurity.RegisterMicrosoftClient(
            //    clientId: "",
            //    clientSecret: "");

            //OAuthWebSecurity.RegisterTwitterClient(
            //    consumerKey: "",
            //    consumerSecret: "");

            OAuthWebSecurity.RegisterFacebookClient(
                appId: "1670009249904633",
                appSecret: "c0acabf2bf4d4e8f184c5beae668fbde");

            var client = new GoogleOAuth2Client(
                clientId: "1076248056848-kc8ph7l3gpk86b2hsspkn3jkpm7ftrj2.apps.googleusercontent.com",
                clientSecret: "x5oUuyHPzY5Q5em7zVynxUxw"
                );
            var extraData = new Dictionary<string, object>();
            extraData.Add("name", null);
            extraData.Add("link", null);
            OAuthWebSecurity.RegisterClient(client, "Google+", extraData);
        }
    }
}
