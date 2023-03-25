using System.Net;
using System.Net.Mail;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;

namespace SWP_Steel.Pages.Client;

public class ForgotModel : PageModel
{
    private readonly Swp391Context dBContext;

    public ForgotModel(Swp391Context dBContext)
    {
        this.dBContext = dBContext;
    }

    [BindProperty] public Customer Customer { get; set; }

    public async Task<IActionResult> OnGet()
    {
        return Page();
    }

    public async Task<IActionResult> OnPost()
    {
        var mess = "";
        string email = Request.Form["email"];

        if (string.IsNullOrEmpty(email.Trim()))
        {
            mess = "Please input your email";
        }
        else
        {
            var captcha = CreateNewCaptcha();
            var account = await dBContext.Customers.Where(a => a.Email.Equals(email)).FirstOrDefaultAsync();
            if (account != null)
            {
                account.Captcha = captcha;
                if (await dBContext.SaveChangesAsync() > 0)
                    Send(email, "Change your password",
                        "Enter link to create new password: " + "http://localhost:5192/Client/ChangePassword?email=" +
                        email + " \n Your Captcha : " + captcha);
            }
            else
            {
                mess = "Email does not exist";
            }
        }

        ViewData["mess"] = mess;

        return RedirectToPage("/client/signin");
    }

    public void Send(string sendto, string subject, string content)
    {
        var _from = "slenderman9196@gmail.com";
        var _pass = "yvyawqrtdstmdgzc";

        try
        {
            var mail = new MailMessage();
            var SmtpServer = new SmtpClient("smtp.gmail.com");

            mail.From = new MailAddress(_from);
            mail.To.Add(sendto);
            mail.Subject = subject;
            mail.IsBodyHtml = true;
            mail.Body = content;


            mail.Priority = MailPriority.High;

            SmtpServer.Port = 587;
            SmtpServer.Credentials = new NetworkCredential(_from, _pass);
            SmtpServer.EnableSsl = true;

            SmtpServer.Send(mail);
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
        }
    }

    public string CreateNewCaptcha()
    {
        const string characterArray = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        var strCaptcha = new StringBuilder();
        var rand = new Random();
        for (var i = 0; i < 10; i++)
        {
            var str = characterArray[rand.Next(characterArray.Length)].ToString();
            strCaptcha.Append(str);
        }

        return strCaptcha.ToString();
    }
}