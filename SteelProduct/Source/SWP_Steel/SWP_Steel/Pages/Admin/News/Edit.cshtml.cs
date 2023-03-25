using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Helpper;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.News
{
	public class EditModel : PageModel
	{
		private readonly SWP_Steel.Models.Swp391Context _context;

		public EditModel(SWP_Steel.Models.Swp391Context context)
		{
			_context = context;
		}

		[BindProperty]
		public Models.News News { get; set; } = default!;

		public async Task<IActionResult> OnGetAsync(int? id)
		{
			if (id == null || _context.News == null)
			{
				return NotFound();
			}

			var news = await _context.News.FirstOrDefaultAsync(m => m.NewsId == id);
			if (news == null)
			{
				return NotFound();
			}
			News = news;
			ViewData["EmployeeId"] = new SelectList(_context.Employees, "EmployeeId", "EmployeeId");
			return Page();
		}

		// To protect from overposting attacks, enable the specific properties you want to bind to.
		// For more details, see https://aka.ms/RazorPagesCRUD.
		public async Task<IActionResult> OnPostAsync(Microsoft.AspNetCore.Http.IFormFile fThumb)
		{
			if (!ModelState.IsValid)
			{
				return Page();
			}

			_context.Attach(News).State = EntityState.Modified;

			try
			{
				if (fThumb != null)
				{
					string extension = Path.GetExtension(fThumb.FileName);
					string imageName = Utilities.SEOUrl(News.Title) + extension;
					News.Image = await Utilities.UploadFile(fThumb, @"news", imageName.ToLower());
				}
				if (string.IsNullOrEmpty(News.Image)) News.Image = "default.jpg";
				News.ModifyAt = DateTime.Now;
				await _context.SaveChangesAsync();
			}
			catch (DbUpdateConcurrencyException)
			{
				if (!NewsExists(News.NewsId))
				{
					return NotFound();
				}
				else
				{
					throw;
				}
			}

			return RedirectToPage("./Index");
		}


		private bool NewsExists(int id)
		{
			return _context.News.Any(e => e.NewsId == id);
		}
	}
}
