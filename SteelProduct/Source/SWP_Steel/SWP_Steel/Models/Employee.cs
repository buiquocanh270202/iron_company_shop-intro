using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace SWP_Steel.Models;

public partial class Employee
{
    public int EmployeeId { get; set; }

    public string? FullName { get; set; }

    public string? Title { get; set; }

    public string? TitleOfCourtesy { get; set; }
    [DataType(DataType.Date)]
    public DateTime? BirthDate { get; set; }

    public string? Address { get; set; }

    public bool? Gender { get; set; } = true;

    [DataType(DataType.PhoneNumber)]
    public string? Phone { get; set; }

    [Required, DataType(DataType.EmailAddress)]
    public string? Email { get; set; }

    public string? Password { get; set; } = "1234";

    public int? Role { get; set; } = 2;

    public string? Captcha { get; set; }

    public bool? Status { get; set; } = true;

    public virtual ICollection<News> News { get; } = new List<News>();

    public virtual ICollection<Order> Orders { get; } = new List<Order>();

}
