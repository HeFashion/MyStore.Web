using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyStore.App.ViewModels
{
    public class BlogVoteViewModel
    {
        public float Average
        {
            get
            {
                return ((float)(TotalScore ?? 0) / (float)(TotalVote ?? 1));
            }
        }
        public int? TotalScore { private get; set; }
        public int? TotalVote { private get; set; }
    }
}