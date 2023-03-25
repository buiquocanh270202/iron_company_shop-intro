using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.Customer
{
    public class DetailsModel : PageModel
    {
        private readonly Swp391Context _context;

        public DetailsModel(Swp391Context context)
        {
            _context = context;
        }
        
        [BindProperty]
      public Models.Customer Customer { get; set; } = default!; 

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Customers == null)
            {
                return NotFound();
            }

            var customer = await _context.Customers.FirstOrDefaultAsync(m => m.CustomerId == id);
            if (customer == null)
            {
                return NotFound();
            }

            ViewData["CustomerStatus"] = !customer.Status ?? false;
            Customer = customer;
            var orders = await _context.Orders.Where(o => o.CustomerId == customer.CustomerId).ToListAsync();
            ViewData["orders"] = orders;
            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            var customer = await _context.Customers.FirstOrDefaultAsync(c => c.CustomerId == Customer.CustomerId);
            if (customer == null)
            {
                return NotFound();
            }

            customer.Status = Customer.Status;
            _context.Attach(customer).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CustomerExists(Customer.CustomerId))
                {
                    return NotFound();
                }

                throw;
            }

            return Page();
        }

        private bool CustomerExists(int id)
        {
            return (_context.Customers?.Any(e => e.CustomerId == id)).GetValueOrDefault();
        }
    }
}
