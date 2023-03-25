using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SWP_Steel.Models;
using SWP_Steel.Helpper;

namespace SWP_Steel.Pages.Admin.News
{
	public class CreateModel : PageModel
	{
		private readonly SWP_Steel.Models.Swp391Context _context;

		public CreateModel(SWP_Steel.Models.Swp391Context context)
		{
			_context = context;
		}

		public IActionResult OnGet()
		{
			ViewData["EmployeeId"] = new SelectList(_context.Employees, "EmployeeId", "EmployeeId");
			return Page();
		}

		[BindProperty]
		public Models.News News { get; set; }

		// To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
		public async Task<IActionResult> OnPostAsync(Microsoft.AspNetCore.Http.IFormFile fThumb)
		{
			if (!ModelState.IsValid)
			{
				return Page();
			}
			else
			{
				if (fThumb != null)
				{
					string extension = Path.GetExtension(fThumb.FileName);
					string imageName = Utilities.SEOUrl(News.Title) + extension;
					News.Image = await Utilities.UploadFile(fThumb, @"news", imageName.ToLower());
				}
				if (string.IsNullOrEmpty(News.Image)) News.Image = "default.jpg";

				News.CreatedAt = DateTime.Now;
				_context.News.Add(News);


			}


			await _context.SaveChangesAsync();

			return RedirectToPage("./Index");
		}
	}
}
