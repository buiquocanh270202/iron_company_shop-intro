using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;
using SWP_Steel.Models.Payment;
using System.Text.Json;

namespace SWP_Steel.Pages.Client.Order
{
    public class OrderDetailModel : PageModel
    {
        private readonly Swp391Context dBContext;
        private IVNPayService _vnPayService;
        private readonly IConfiguration _configuration;
        public OrderDetailModel(Swp391Context dBContext, IVNPayService vnPayService, IConfiguration configuration)
        {
            this.dBContext = dBContext;
            this._vnPayService = vnPayService;
            _configuration = configuration;
        }
        [BindProperty]
        public Customer Customer { get; set; }
        
        public Models.Order Order { get; set; }
        [BindProperty]
        public Models.OrderDetail OrderDetail { get; set; }

        public async Task<IActionResult> OnGet(int oId)
        {

            var orderDetail = await dBContext.Orders.Where(o => o.OrderId == oId).FirstOrDefaultAsync();
            ViewData["Order"] = orderDetail;
            HttpContext.Session.SetString("oId", JsonSerializer.Serialize(oId));

            return Page();
        }
        public string CreatePaymentUrl(PaymentInfomationModel model, HttpContext context)
        {
            var oId = HttpContext.Session.GetString("oId");
            
            int orderId = Int32.Parse(oId);
            var orderPay = dBContext.Orders.Where(o => o.OrderId == orderId).FirstOrDefault();
            int cusId = (int)orderPay.CustomerId;
            var customer = dBContext.Customers.Where(c => c.CustomerId == cusId).FirstOrDefault();
            model.Amount = (double)orderPay.Freight;
            model.Name = customer.ContactName;
            model.OrderType = "Online";
            model.OrderDescription = orderPay.ToString();
            var timeZoneById = TimeZoneInfo.FindSystemTimeZoneById(_configuration["TimeZoneId"]);
            var timeNow = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, timeZoneById);
            var tick = DateTime.Now.Ticks.ToString() + "," + orderId.ToString();
            var pay = new VNPayLibrary();
            var urlCallBack = "http://localhost:5192/client/order/paymentsuccess";

            pay.AddRequestData("vnp_Version", _configuration["Vnpay:Version"]);
            pay.AddRequestData("vnp_Command", _configuration["Vnpay:Command"]);
            pay.AddRequestData("vnp_TmnCode", _configuration["Vnpay:TmnCode"]);
            pay.AddRequestData("vnp_Amount", ((int)model.Amount * 100).ToString());
            pay.AddRequestData("vnp_CreateDate", timeNow.ToString("yyyyMMddHHmmss"));
            pay.AddRequestData("vnp_CurrCode", _configuration["Vnpay:CurrCode"]);
            pay.AddRequestData("vnp_IpAddr", pay.GetIpAddress(context));
            pay.AddRequestData("vnp_Locale", _configuration["Vnpay:Locale"]);
            pay.AddRequestData("vnp_OrderInfo", $"{model.Name} {model.OrderDescription} {model.Amount}");
            pay.AddRequestData("vnp_OrderType", model.OrderType);
            pay.AddRequestData("vnp_ReturnUrl", urlCallBack);
            pay.AddRequestData("vnp_TxnRef", tick);

            var paymentUrl =
                pay.CreateRequestUrl(_configuration["Vnpay:BaseUrl"], _configuration["Vnpay:HashSecret"]);

            return paymentUrl;
        }
        public IActionResult OnPostCreatePaymentUrl(PaymentInfomationModel model)
        {
            var url = CreatePaymentUrl(model, HttpContext);

            return Redirect(url);
        }

        public IActionResult PaymentCallback()
        {
            var response = _vnPayService.PaymentExecute(Request.Query);
            if (response.Success)
            {
                var oId = HttpContext.Session.GetString("oId");

                int orderId = Int32.Parse(oId);
                var orderPay = dBContext.Orders.Where(o => o.OrderId == orderId).FirstOrDefault();
                orderPay.PaymentStatus = true;
                dBContext.SaveChanges();
            }
                return RedirectToAction("/client/order/paymentsuccess");
        }
    }
}
