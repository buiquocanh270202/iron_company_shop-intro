using System.Security.Cryptography;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Client;

public class ChangePasswordModel : PageModel
{
    private readonly Swp391Context dBContext;

    public ChangePasswordModel(Swp391Context dBContext)
    {
        this.dBContext = dBContext;
    }

    [BindProperty] public Customer Customer { get; set; }

    public void OnGet()
    {
    }

    public async Task<IActionResult> OnPost(string email)
    {
        var acc = await dBContext.Customers.SingleOrDefaultAsync(a => a.Email.Equals(Customer.Email));
        string captcha = Request.Form["captcha"];
        string newPass = Request.Form["newPass"];
        string newPass2nd = Request.Form["newPass2nd"];
        if (!captcha.Equals(acc.Captcha))
        {
            ViewData["mess"] = "Captcha không đúng !";
            return Page();
        }
        if (!newPass.Equals(newPass2nd))
        {
            ViewData["mess"] = "Mật khẩu nhập lại không khớp !";
            return Page();
        }
        if (captcha.Equals(acc.Captcha) && newPass.Equals(newPass2nd))
        {
            acc.Password = EncryptPassWord("tunghe150190", newPass);
            await dBContext.SaveChangesAsync();

            ViewData["mess"] = "Reset mật khẩu thành công !";

            return Page();
        }

       
        return Page();
    }

    public static string EncryptPassWord(string key, string toEncrypt)
    {
        var useHashing = true;
        byte[] keyArray;
        var toEncryptArray = Encoding.UTF8.GetBytes(toEncrypt);

        if (useHashing)
        {
            var hashmd5 = new MD5CryptoServiceProvider();
            keyArray = hashmd5.ComputeHash(Encoding.UTF8.GetBytes(key));
        }
        else
        {
            keyArray = Encoding.UTF8.GetBytes(key);
        }

        var tdes = new TripleDESCryptoServiceProvider();
        tdes.Key = keyArray;
        tdes.Mode = CipherMode.ECB;
        tdes.Padding = PaddingMode.PKCS7;

        var cTransform = tdes.CreateEncryptor();
        var resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);

        return Convert.ToBase64String(resultArray, 0, resultArray.Length);
    }
}