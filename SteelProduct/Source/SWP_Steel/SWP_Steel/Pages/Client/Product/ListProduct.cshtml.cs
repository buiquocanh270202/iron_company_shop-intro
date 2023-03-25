using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;
using System.Security.Cryptography;
using System.Text.Json;

namespace SWP_Steel.Pages.Client.Product
{
    public class ListProductModel : PageModel
    {
        private readonly Swp391Context dBContext;
       
       
        [BindProperty]
        public Models.Product Product { get; set; }
        [BindProperty]
        public List<Models.Product> Products { get; set; }
       
        public int TotalPage { get; set; }
        public int CurPage { get; set; }
       
        public ListProductModel(Swp391Context dBContext)
        {
            this.dBContext = dBContext;
            this.Products = new List<Models.Product>();
           
        }
        public async Task<IActionResult> OnGet(int catId, int search)
        {          
            int page = 0;
            search = 0;
            String searchId = HttpContext.Session.GetString("Search");
            
            if (searchId != null && searchId != "")
            {
                search = int.Parse(searchId);
            }
           
            var queryParams = Request.Query;
            foreach (var qp in queryParams)
            {
                if (qp.Key == "page")
                {
                    page = int.Parse(qp.Value);
                }
            }

            if (page <= 0)
            {
                page = 1;
            }
            var PageSize = 10;
            int StartIndex = (page - 1) * PageSize + 1;
            if (catId == null)
            {
                catId = 1;
            }
            
            
            var products = dBContext.Products.Where(p => p.CategoryId == catId).ToList();
           

            if (search == 1)
            {
                products = products.Where(p => p.CategoryId == catId).ToList();
               
                

            }
           /* if (search == 5)
            {
                var list = (from od in dBContext.OrderDetails.ToList()
                            group od by od.ProductId into g
                            select new
                            {
                                ProductID = g.Key,
                                NumberProduct = g.Count()
                            }).OrderByDescending(s => s.NumberProduct).ToList();
                List<Models.Product> listSale = new List<Models.Product>();
                foreach (var product in list)
                {
                    foreach (var item in products)
                    {
                        if (item.ProductId == product.ProductID)
                        {
                            listSale.Add(item);
                        }
                    }
                }
                List<Models.Product> bestSale = new List<Models.Product>();
                foreach (var item in listSale)
                {
                    Models.Product p = new Models.Product();
                    p = dBContext.Products.First(e => e.ProductId == item.ProductId);
                    bestSale.Add(p);
                }

                products = bestSale;



            }*/
            if (search == 2)
            {
                products = products.OrderByDescending(p => p.ProductId).ToList();
               
            }
            if (search == 3)
            {
                products = products.OrderBy(p => p.UnitPrice).ToList();
               
                
            }
            if (search == 4)
            {
                products = products.OrderByDescending(p => p.UnitPrice).ToList();
               
                
            }
            int TotalProduct = products.Count();
            Products = products.Skip(StartIndex - 1).Take(PageSize).ToList();

            int Totalpage = TotalProduct / PageSize;
            if (TotalProduct % PageSize != 0)
            {
                Totalpage++;
            }
            ViewData["products"] = products;
            ViewData["TotalPage"] = Totalpage;
            ViewData["CurPage"] = page;
            
            TotalPage = Totalpage;
            CurPage = page;
            var catergories = dBContext.Categories.ToList();
           

            ViewData["catergories"] = catergories;
            
            ViewData["cat"] = catId;
            HttpContext.Session.SetString("CatId", catId.ToString());
            return Page();
        }
        public IActionResult OnPostSearch()
        {
            var id = Request.Form["Search"];
            var catId= HttpContext.Session.GetString("CatId");
            HttpContext.Session.SetString("Search", id);
            return Redirect("/listproduct/"+catId+"/"+id);
        }

        
    }
}
