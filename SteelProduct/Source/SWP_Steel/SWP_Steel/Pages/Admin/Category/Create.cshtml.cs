using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.Category;

public class CreateModel : PageModel
{
    private readonly Swp391Context _context;

    public CreateModel(Swp391Context context)
    {
        _context = context;
    }

    [BindProperty] public Models.Category Category { get; set; } = default!;

    public IActionResult OnGet()
    {
        return Page();
    }


    // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
    public async Task<IActionResult> OnPostAsync()
    {
        if (!ModelState.IsValid || _context.Categories == null || Category == null) return Page();

        _context.Categories.Add(Category);
        await _context.SaveChangesAsync();

        return RedirectToPage("./Index");
    }
}