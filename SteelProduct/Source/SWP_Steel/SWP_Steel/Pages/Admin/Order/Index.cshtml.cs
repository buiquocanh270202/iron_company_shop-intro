using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using OfficeOpenXml;
using SWP_Steel.Helpper;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin.Order
{
    public class IndexModel : PageModel
    {
        private readonly SWP_Steel.Models.Swp391Context _context;

        public IndexModel(SWP_Steel.Models.Swp391Context context)
        {
            _context = context;
        }

        public IList<Models.Order> Order { get;set; } = default!;

        public const int ITEM_PER_PAGE = 5;

        [BindProperty(SupportsGet = true, Name = "p")]
        public int currentPage { get; set; }
        public int countPage { get; set; }


        




        public async Task OnGetAsync(string? StartDate, string? EndDate)
        {


            ViewData["startDate"] = StartDate;
            ViewData["endDate"] = EndDate;


            


            var dataListFromDb = _context.Orders.Skip(0);

            List<Models.Order> listSearch = new List<Models.Order>();
            
            

            if (StartDate != null || EndDate != null)
            {
                if (StartDate == null && EndDate != null)
                {
                    listSearch = dataListFromDb.Where(x => x.OrderDate <= DateTime.Parse(EndDate)).OrderByDescending(p => p.OrderDate).ToList();


                }else if (EndDate == null && StartDate != null)
                {
                    listSearch = dataListFromDb.Where(x => x.OrderDate >= DateTime.Parse(StartDate)).OrderByDescending(p => p.OrderDate).ToList();

                }
                else
                {
                    listSearch = dataListFromDb.Where(x => x.OrderDate >= DateTime.Parse(StartDate) && x.OrderDate <= DateTime.Parse(EndDate)).OrderByDescending(p => p.OrderDate).ToList();
                }
                int totalNew = listSearch.Count();

                countPage = (int)Math.Ceiling((double)totalNew / ITEM_PER_PAGE);

                if (currentPage < 1)
                    currentPage = 1;
                if (currentPage > countPage)
                    currentPage = countPage;

                var pro = (from a in listSearch
                           orderby a.OrderDate descending
                           select a).Skip((currentPage - 1) * ITEM_PER_PAGE)
                     .Take(ITEM_PER_PAGE);
                Order = pro.ToList();

            }
            else
            {
                int totalNew = await _context.Orders.CountAsync();

                countPage = (int)Math.Ceiling((double)totalNew / ITEM_PER_PAGE);

                if (currentPage < 1)
                    currentPage = 1;
                if (currentPage > countPage)
                    currentPage = countPage;

                var pro = _context.Orders
                        .Include(o => o.Customer)
                    .Include(o => o.Employee).Skip((currentPage - 1) * ITEM_PER_PAGE)
                         .Take(ITEM_PER_PAGE);


                Order = await pro.ToListAsync();
            }



        }


        public async Task<IActionResult> OnGetExportOrder()
        {        
            try
            {
                var orders = await _context.Orders
                    .Select(o => new
                    {
                        OrderID = o.OrderId,
                        OrderDate = o.OrderDate.ToString(),
                        RequiredDate = o.RequiredDate.ToString(),
                        ShippedDate = o.ShippedDate.ToString(),
                        Employee = o.EmployeeId,
                        Customer = o.CustomerId,
                        Freight = o.Freight,
                        Status = (o.ShippedDate != null) == true ? "Giao hàng thành công" : (o.RequiredDate != null) == true ? "Đang xử lý..." : "Huỷ"
                    }).ToListAsync();             
               
                var stream = new MemoryStream();

                using (var package = new ExcelPackage(stream))
                {
                    var workSheet = package.Workbook.Worksheets.Add("OrderList");
                    workSheet.Cells.LoadFromCollection(orders, true);
                    package.Save();
                }
                stream.Position = 0;
                string excelName = $"OrderList-{DateTime.Now.ToString("yyyyMMddHHmmssfff")}.xlsx";

                //return File(stream, "application/octet-stream", excelName);  
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", excelName);
            }
            catch (Exception e)
            {
                return RedirectToPage("/Error", new { msg = e.Message });
            }
        }
    }
}
