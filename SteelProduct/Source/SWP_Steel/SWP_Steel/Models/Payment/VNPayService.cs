using Microsoft.EntityFrameworkCore;
using static System.Net.WebRequestMethods;

namespace SWP_Steel.Models.Payment
{
    public class VNPayService : IVNPayService
    {
        private readonly IConfiguration _configuration;
        private readonly Swp391Context _context;
        public VNPayService(IConfiguration configuration, Swp391Context context)
        {
            _configuration = configuration;
            _context = context; 
        }
        public string CreatePaymentUrl(PaymentInfomationModel model, HttpContext context)
        {
            var newestOrder =  _context.Orders.OrderByDescending(p => p.OrderId).FirstOrDefault();
            int cId =(int) newestOrder.CustomerId;
            var customer= _context.Customers.Where(c=> c.CustomerId == cId).FirstOrDefault(); 
            model.Amount =(double) newestOrder.Freight;
            model.Name = customer.ContactName;
            model.OrderType = "Online";
            model.OrderDescription = newestOrder.ToString();
            var timeZoneById = TimeZoneInfo.FindSystemTimeZoneById(_configuration["TimeZoneId"]);
            var timeNow = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, timeZoneById);
            var tick = DateTime.Now.Ticks.ToString()+","+newestOrder.OrderId.ToString();
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

        public PaymentResponseModel PaymentExecute(IQueryCollection collections)
        {
            var pay = new VNPayLibrary();
            var response = pay.GetFullResponseData(collections, _configuration["Vnpay:HashSecret"]);

            return response;
        }
    }
}
