using Microsoft.EntityFrameworkCore;
using SWP_Steel.Models;
using SWP_Steel.Models.Payment;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages()
    .AddRazorPagesOptions(option=>
    option.Conventions.AddPageRoute("/index", "/home"));



builder.Services.AddDbContext<Swp391Context>(opt =>
{
    opt.UseSqlServer(builder.Configuration.GetConnectionString("swp391"));
});
builder.Services.AddScoped<IVNPayService,VNPayService>();
builder.Services.AddSession(opt => opt.IdleTimeout = TimeSpan.FromMinutes(10));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment()) app.UseExceptionHandler("/Error");


app.UseStaticFiles();

app.UseHttpsRedirection();

app.UseRouting();

app.UseAuthentication();

app.UseAuthorization();

app.UseSession();

app.MapRazorPages();

app.Run();