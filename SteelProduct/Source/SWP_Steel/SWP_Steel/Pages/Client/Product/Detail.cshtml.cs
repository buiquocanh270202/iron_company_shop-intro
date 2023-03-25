using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Client.Product
{
    public class DetailModel : PageModel
    {
        private readonly Swp391Context dBContext;
        public DetailModel(Swp391Context dBContext)
        {
            this.dBContext = dBContext;

        }
		[Route("detail/{pId}/{slug}")]
		public async Task<IActionResult> OnGet(int pId,string slug)
        {
            var product= dBContext.Products.Where(p=> p.ProductId== pId).FirstOrDefault();
            slug = product.ProductName.Replace(" ", "");
            ViewData["product"] = product;
            return Page();
        }
    }
}
