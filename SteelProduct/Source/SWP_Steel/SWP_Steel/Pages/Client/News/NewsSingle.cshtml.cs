using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SWP_Steel.Models;
using SWP_Steel.Helpper;

namespace SWP_Steel.Pages.Client.News
{
    public class NewsSingleModel : PageModel
    {
        private readonly Swp391Context _context;

        public NewsSingleModel(Swp391Context context)
        {
            _context = context;
        }
        public async Task<IActionResult> OnGet(string title, int newsId)
        {
            var news = _context.News.Where(n => n.NewsId == newsId).FirstOrDefault();
            string tit = Unsign.utf8Convert1(news.Title).Replace("/", "-");
            title = tit.Replace(" ", "-");
            ViewData["news"] = news;
            return Page();
        }
    }
}
