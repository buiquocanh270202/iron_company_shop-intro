using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.Employee
{
    public class DetailsModel : PageModel
    {
        private readonly Swp391Context _context;

        public DetailsModel(Swp391Context context)
        {
            _context = context;
        }

        [BindProperty] public Models.Employee Employee { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Employees == null)
            {
                return NotFound();
            }

            var employee = await _context.Employees.FirstOrDefaultAsync(m => m.EmployeeId == id);
            if (employee == null)
            {
                return NotFound();
            }
            ViewData["EmployeeStatus"] = !employee.Status ?? false;
            Employee = employee;

            return Page();
        }
        
        public async Task<IActionResult> OnPostAsync()
        {
            var employee = await _context.Employees.FirstOrDefaultAsync(c => c.EmployeeId == Employee.EmployeeId);
            if (employee == null)
            {
                return NotFound();
            }

            employee.Status = Employee.Status;
            _context.Attach(employee).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EmployeeExists(Employee.EmployeeId))
                {
                    return NotFound();
                }

                throw;
            }

            return Page();
        }

        private bool EmployeeExists(int id)
        {
            return (_context.Employees?.Any(e => e.EmployeeId == id)).GetValueOrDefault();
        }
    }
}