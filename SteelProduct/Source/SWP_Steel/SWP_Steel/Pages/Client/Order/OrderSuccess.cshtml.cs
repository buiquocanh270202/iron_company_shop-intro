using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SelectPdf;
using SWP_Steel.Models;
using SWP_Steel.Models.Payment;
using System.Net.Mail;
using System.Text.Json;

namespace SWP_Steel.Pages.Client.Order
{
    public class OrderSuccessModel : PageModel
    {
        private readonly Swp391Context dBContext;
        private  IVNPayService _vnPayService;
        public OrderSuccessModel(Swp391Context dBContext, IVNPayService vnPayService)
        {
            this.dBContext = dBContext;
            this._vnPayService = vnPayService;
        }

        public async Task<IActionResult> OnGet(int orderId)
        {
            ViewData["orderId"] = orderId;
            return Page();
        }
        public async Task<IActionResult> OnGetSendEmail(int orderId)
        {
            try
            {
                string html = $"http://localhost:5192/client/order/printordertopdf?orderId={orderId}";
                HtmlToPdf htmlToPdf = new HtmlToPdf();
                PdfDocument pdfDocument = htmlToPdf.ConvertUrl(html);
                byte[] pdf = pdfDocument.Save();
                pdfDocument.Close();
                string filename = @"orderPdfFiles\order" + orderId + ".pdf";
                using (FileStream fs = System.IO.File.Create(filename))
                {
                    fs.Write(pdf, 0, pdf.Length);
                }

                var accSession = HttpContext.Session.GetString("AccSession");
                Models.Customer acc = JsonSerializer.Deserialize<Models.Customer>(accSession);

                string _from = "slenderman9196@gmail.com";
                string _pass = "yvyawqrtdstmdgzc";

                try
                {
                    MailMessage mail = new MailMessage();
                    SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

                    mail.From = new MailAddress(_from);
                    mail.To.Add(acc.Email);
                    mail.Subject = "Order Success";
                    mail.IsBodyHtml = true;
                    mail.Body = "Thank for your order";
                    System.Net.Mail.Attachment attachment;
                    attachment = new System.Net.Mail.Attachment(filename);
                    mail.Attachments.Add(attachment);


                    mail.Priority = MailPriority.High;

                    SmtpServer.Port = 587;
                    SmtpServer.Credentials = new System.Net.NetworkCredential(_from, _pass);
                    SmtpServer.EnableSsl = true;

                    SmtpServer.Send(mail);

                }
                catch (Exception ex)
                {
                    ex.Message.ToString();

                }



             
                return Page();
            }
            catch (Exception ex)
            {
                return RedirectToPage("/error", new { errormsg = ex.Message });
            }
        }
        public IActionResult OnPostCreatePaymentUrl(PaymentInfomationModel model)
        {
            var url = _vnPayService.CreatePaymentUrl(model, HttpContext);

            return Redirect(url);
        }

        public IActionResult PaymentCallback()
        {
            var response = _vnPayService.PaymentExecute(Request.Query);

            return RedirectToAction("/client/order/paymentsuccess");
        }
    }
}
