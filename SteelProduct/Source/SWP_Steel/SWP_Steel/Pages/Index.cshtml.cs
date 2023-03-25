using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;
using System.Text.Json;

namespace SWP_Steel.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
     
        private readonly Swp391Context dBContext;

        public IndexModel(Swp391Context dBContext, ILogger<IndexModel> logger)
        {
            this.dBContext = dBContext;
            _logger = logger;
        }
        [BindProperty]
        public List<Models.Category> Categories { get; set; }
        public List<Models.Product> Cart { get; set; }
        [BindProperty]
        public List<Models.Product> ProductList { get; set; }

        [BindProperty]
        public List<Models.Product> BestSaleProductList { get; set; }

        public void OnGet()
        {
            String json = HttpContext.Session.GetString("AccSession");
            var catergories = dBContext.Categories.ToList();

            ViewData["catergories"] = catergories;


            Categories = dBContext.Categories.ToList();
            ProductList = dBContext.Products.Include(d => d.OrderDetails).ToList();

            var list = (from od in dBContext.OrderDetails.ToList()
                        group od by od.ProductId into g
                        select new
                        {
                            ProductID = g.Key,
                            NumberProduct = dBContext.OrderDetails.Where(o => o.ProductId == g.Key).ToList().Sum(i => i.Quantity)
						}).OrderByDescending(s => s.NumberProduct).Take(4).ToList();
            List<Models.Product> bestSale = new List<Models.Product>();
            foreach (var item in list)
            {
                Models.Product p = new Models.Product();
                p = dBContext.Products.First(e => e.ProductId == item.ProductID);
                bestSale.Add(p);
            }
            BestSaleProductList = bestSale;
            int TotalProduct = 0;
            if (HttpContext.Session.GetString("cart") != null)
            {
                List<Item>? Products = JsonSerializer.Deserialize<List<Item>>(HttpContext.Session.GetString("cart"));
                TotalProduct = Products.Select(e => e.Product).Count();
            }
        }
    }
}