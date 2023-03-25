using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

using SWP_Steel.Helpper;
namespace SWP_Steel.Pages.Admin.News
{
    public class IndexModel : PageModel
    {
        private readonly SWP_Steel.Models.Swp391Context _context;

        public IndexModel(SWP_Steel.Models.Swp391Context context)
        {
            _context = context;
        }

        public IList<Models.News> News { get; set; }

        public const int ITEM_PER_PAGE = 7;

        [BindProperty(SupportsGet = true, Name = "p")]
        public int currentPage { get; set; }
        public int countPage { get; set; }


        public async Task OnGetAsync(String? SearchString)
        {

            int totalNew = await _context.News.CountAsync();

            countPage = (int)Math.Ceiling((double)totalNew / ITEM_PER_PAGE);

            if (currentPage < 1)
                currentPage = 1;
            if (currentPage > countPage)
                currentPage = countPage;

            var qr = (from a in _context.News
                      orderby a.NewsId ascending
                      select a).Skip((currentPage - 1) * ITEM_PER_PAGE)
                     .Take(ITEM_PER_PAGE);



            List<Models.News> listSearch = new List<Models.News>();
            if (!String.IsNullOrEmpty(SearchString))
            {
                ViewData["searchNews"] = SearchString;
                foreach (var n in _context.News.ToList())
                {
                    string title = Unsign.utf8Convert1(n.Title).ToLower();
                    string search = Unsign.utf8Convert1(SearchString).ToLower();
                    if (title.Contains(search))
                    {
                        listSearch.Add(n);
                    }
                }

                totalNew = listSearch.Count;
                countPage = (int)Math.Ceiling((double)totalNew / ITEM_PER_PAGE);
                if (currentPage < 1)
                    currentPage = 1;
                if (currentPage > countPage)
                    currentPage = countPage;
                var list = (from a in listSearch
                            orderby a.NewsId ascending
                            select a).Skip((currentPage - 1) * ITEM_PER_PAGE)
                     .Take(ITEM_PER_PAGE);
                News = list.ToList();
            }
            else
            {
                News = await qr.ToListAsync();
            }

        }


    }
}
