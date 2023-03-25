using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SWP_Steel.Models.Payment;
using SWP_Steel.Models;
using SWP_Steel.Pages.Shared.Components.MessagePage;
using Microsoft.EntityFrameworkCore;

namespace SWP_Steel.Pages.Client.Order
{
    public class PaymentSuccessModel : PageModel
    {
        private readonly Swp391Context dBContext;
        private IVNPayService _vnPayService;
        public PaymentSuccessModel(Swp391Context dBContext, IVNPayService vnPayService)
        {
            this.dBContext = dBContext;
            this._vnPayService = vnPayService;
        }
        public ActionResult OnGet(string vnp_Amount,string vnp_BankCode,string vnp_BankTranNo,string vnp_CardType,
            string vnp_OrderInfo,string vnp_PayDate,string vnp_ResponseCode,string vnp_TmnCode,string vnp_TransactionNo,
            string vnp_TransactionStatus, string vnp_TxnRef, string vnp_SecureHash)
        {
            var response = _vnPayService.PaymentExecute(Request.Query);
            string[] words = response.OrderId.Split(",");
            string orderId = words[1];
            
            var pay = new VNPayLibrary();
          
                if (vnp_ResponseCode.Equals("00"))
                {
                int oId= int.Parse(words[1]);
                ViewData["oId"] = oId;
                var newestOrder = dBContext.Orders.Where(o=>o.OrderId== oId).FirstOrDefault();
                newestOrder.PaymentStatus = true;
                dBContext.SaveChanges();
               
                //Thanh toán thành công
                ViewData["msg"] = "Thanh toán thành công hóa đơn :" + orderId + " \n| Mã giao dịch: " + vnp_TransactionNo;
                }
                else
                {
                //Thanh toán không thành công. Mã lỗi: vnp_ResponseCode
                ViewData["msg"] = "Có lỗi xảy ra trong quá trình xử lý hóa đơn : " + orderId + "\n | Mã giao dịch: " + vnp_TransactionNo 
                    + " | Mã lỗi: " + vnp_ResponseCode;
                }
            
           
            return Page();
        }
    }
}
