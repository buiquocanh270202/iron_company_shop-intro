using System;
using System.Collections.Generic;

namespace SWP_Steel.Models;

public partial class News
{
    public int NewsId { get; set; }

    public int? EmployeeId { get; set; }

    public string? Title { get; set; }

    public string? SubContent { get; set; }

    public string? Image { get; set; }

    public string? Content { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? ModifyAt { get; set; }

    public bool Status { get; set; }

    public virtual Employee? Employee { get; set; }
}
