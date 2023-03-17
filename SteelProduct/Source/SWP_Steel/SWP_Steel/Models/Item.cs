﻿namespace SWP_Steel.Models
{
    public class Item
    {
        public Product Product { get; set; }
        public int Quantity { get; set; }
        public Item(Product product, int quantity)
        {
            Product = product;
            Quantity = quantity;
        }
        public Item()
        {
        }
    }
}
