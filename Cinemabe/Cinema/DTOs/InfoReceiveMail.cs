namespace Cinema.DTOs
{
    public class InfoReceiveMail
    {
        public InfoReceiveMail()
        {
            Products = new List<InfoProduct>();
        }
        public string Email { get; set; }
        public string UserName { get; set; }
        public string TheaterName { get; set; }
        public string TheaterAddress { get; set; }
        public string Code { get; set; }
        public string MovieName { get; set; }
        public string ShowTime { get; set; }
        public string RoomName { get; set; }
        public List<InfoProduct> Products { get; set; }

        public string GetHTML()
        {
            return "";
        }
    }

    public class InfoProduct
    {
        public string Name { get; set; }
        public double Price { get; set; }
        public bool IsTicket { get; set; }
        public int? Quantity { get; set; }
    }

}