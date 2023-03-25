using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;
using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json;

namespace SWP_Steel.Pages.Admin
{
	public class IndexModel : PageModel
	{
		private readonly Swp391Context dBContext;

		public double totalOrder = 0;
		public double totalCustomer = 0;
		public double totalWeeklySale = 0;
		public double totalGuess = 0;
		public double totalNewCustomer = 0;
		[BindProperty]
		public int TotalCustomer { get; set; }

		public double TotalOrders { get; set; }

		public int TotalGuest { get; set; }

		public double WeeklySales { get; set; }

		public int NewCustomer { get; set; }

		public List<int> Years { get; set; }

		public double janSaleFrieght { get; set; }
		public double febSaleFrieght { get; set; }
		public double marSaleFrieght { get; set; }
		public double aprSaleFrieght { get; set; }
		public double maySaleFrieght { get; set; }
		public double junSaleFrieght { get; set; }
		public double julySaleFrieght { get; set; }
		public double augSaleFrieght { get; set; }
		public double sepSaleFrieght { get; set; }
		public double octSaleFrieght { get; set; }
		public double novSaleFrieght { get; set; }
		public double decSaleFrieght { get; set; }
		public int CurYear { get; set; }
		public IndexModel(Swp391Context dBContext)
		{
			this.dBContext = dBContext;

		}
		[BindProperty]
		public Models.Order Order { get; set; }
		[BindProperty]
		public Models.OrderDetail OrderDetail { get; set; }

		[BindProperty]
		public List<Models.Category> Categories { get; set; }

		[BindProperty]
		public List<Models.Product> ProductList { get; set; }
				
		public async Task<IActionResult> OnGet(int? year)
		{


			String json = HttpContext.Session.GetString("AdminSession");
			if (json == null)
			{
				return Redirect("/admin/login");
			}

			var acc = JsonSerializer.Deserialize<Models.Employee>(json);
			
			var order = await dBContext.Orders.ToListAsync();
			foreach (var o in order)
			{
				totalOrder += (double)o.Freight;
			}
			var weeklySale = await dBContext.Orders.ToListAsync();
			foreach (var o in weeklySale)
			{
				TimeSpan ts = DateTime.Now - (DateTime)o.OrderDate;
				if (ts.Days < 7)
				{
					totalWeeklySale += (double)o.Freight;
				}


			}
			totalCustomer = await dBContext.Customers.CountAsync();
		/*	
			List<Models.Customer> newCus = new List<Models.Customer>();
			var allCus = await dBContext.Customers.ToListAsync();
			foreach (var o in allCus)
			{
				if (o.CreateDate != null)
				{
					TimeSpan ts = DateTime.Now - (DateTime)o.CreateDate;
					if (ts.Days < 30)
					{
						newCus.Add(o);
					}
				}
			}*/
		/*	totalNewCustomer = newCus.Count;*/
			ViewData["totalOrder"] = totalOrder;
			ViewData["totalWeeklySale"] = totalWeeklySale;
			ViewData["totalCustomer"] = totalCustomer;
			ViewData["totalNewCustomer"] = totalNewCustomer;



			janSaleFrieght = 0;
			febSaleFrieght = 0;
			marSaleFrieght = 0;
			aprSaleFrieght = 0;
			maySaleFrieght = 0;
			junSaleFrieght = 0;
			julySaleFrieght = 0;
			augSaleFrieght = 0;
			sepSaleFrieght = 0;
			octSaleFrieght = 0;
			novSaleFrieght = 0;
			decSaleFrieght = 0;

			if (year == null)
			{
				year = DateTime.Now.Year;
			}
			List<Models.Order> list = new List<Models.Order>();
			/*list = await dBContext.Orders.Include(o => o.OrderDetails).Where(o => o.ShippedDate <= DateTime.Now.AddDays(-7)).ToListAsync();*/
			list = await dBContext.Orders.Include(o => o.OrderDetails).Where(e => e.OrderDate.Value.Year == year).ToListAsync();
			foreach (var o in list)
			{
				if (o.OrderDate.Value.Month == 1)
				{
					
					janSaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 2)
				{
					
					febSaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 3)
				{
					
					marSaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 4)
				{
					
					aprSaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 5)
				{
					
					maySaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 6)
				{
					
					junSaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 7)
				{
					
					julySaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 8)
				{
					
					augSaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 9)
				{
					
					sepSaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 10)
				{
					
					octSaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 11)
				{
					
					novSaleFrieght += (double)o.Freight;
				}
				if (o.OrderDate.Value.Month == 12)
				{
					
					decSaleFrieght += (double)o.Freight;
				}
			}
			/*NewCustomer = dBContext.Customers.Where(i => i.CreateDate != null).Where(c => c.CreateDate <= DateTime.Now.AddDays(-30)).Count();*/
			Years = dBContext.Orders.Select(o => o.OrderDate.Value.Year).Distinct().ToList();
			CurYear = (int)year;

			var catergories = dBContext.Categories.ToList();

			ViewData["catergories"] = catergories;


			Categories = dBContext.Categories.ToList();
			ProductList = dBContext.Products.Include(d => d.OrderDetails).ToList();

			var listBest = (from od in dBContext.OrderDetails.ToList()
						group od by od.ProductId into g
						select new
						{
							ProductID = g.Key,
							NumberProduct = dBContext.OrderDetails.Where(o => o.ProductId == g.Key).ToList().Sum(i => i.Quantity)
						}).OrderByDescending(s => s.NumberProduct).ToList();
			
		
			List<Item> pro_qtt = new List<Item>();		
			foreach (var item in listBest)
			{
				Models.Product p = new Models.Product();
				Item i = new Item();
				p = dBContext.Products.First(e => e.ProductId == item.ProductID);
				i.Product = p;
				i.Quantity = item.NumberProduct;
				pro_qtt.Add(i);
				
			}						
			ViewData["TopProduct"]= pro_qtt;


			return Page();
		}
	}
}
