using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Client;

public class EditProfileModel : PageModel
{
    private readonly Swp391Context dBContext;

    public EditProfileModel(Swp391Context dBContext)
    {
        this.dBContext = dBContext;
    }

    [BindProperty] public Customer Customer { get; set; }

    public async Task<IActionResult> OnGet(int accId)
    {
        if (accId == 0) return RedirectToPage("/index");
        var acc = await dBContext.Customers.Where(a => a.CustomerId == accId).FirstOrDefaultAsync();

        ViewData["CompanyName"] = acc.CompanyName;
        ViewData["ContactTitle"] = acc.ContactTitle;
        ViewData["ContactName"] = acc.ContactName;
        ViewData["Address"] = acc.Address;
        ViewData["Phone"] = acc.Phone;

        return Page();
    }

    public async Task<IActionResult> OnPost()
    {
        string accIdStr = Request.Form["accId"];
        if (accIdStr != null && !accIdStr.Equals(""))
        {
            var accId = int.Parse(accIdStr);
            if (accId == 0) return RedirectToPage("/index");
            var cust = await dBContext.Customers.Where(a => a.CustomerId == accId).FirstOrDefaultAsync();


            cust.CompanyName = Customer.CompanyName;
            cust.ContactName = Customer.ContactName;
            cust.ContactTitle = Customer.ContactTitle;
            cust.Address = Customer.Address;
            cust.Phone = Customer.Phone;

            ViewData["CompanyName"] = cust.CompanyName;
            ViewData["ContactTitle"] = cust.ContactTitle;
            ViewData["ContactName"] = cust.ContactName;
            ViewData["Address"] = cust.Address;
            ViewData["Phone"] = cust.Phone;
            if (await dBContext.SaveChangesAsync() > 0) ViewData["msg"] = "Cập nhật thông tin thành công!";
        }

        return Page();
    }
}