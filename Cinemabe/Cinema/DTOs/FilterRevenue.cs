using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace Cinema.DTOs
{
    public class FilterRevenue
    {
        [JsonConverter(typeof(IsoDateTimeConverter))]
        public DateTime? StartDate { get; set; }
        [JsonConverter(typeof(IsoDateTimeConverter))]
        public DateTime? EndDate { get; set; }
    }

}
