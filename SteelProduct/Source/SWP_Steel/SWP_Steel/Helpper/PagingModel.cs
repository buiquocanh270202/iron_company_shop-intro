using Microsoft.AspNetCore.Mvc;

namespace SWP_Steel.Helpper
{
    public class PagingModel : Controller
    {
        public int currenPage { get; set; }
        public int countPage { get; set; }

        public Func<int?, string> generateURl { get; set; }
    }
}
