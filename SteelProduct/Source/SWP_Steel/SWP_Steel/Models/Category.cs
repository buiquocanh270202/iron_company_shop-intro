using System;
using System.Collections.Generic;

namespace SWP_Steel.Models;

public partial class Category
{
    public int CategoryId { get; set; }

    public string CategoryName { get; set; } = null!;

    public string? Description { get; set; }

    public bool? Status { get; set; }

    public virtual ICollection<Product> Products { get; } = new List<Product>();
}
