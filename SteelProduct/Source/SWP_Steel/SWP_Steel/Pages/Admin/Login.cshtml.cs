using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Admin;

public class LoginModel : PageModel
{
    private readonly Swp391Context _Context;


    public LoginModel(Swp391Context context)
    {
        _Context = context;
    }

    [BindProperty] public Models.Employee Employee { get; set; }

    public void OnGet()
    {
        HttpContext.Session.Remove("AdminSession");
		HttpContext.Session.Remove("AccSession");
	}

    public async Task<IActionResult> OnPost()
    {
        var pass = EncryptPassWord("tunghe150190", Employee.Password!);
        var account = await _Context.Employees.SingleOrDefaultAsync(
            a => a.Email!.Equals(Employee.Email) && (a.Password!.Equals(Employee.Password) || a.Password.Equals(pass)));
        if (account != null)
        {
            HttpContext.Session.SetString("AdminSession", JsonSerializer.Serialize(account));
            return RedirectToPage("/admin/index");
        }

        ViewData["msg"] = "This account does not exist";
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