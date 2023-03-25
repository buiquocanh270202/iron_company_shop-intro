using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SWP_Steel.Models;
using System;

namespace SWP_Steel.Pages.Admin.Product
{
    public class CreateModel : PageModel
    {
        private readonly Swp391Context _context;
        private readonly IWebHostEnvironment _hostEnvironment;

        public CreateModel(Swp391Context context, IWebHostEnvironment hostEnvironment)
        {
            _context = context;
            _hostEnvironment = hostEnvironment;
        }

        public IActionResult OnGet()
        {
            ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "CategoryName");
            return Page();
        }

        [BindProperty] public Models.Product Product { get; set; } = default!;
        [BindProperty] public IFormFile Image { get; set; } = default!;


        // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid || Product == null)
            {
                ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "CategoryName");
                return Page();
            }

            var fileName = GetUniqueName(Image.FileName);
            var uploads = Path.Combine(_hostEnvironment.ContentRootPath, "wwwroot/uploads");
            var filePath = Path.Combine(uploads, fileName);
            await using (var fs = new FileStream(filePath, FileMode.Create))
            {
                await Image.CopyToAsync(fs);
            }
            Product.Image = fileName;

            _context.Products.Add(Product);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }

        private static string GetUniqueName(string fileName)
        {
            fileName = Path.GetFileName(fileName);
            return string.Concat(Path.GetFileNameWithoutExtension(fileName)
                , "_", Guid.NewGuid().ToString().AsSpan(0, 4)
                , Path.GetExtension(fileName));
        }
    }
}