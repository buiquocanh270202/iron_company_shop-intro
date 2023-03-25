using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.Category;

public class IndexModel : PageModel
{
    private readonly Swp391Context _context;

    public IndexModel(Swp391Context context)
    {
        _context = context;
    }

    public IList<Models.Category> Category { get; set; } = default!;

    public async Task OnGetAsync()
    {
        if (_context.Categories != null) Category = await _context.Categories.ToListAsync();
    }

    public async Task DeleteAsync(int id)
    {
        var category = await _context.Categories.FindAsync(id);
        if (category != null)
        {
            _context.Categories.Remove(category);
            await _context.SaveChangesAsync();
        }
    }
}