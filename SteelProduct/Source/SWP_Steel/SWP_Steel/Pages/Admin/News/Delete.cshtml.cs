using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.News
{
	public class DeleteModel : PageModel
	{
		private readonly SWP_Steel.Models.Swp391Context _context;

		public DeleteModel(SWP_Steel.Models.Swp391Context context)
		{
			_context = context;
		}

		[BindProperty]
		public Models.News News { get; set; }

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
			else
			{
				News = news;
			}
			return Page();
		}

		public async Task<IActionResult> OnPostAsync(int? id)
		{
			if (id == null || _context.News == null)
			{
				return NotFound();
			}
			var news = await _context.News.FindAsync(id);

			if (news != null)
			{
				News = news;
				_context.News.Remove(News);
				await _context.SaveChangesAsync();
			}

			return RedirectToPage("./Index");
		}
	}
}
