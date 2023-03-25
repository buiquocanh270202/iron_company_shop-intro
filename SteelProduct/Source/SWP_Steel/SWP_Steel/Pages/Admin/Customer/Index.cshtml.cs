using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Helpper;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.Customer
{
    public class IndexModel : PageModel
    {
        private readonly Swp391Context _context;

        public IndexModel(Swp391Context context)
        {
            _context = context;
        }

        public IList<Models.News> News { get; set; }

        public const int ITEM_PER_PAGE = 7;

        [BindProperty(SupportsGet = true, Name = "p")]
        public int currentPage { get; set; }
        public int countPage { get; set; }

        public IList<Models.Customer> Customer { get; set; } = default!;

        public async Task OnGetAsync(String? SearchString)
        {

            List<Models.Customer> listSearch = new List<Models.Customer>();
            if (!String.IsNullOrEmpty(SearchString))
            {

                ViewData["searchCustommer"] = SearchString;
                foreach (var n in _context.Customers.ToList())
                {

                    string title = Unsign.utf8Convert1(n.ContactName).ToLower();
                    string search = Unsign.utf8Convert1(SearchString).ToLower();
                    if (title.Contains(search))
                    {
                        listSearch.Add(n);
                    }
                }
                int totalNew = listSearch.Count();
                countPage = (int)Math.Ceiling((double)totalNew / ITEM_PER_PAGE);
                if (currentPage < 1)
                    currentPage = 1;
                if (currentPage > countPage)
                    currentPage = countPage;
                var list = (from a in listSearch
                            orderby a.CompanyName ascending
                            select a).Skip((currentPage - 1) * ITEM_PER_PAGE)
                     .Take(ITEM_PER_PAGE);
                Customer = list.ToList();

            }
            else
            {

                int totalNew = await _context.Customers.CountAsync();

                countPage = (int)Math.Ceiling((double)totalNew / ITEM_PER_PAGE);

                if (currentPage < 1)
                    currentPage = 1;
                if (currentPage > countPage)
                    currentPage = countPage;

                var Cus = (from a in _context.Customers
                           orderby a.CompanyName descending
                           select a).Skip((currentPage - 1) * ITEM_PER_PAGE)
                         .Take(ITEM_PER_PAGE);
                Customer = await Cus.ToListAsync();
            }


        }
    }
}