using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SWP_Steel.Models;
using SWP_Steel.Pages.Shared.Components.MessagePage;

namespace SWP_Steel.Pages.Client;

public class SignUpModel : PageModel
{
    private readonly Swp391Context dBContext;

    public SignUpModel(Swp391Context dBContext)
    {
        this.dBContext = dBContext;
    }

    [BindProperty] public Customer Customer { get; set; }

    public void OnGet()
    {
    }

    public async Task<IActionResult> OnPost()
    {
        if (ModelState.IsValid)
        {
            string newPass2nd = "";
            if (!Request.Form["newPass2nd"].IsNullOrEmpty())
            {
                newPass2nd = Request.Form["newPass2nd"];
            }

            var acc = await dBContext.Customers.SingleOrDefaultAsync(a => a.Email.Equals(Customer.Email));
            if (acc != null)
            {
                ViewData["msg"] = "Email đã tồn tại !";
                return Page();
            }
            if (Customer.Password.IsNullOrEmpty())
            {
                ViewData["msg"] = "Password không được để trống";
                return Page();
            }
            if (!Customer.Password.Equals(newPass2nd) && Customer.Password != null)
            {
                ViewData["msg"] = "Mật khẩu nhập lại không khớp";
                
                return Page();
            }

            var cust = new Customer
            {
                CompanyName = Customer.CompanyName,
                ContactTitle = Customer.ContactTitle,
                Address = Customer.Address,
                ContactName = Customer.ContactName,
                Email = Customer.Email,
                Phone = Customer.Phone,
                Password = EncryptPassWord("tunghe150190", Customer.Password),
                CreateDate = DateTime.Now,
                Status = true
            };

            await dBContext.Customers.AddAsync(cust);

            await dBContext.SaveChangesAsync();
            HttpContext.Session.SetString("AccSession", JsonSerializer.Serialize(cust));
            return ViewComponent("MessagePage", new MessagePage.Message
            {
                title = "ĐĂNG KÝ THÀNH CÔNG",
                htmlcontent = "Bạn đã đăng ký tài khoản thành công !",
                secondwait = 5,
                urlredirect = "/index"
            });
            /*return RedirectToPage("index");*/
        }
        else
        {
            return Page();
        }
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