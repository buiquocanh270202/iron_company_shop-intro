using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.Product
{
    public class EditModel : PageModel
    {
        private readonly Swp391Context _context;
        private readonly IWebHostEnvironment _hostEnvironment;

        public EditModel(Swp391Context context, IWebHostEnvironment hostEnvironment)
        {
            _context = context;
            _hostEnvironment = hostEnvironment;
        }

        [BindProperty] public Models.Product Product { get; set; } = default!;

        [BindProperty] public IFormFile? Image { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Products == null)
            {
                return NotFound();
            }

            var product = await _context.Products.FirstOrDefaultAsync(m => m.ProductId == id);
            if (product == null)
            {
                return NotFound();
            }

            Product = product;
            ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "CategoryName");
            return Page();
        }

        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see https://aka.ms/RazorPagesCRUD.
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "CategoryName");
                return Page();
            }

            if (Image != null)
            {
                var path = Path.Combine(_hostEnvironment.ContentRootPath, "wwwroots/uploads", Product.Image!);
                if (System.IO.File.Exists(path))
                {
                    System.IO.File.Delete(path);
                }

                var fileName = GetUniqueName(Image!.FileName);
                var uploads = Path.Combine(_hostEnvironment.ContentRootPath, "wwwroot/uploads");
                var filePath = Path.Combine(uploads, fileName);
                await using (var fs = new FileStream(filePath, FileMode.Create))
                {
                    await Image.CopyToAsync(fs);
                }

                Product.Image = fileName;
            }

            _context.Attach(Product).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductExists(Product.ProductId))
                {
                    return NotFound();
                }

                throw;
            }

            return RedirectToPage("./Index");
        }

        private bool ProductExists(int id)
        {
            return (_context.Products?.Any(e => e.ProductId == id)).GetValueOrDefault();
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