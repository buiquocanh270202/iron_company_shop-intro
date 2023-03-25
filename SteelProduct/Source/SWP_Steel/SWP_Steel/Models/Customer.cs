using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace SWP_Steel.Models;

public partial class Customer
{
    public int CustomerId { get; set; }

    public string? CompanyName { get; set; }
    [Required(ErrorMessage = "Tên khách hàng không được để trống")]
    public string ContactName { get; set; } = null!;

    public string? ContactTitle { get; set; }
    [Required(ErrorMessage = "Địa chỉ không được để trống")]
    public string? Address { get; set; }

    public DateTime? CreateDate { get; set; }
    [Required(ErrorMessage = "Email không được để trống")]
    [DataType(DataType.EmailAddress)]
    [RegularExpression(@"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}", ErrorMessage = "Email phải đúng định dạng")]
    public string? Email { get; set; }
    [Required(ErrorMessage = "Password không được để trống")]
    [DataType(DataType.Password)]
    public string? Password { get; set; }

    public string? Captcha { get; set; }
    [Required(ErrorMessage = "Số điện thoại không được để trống")]
    [DataType(DataType.PhoneNumber)]
    [StringLength(11, MinimumLength = 10, ErrorMessage = "Bạn hãy nhập đủ số điện thoại")]
    public string? Phone { get; set; }

    public bool? Status { get; set; }

    public virtual ICollection<Order> Orders { get; } = new List<Order>();

}
