namespace Cinema.DTOs
{
    public class UserRowViewModel
    {
        public Guid Id { get; set; }
        public string FullName { get; set; }
        public DateTime BirthDay { get; set; }
        public bool Gender { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string UserType { get; set; }
    }
}
