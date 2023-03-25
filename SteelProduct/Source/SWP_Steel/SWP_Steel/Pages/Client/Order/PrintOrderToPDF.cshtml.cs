using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Client.Order
{
    public class PrintOrderToPDFModel : PageModel
    {
        private readonly Swp391Context dBContext;

        public PrintOrderToPDFModel(Swp391Context dBContext)
        {
            this.dBContext = dBContext;
        }

        public async Task<IActionResult> OnGet(int orderId)
        {
            var order = await dBContext.OrderDetails.Include(o => o.Order).Include(o => o.Product)
                .Where(o => o.OrderId == orderId).ToListAsync();
            var orderInfo = await dBContext.Orders
               .Where(o => o.OrderId == orderId).FirstOrDefaultAsync();
            var customer = dBContext.Customers.Where(o => o.CustomerId == orderInfo.CustomerId).FirstOrDefault();
            ViewData["customer"] = customer;
            ViewData["order"] = order;
            ViewData["orderInfo"] = orderInfo;
            return Page();
        }
    }
}
