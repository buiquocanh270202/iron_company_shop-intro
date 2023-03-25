using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.Category
{
    public class DetailsModel : PageModel
    {
        private readonly Swp391Context _context;

        public DetailsModel(Swp391Context context)
        {
            _context = context;
        }

        public Models.Category Category { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Categories == null)
            {
                return NotFound();
            }

            var category = await _context.Categories.FirstOrDefaultAsync(m => m.CategoryId == id);
            if (category == null)
            {
                return NotFound();
            }
            
            Category = category;
            var products = await _context.Products.Where(p => p.CategoryId == category.CategoryId).ToListAsync();
            ViewData["products"] = products;

            return Page();
        }
    }
}