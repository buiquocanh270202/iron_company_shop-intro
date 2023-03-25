using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Client.News
{
    public class NewsListModel : PageModel
    {
        private readonly Swp391Context _context;

        public NewsListModel(Swp391Context context)
        {
            _context = context;
        }
        public async Task<IActionResult> OnGet()
        {
            var news = _context.News.ToList();
            ViewData["news"] = news;
            return Page();
        }
    }
}
