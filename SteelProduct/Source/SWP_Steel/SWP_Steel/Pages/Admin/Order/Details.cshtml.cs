using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.Order
{
    public class DetailsModel : PageModel
    {
        private readonly Swp391Context _context;

        public DetailsModel(Swp391Context context)
        {
            _context = context;
        }

        [BindProperty] public Models.Order Order { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Orders == null)
            {
                return NotFound();
            }

            var order = await _context.Orders.Include(o => o.Customer)
                .Include(o => o.Employee)
                .FirstOrDefaultAsync(m => m.OrderId == id);
            if (order == null)
            {
                return NotFound();
            }

            Order = order;
            var orders = await _context.OrderDetails.Include(od => od.Product)
                .Where(o => o.OrderId == order.OrderId)
                .ToListAsync();
            ViewData["orders"] = orders;
            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            var order = await _context.Orders.FirstOrDefaultAsync(o => o.OrderId == Order.OrderId);
            if (order == null)
            {
                return NotFound();
            }

            order.ShippedDate = Order.ShippedDate;
            _context.Attach(order).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OrderExists(Order.OrderId))
                {
                    return NotFound();
                }

                throw;
            }

            return Page();
        }

        private bool OrderExists(int id)
        {
            return (_context.Orders?.Any(e => e.OrderId == id)).GetValueOrDefault();
        }
    }
}