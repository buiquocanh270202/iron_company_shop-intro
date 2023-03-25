namespace SWP_Steel.Models.Payment
{
    public interface IVNPayService
    {
        string CreatePaymentUrl(PaymentInfomationModel model, HttpContext context);
        PaymentResponseModel PaymentExecute(IQueryCollection collections);
    }
}
