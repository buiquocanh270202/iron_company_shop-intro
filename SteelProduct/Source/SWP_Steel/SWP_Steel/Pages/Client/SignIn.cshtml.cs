using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Client;

public class SignInModel : PageModel
{
    private readonly Swp391Context _Context;


    public SignInModel(Swp391Context context)
    {
        _Context = context;
    }

    [BindProperty] public Customer Customer { get; set; }

    public void OnGet()
    {
        HttpContext.Session.Remove("AccSession");
    }

    public async Task<IActionResult> OnPost()
    {
        if (!Customer.Password.IsNullOrEmpty())
        {
            var pass = EncryptPassWord("tunghe150190", Customer.Password!);
            var account = await _Context.Customers.SingleOrDefaultAsync(
            a => a.Email!.Equals(Customer.Email) && (a.Password!.Equals(Customer.Password) || a.Password.Equals(pass)));
            if (account != null)
            {
                HttpContext.Session.SetString("AccSession", JsonSerializer.Serialize(account));
                return RedirectToPage("/index");
                
            }

            ViewData["msg"] = "Wrong username or password. Please check again !";
        }else ViewData["msg"] = "Wrong username or password. Please check again !";
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

    public static string Decrypt(string key, string toDecrypt)
    {
        var useHashing = true;
        byte[] keyArray;
        var toEncryptArray = Convert.FromBase64String(toDecrypt);

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

        var cTransform = tdes.CreateDecryptor();
        var resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);

        return Encoding.UTF8.GetString(resultArray);
    }
}