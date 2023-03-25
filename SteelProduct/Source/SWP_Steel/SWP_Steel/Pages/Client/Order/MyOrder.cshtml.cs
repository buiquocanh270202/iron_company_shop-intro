using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;
using System.Text.Json;

namespace SWP_Steel.Pages.Client.Order
{
    public class MyOrderModel : PageModel
    {
        private readonly Swp391Context dBContext;
        public MyOrderModel(Swp391Context dBContext)
        {
            this.dBContext = dBContext;
        }
        [BindProperty]
        public Customer Customer { get; set; }
        [BindProperty]
        public Models.Order Order { get; set; }
        [BindProperty]
        public Models.OrderDetail OrderDetail { get; set; }

        public async Task<IActionResult> OnGet(int accId)
        {
            String json = HttpContext.Session.GetString("AccSession");
            if (json == null)
            {
                return Redirect("/account/signin");
            }        
           
            if (accId == 0)
            {
                return RedirectToPage("/index");
            }
            var acc = await dBContext.Customers.Where(a => a.CustomerId == accId).FirstOrDefaultAsync();
            var orders = await dBContext.Orders.Where(o => o.CustomerId.Equals(acc.CustomerId)).OrderByDescending(o=> o.OrderDate).ToListAsync();
            var cus = dBContext.Customers.Where(a => a.ContactName.Equals("c")).ToList();
            ViewData["Customer"] = acc;
            ViewData["ListOrder"] = orders;
            return Page();
        }
    }
}
