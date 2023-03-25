using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using OfficeOpenXml;
using SWP_Steel.Helpper;
using SWP_Steel.Models;
using System.Text.Json;

namespace SWP_Steel.Pages.Admin.Product
{
    public class IndexModel : PageModel
    {
        private readonly Swp391Context _context;
        public IFormFile FormFile { get; set; }

        public IndexModel(Swp391Context context)
        {
            _context = context;
        }

        public IList<Models.Product> Product { get; set; } = default!;



        public const int ITEM_PER_PAGE = 7;

        [BindProperty(SupportsGet = true, Name = "p")]
        public int currentPage { get; set; }
        public int countPage { get; set; }


        public async Task OnGetAsync(String? SearchString)
        {
            
            List<Models.Product> listSearch = new List<Models.Product>();
            if (!String.IsNullOrEmpty(SearchString))
            {

                ViewData["searchProduct"] = SearchString;
                foreach (var n in _context.Products.ToList())
                {

                    string title = Unsign.utf8Convert1(n.ProductName).ToLower();
                    string search = Unsign.utf8Convert1(SearchString).ToLower();
                    if (title.Contains(search))
                    {
                        listSearch.Add(n);
                    }
                    

                }

               int totalNew = listSearch.Count();
               countPage = (int)Math.Ceiling((double)totalNew / ITEM_PER_PAGE);
                if (currentPage < 1)
                    currentPage = 1;
                if (currentPage > countPage)
                    currentPage = countPage;
                var list = (from a in listSearch
                            orderby a.ProductName ascending
                            select a).Skip((currentPage - 1) * ITEM_PER_PAGE)
                     .Take(ITEM_PER_PAGE);
                Product = list.ToList();

            }
            else
            {

                int totalNew = await _context.Products.CountAsync();
                countPage = (int)Math.Ceiling((double)totalNew / ITEM_PER_PAGE);

                if (currentPage < 1)
                    currentPage = 1;
                if (currentPage > countPage)
                    currentPage = countPage;

                var pro = _context.Products
                        .Include(p => p.Category).Skip((currentPage - 1) * ITEM_PER_PAGE)
                         .Take(ITEM_PER_PAGE);
                Product = await pro.ToListAsync();
            }

        }







        public async Task<IActionResult> OnGetExportProduct()
        {
          
            try
            {
                var products = await _context.Products.Include(d => d.Category).Select(p => new
                {
                    ProductId = p.ProductId,
                    ProductName = p.ProductName,
                    CategoryId = p.CategoryId,
                    QuantityPerUnit = p.QuantityPerUnit,
                    UnitPrice = p.UnitPrice,
                    UnitsInStock = p.UnitsInStock,
                    UnitsOnOrder = p.UnitsOnOrder,
                    ReorderLevel = p.ReorderLevel,
                    Discontinued = p.Discontinued
                }).OrderByDescending(o => o.ProductId).ToListAsync();
              
                var stream = new MemoryStream();

                using (var package = new ExcelPackage(stream))
                {
                    var workSheet = package.Workbook.Worksheets.Add("ProductList");
                    workSheet.Cells.LoadFromCollection(products, true);
                    package.Save();
                }
                stream.Position = 0;
                string excelName = $"ProductList-{DateTime.Now.ToString("yyyyMMddHHmmssfff")}.xlsx";

                //return File(stream, "application/octet-stream", excelName);  
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", excelName);
            }
            catch (Exception e)
            {
                return RedirectToPage("/error", new { msg = e.Message });
            }
        }
        public async Task<IActionResult> OnPostImportExcel()
        {
            try
            {
               
                if (FormFile == null)
                {
                    return RedirectToPage("/admin/product/index", new { msg = "File is required" });
                }
                if (!FormFile.FileName.EndsWith(".xls") && !FormFile.FileName.EndsWith(".xlsx"))
                {
                    return RedirectToPage("/admin/product/index", new { msg = "Invalid file extension" });
                }
                if (FormFile.Length == 0)
                {
                    return RedirectToPage("/admin/product/index", new { msg = "File is empty" });
                }
                try
                {
                    using (var stream = new MemoryStream())
                    {
                        await FormFile.CopyToAsync(stream);
                        using (var package = new ExcelPackage(stream))
                        {
                            ExcelWorksheet worksheet = package.Workbook.Worksheets[0];
                            var rowcount = worksheet.Dimension.Rows;
                            using (var transaction = _context.Database.BeginTransaction())
                            {
                                await _context.Database.ExecuteSqlRawAsync("SET IDENTITY_INSERT [dbo].[Products] ON");
                                for (int i = 2; i <= rowcount; i++)
                                {
                                    int proId = Convert.ToInt32(worksheet.Cells[i, 1].Value.ToString().Trim());
                                    Models.Product checkExistProduct = await _context.Products.Where(p => p.ProductId == proId).FirstOrDefaultAsync();
                                    if (checkExistProduct == null)
                                    {
                                        Models.Product product = new Models.Product
                                        {
                                            ProductId = proId,
                                            ProductName = worksheet.Cells[i, 2].Value.ToString().Trim(),
                                            CategoryId = Convert.ToInt32(worksheet.Cells[i, 3].Value.ToString().Trim()),
                                            QuantityPerUnit = worksheet.Cells[i, 4].Value.ToString().Trim(),
                                            UnitPrice = Convert.ToDecimal(worksheet.Cells[i, 5].Value.ToString().Trim()),
                                            UnitsInStock = Convert.ToInt16(worksheet.Cells[i, 6].Value.ToString().Trim()),
                                            UnitsOnOrder = Convert.ToInt16(worksheet.Cells[i, 7].Value.ToString().Trim()),
                                            ReorderLevel = Convert.ToInt16(worksheet.Cells[i, 8].Value.ToString().Trim()),
                                            Discontinued = Convert.ToBoolean(worksheet.Cells[i, 9].Value.ToString().Trim())
                                        };
                                        await _context.AddAsync(product);
                                        //await dBContext.SaveChangesAsync();
                                    }
                                    if (checkExistProduct != null)
                                    {
                                        var product = checkExistProduct;
                                        product.ProductName = worksheet.Cells[i, 2].Value.ToString().Trim();
                                        product.CategoryId = Convert.ToInt32(worksheet.Cells[i, 3].Value.ToString().Trim());
                                        product.QuantityPerUnit = worksheet.Cells[i, 4].Value.ToString().Trim();
                                        product.UnitPrice = Convert.ToDecimal(worksheet.Cells[i, 5].Value.ToString().Trim());
                                        product.UnitsInStock = Convert.ToInt16(worksheet.Cells[i, 6].Value.ToString().Trim());
                                        product.UnitsOnOrder = Convert.ToInt16(worksheet.Cells[i, 7].Value.ToString().Trim());
                                        product.ReorderLevel = Convert.ToInt16(worksheet.Cells[i, 8].Value.ToString().Trim());
                                        product.Discontinued = Convert.ToBoolean(worksheet.Cells[i, 9].Value.ToString().Trim());
                                    }
                                }
                                await _context.SaveChangesAsync();
                                await _context.Database.ExecuteSqlRawAsync("SET IDENTITY_INSERT [dbo].[Products] OFF");
                                transaction.Commit();
                            }
                        }
                    }
                    return RedirectToPage("/admin/product/index");
                }
                catch (Exception ex)
                {
                    string msg = ex.Message;
                    return RedirectToPage("/admin/product/index", new { msg = msg });
                }
            }
            catch (Exception e)
            {
                return RedirectToPage("/404", new { msg = e.Message });
            }

            return RedirectToPage("/admin/product/index");
        }
    }
}