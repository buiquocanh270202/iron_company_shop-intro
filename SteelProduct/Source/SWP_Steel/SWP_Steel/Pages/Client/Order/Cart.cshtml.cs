using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SWP_Steel.Models;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

namespace SWP_Steel.Pages.Client.Order
{
    public class CartModel : PageModel
    {
        private readonly Swp391Context dBContext;
        public CartModel(Swp391Context dBContext)
        {
            this.dBContext = dBContext;

        }
        public List<Item> Products { get; set; }
        public int countOldOrders { get; set; }
        public int countNewOrders { get; set; }

        public double Total { get; set; }
        public string ValidateRequiredDate { get; set; }
        public string Message { get; set; }
        [BindProperty]
        public Customer Customer { get; set; }
        [BindProperty]
        public Models.Order Order { get; set; }
        public async void OnGet(int? id)
        {

            // user click buy now
            if (id != null)
            {
                // cart khong co gi
                if (HttpContext.Session.GetString("cart") == null)
                {
                    List<Item> products = new List<Item>();
                    var product = dBContext.Products.SingleOrDefault(p => p.ProductId == id);
                    Item pc = new Item();
                    pc.Product = product;
                    pc.Quantity = 1;
                    products.Add(pc);
                    Products = products;

                    HttpContext.Session.SetString("cart", JsonSerializer.Serialize(products));

                }
                // cart co product
                else
                {
                    String json = HttpContext.Session.GetString("cart");
                    List<Item> products = JsonSerializer.Deserialize<List<Item>>(json);
                    var k = 0;
                    foreach (var item in products)
                    {
                        if (item.Product.ProductId == id)
                        {
                            item.Quantity = item.Quantity + 1;
                            k++;
                            break;
                        }
                    }
                    if (k == 0)
                    {
                        var product = dBContext.Products.SingleOrDefault(p => p.ProductId == id);
                        Item pc = new Item();
                        pc.Product = product;
                        pc.Quantity = 1;
                        products.Add(pc);
                    }
                    Products = products;

                    HttpContext.Session.SetString("cart", JsonSerializer.Serialize(products));
                }
                int TotalProduct = 0;
                if (HttpContext.Session.GetString("cart") != null)
                {
                    List<Item>? Products = JsonSerializer.Deserialize<List<Item>>(HttpContext.Session.GetString("cart"));
                    TotalProduct = Products.Select(e => e.Product).Count();
                }
                HttpContext.Session.SetString("TotalProducts", JsonSerializer.Serialize(TotalProduct));

            }
            //user truc tiep vao cart
            else
            {
                if (HttpContext.Session.GetString("cart") == null)
                {
                    Products = new List<Item>();
                    Total = 0;
                }
                else
                {
                    String json = HttpContext.Session.GetString("cart");
                    Products = JsonSerializer.Deserialize<List<Item>>(json);
                    Total = Products.Sum(i => (double)i.Product.UnitPrice * i.Quantity);

                }
            }

        }

        public IActionResult OnGetBuyNow(int id)
        {
            if (HttpContext.Session.GetString("cart") == null)
            {
                List<Item> products = new List<Item>();
                var product = dBContext.Products.SingleOrDefault(p => p.ProductId == id);
                Item pc = new Item();
                pc.Product = product;
                pc.Quantity = 1;
                products.Add(pc);
                Products = products;

                HttpContext.Session.SetString("cart", JsonSerializer.Serialize(products));

            }
            // cart co product
            else
            {
                String json = HttpContext.Session.GetString("cart");
                List<Item> products = JsonSerializer.Deserialize<List<Item>>(json);
                var k = 0;
                foreach (var item in products)
                {
                    if (item.Product.ProductId == id)
                    {
                        item.Quantity = item.Quantity + 1;
                        k++;
                        break;
                    }
                }
                if (k == 0)
                {
                    var product = dBContext.Products.SingleOrDefault(p => p.ProductId == id);
                    Item pc = new Item();
                    pc.Product = product;
                    pc.Quantity = 1;
                    products.Add(pc);
                }
                Products = products;

                HttpContext.Session.SetString("cart", JsonSerializer.Serialize(products));
            }
            int TotalProduct = 0;
            if (HttpContext.Session.GetString("cart") != null)
            {
                List<Item>? Products = JsonSerializer.Deserialize<List<Item>>(HttpContext.Session.GetString("cart"));
                TotalProduct = Products.Select(e => e.Product).Count();
            }
            HttpContext.Session.SetString("TotalProducts", JsonSerializer.Serialize(TotalProduct));
            return RedirectToPage("/client/order/cart");
        }

        public async Task<IActionResult> OnPost()
        {
            
          
            string mess = "";
            string add = Request.Form["address"];
            var accSession = HttpContext.Session.GetString("AccSession");
            Models.Customer account = new Models.Customer();
            var CartSession = HttpContext.Session.GetString("cart");
            if (accSession != null)
            {
                account = JsonSerializer.Deserialize<Models.Customer>(accSession);
            }
            else
            {
                if (!ModelState.IsValid)
                {
                    if (CartSession == null)
                    {
                        Products = null;
                        Total = 0;
                    }
                    else
                    {
                        Products = JsonSerializer.Deserialize<List<Item>>(CartSession);
                        Total = Products.Sum(i => (double)i.Product.UnitPrice * i.Quantity);
                    }
                    if (Order.RequiredDate == null)
                    {
                        ValidateRequiredDate = "Ngày nhận hàng không được để trống!";
                    }
                    if (Order.RequiredDate < DateTime.Now)
                    {
                        ValidateRequiredDate = "Ngày nhận hàng phải sau ngày order";
                    }
                
                }
            }

            if (Order.RequiredDate == null || add.IsNullOrEmpty())
            {
                if (CartSession == null)
                {
                    Products = null;
                    Total = 0;
                }
                else
                {
                    Products = JsonSerializer.Deserialize<List<Item>>(CartSession);
                    Total = Products.Sum(i => (double)i.Product.UnitPrice * i.Quantity);
                }
                ValidateRequiredDate = "Không được để trống thông tin!";
                return Page();
            }

            if (Order.RequiredDate < DateTime.Now)
            {
                if (CartSession == null)
                {
                    Products = null;
                    Total = 0;
                }
                else
                {
                    Products = JsonSerializer.Deserialize<List<Item>>(CartSession);
                    Total = Products.Sum(i => (double)i.Product.UnitPrice * i.Quantity);
                }
                ValidateRequiredDate = "Ngày nhận hàng phải sau ngày order !";
                return Page();
            }

            if (CartSession != null)
            {
                Products = JsonSerializer.Deserialize<List<Item>>(HttpContext.Session.GetString("cart"));
                Total = Products.Sum(i => (double)i.Product.UnitPrice * i.Quantity);

            }
            else
            {
                return RedirectToPage("/client/order/cart");
            }

           
            //add new customer if not existed
            Customer newCustomer = null;
            if (accSession == null)
            {
                var c = await dBContext.Customers.Where(c => c.Email.Equals(Customer.Email)).CountAsync();
                if (c > 0)
                {
                    newCustomer = await dBContext.Customers.Where(c => c.Email.Equals(Customer.Email)).FirstOrDefaultAsync();
                }
                else
                {
                   
                    newCustomer = new Customer()
                    {

                        CompanyName = Customer.CompanyName,
                        ContactTitle = Customer.ContactTitle,
                        Address = add,
                        Email = Customer.Email,
                        ContactName = Customer.ContactName,
                        CreateDate = DateTime.Now,
                        Phone = Customer.Phone,
                        Password= ".",
                        Status = false
                    };
                    await dBContext.Customers.AddAsync(newCustomer);
                    await dBContext.SaveChangesAsync();
                }

                var newCus = dBContext.Customers.Where(c => c.Email.Equals(Customer.Email)).FirstOrDefault();
                HttpContext.Session.SetString("AccSession", JsonSerializer.Serialize(newCus));
                var order = new Models.Order
                {
                    CustomerId = newCus.CustomerId,
                    OrderDate = DateTime.Now,
                    ShipAddress=newCustomer.Address,
                    RequiredDate = Order.RequiredDate,
                    Freight = Total
                };

                await dBContext.Orders.AddAsync(order);
                await dBContext.SaveChangesAsync();
            }
            if (accSession != null)
            {
               
                account = JsonSerializer.Deserialize<Models.Customer>(accSession);
                var order = new Models.Order
                {
                    CustomerId = account.CustomerId,
                    OrderDate = DateTime.Now,
                    ShipAddress= add,
                    RequiredDate = Order.RequiredDate,
                    Freight = Total
                };
                await dBContext.Orders.AddAsync(order);
                await dBContext.SaveChangesAsync();
            }
            await dBContext.SaveChangesAsync();

            //add new order





            var newestOrder = await dBContext.Orders.OrderByDescending(p => p.OrderId).FirstOrDefaultAsync();
            foreach (var item in Products)
            {
                if (item.Product.UnitsInStock >= item.Quantity)
                {
                    var product = await dBContext.Products.Where(p => p.ProductId == item.Product.ProductId).FirstOrDefaultAsync();
                    product.UnitsInStock -= (short?)item.Quantity;
                    product.UnitsOnOrder++;
                    int checkExistedPro = await dBContext.OrderDetails.Where(od => od.ProductId == item.Product.ProductId).CountAsync();
                    if (checkExistedPro > 0)
                    {
                        product.ReorderLevel++;
                    }
                    var orderDetail = new OrderDetail
                    {
                        OrderId = newestOrder.OrderId,
                        ProductId = item.Product.ProductId,
                        UnitPrice = (decimal)item.Product.UnitPrice,
                        Quantity = (short)item.Quantity,
                        Discount = 0
                    };
                    await dBContext.OrderDetails.AddAsync(orderDetail);
                    Message = "Order thành công!";
                  
                }
                else
                {
                    Message = "Order thất bại! Không còn hàng trong kho";
                    dBContext.Orders.Remove(newestOrder);
                    if (newCustomer != null)
                    {
                        dBContext.Customers.Remove(newCustomer);
                    }
                    Message = "Order failed!";
                    return RedirectToPage("/client/order/cart");
                }
            }

            if (await dBContext.SaveChangesAsync() > 0)
            {


                HttpContext.Session.Remove("cart");
            }
            else
            {

                dBContext.Orders.Remove(newestOrder);
                if (newCustomer != null)
                {
                    dBContext.Customers.Remove(newCustomer);
                }
            }


          
               return RedirectToPage("/client/order/ordersuccess", "SendEmail", new { orderId = newestOrder.OrderId });
    
}
       

        public async Task<IActionResult> OnGetAdd(int id)
        {
            Products = JsonSerializer.Deserialize<List<Item>>(HttpContext.Session.GetString("cart"));
            int index = Exists(Products, id);
            if (index != -1)
            {
                if (Products[index].Quantity > 0)
                {
                    Products[index].Quantity++;
                }
            }
            HttpContext.Session.SetString("cart", JsonSerializer.Serialize(Products));
            return RedirectToPage("/client/order/cart"); ;
        }

        public async Task<IActionResult> OnGetMinus(int id)
        {
            Products = JsonSerializer.Deserialize<List<Item>>(HttpContext.Session.GetString("cart"));
            int index = Exists(Products, id);
            if (index != -1)
            {
                if (Products[index].Quantity > 1)
                {
                    Products[index].Quantity--;
                }
            }
            HttpContext.Session.SetString("cart", JsonSerializer.Serialize(Products));
            return RedirectToPage("/client/order/cart");
        }


        public IActionResult OnGetDelete(int id)
        {
            String cart_session = HttpContext.Session.GetString("cart");
            var cart = JsonSerializer.Deserialize<List<Item>>(cart_session);
            var index = Exists(cart, id);
            cart.RemoveAt(index);
            HttpContext.Session.SetString("cart", JsonSerializer.Serialize(cart));
            return RedirectToPage("/client/order/cart");
        }

        private int Exists(List<Item> cart, int id)
        {
            for (int i = 0; i < cart.Count; i++)
            {
                if (cart[i].Product.ProductId.Equals(id))
                {
                    return i;
                }
            }
            return -1;
        }
        public void Send(string sendto, string subject, string content)
        {
            string _from = "slenderman9196@gmail.com";
            string _pass = "yvyawqrtdstmdgzc";

            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

                mail.From = new MailAddress(_from);
                mail.To.Add(sendto);
                mail.Subject = subject;
                mail.IsBodyHtml = true;
                mail.Body = content;

                mail.Priority = MailPriority.High;

                SmtpServer.Port = 587;
                SmtpServer.Credentials = new System.Net.NetworkCredential(_from, _pass);
                SmtpServer.EnableSsl = true;

                SmtpServer.Send(mail);

            }
            catch (Exception ex)
            {


            }

        }
        public string CreateRandomPassword()
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
}
