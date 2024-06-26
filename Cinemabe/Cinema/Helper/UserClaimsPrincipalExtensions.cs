using Cinema.Contracts;
using System.Security.Claims;

namespace Cinema.Helper
{
    public static class UserClaimsPrincipalExtensions
    {
        public static Guid? GetUserId(this ClaimsPrincipal principal)
        {
            if (principal == null)
                throw new ArgumentNullException(nameof(principal));
            if (!principal.IsInRole("user"))
                return null;

            var nameIdentifier = principal.FindFirstValue(ClaimTypes.NameIdentifier);

            if (Guid.TryParse(nameIdentifier, out Guid tokenUserId))
            {
                return tokenUserId;
            }
            else
            {
                throw new Exception("NameIdentifier claim not found or has an invalid format");
            }
        }
    }
}
