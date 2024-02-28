using TradeCategory.Interface;

namespace TradeCategory
{
    internal class Trade : ITrade
    {
        public double Value { get; set; }
        public required string ClientSector { get; set; }
    }
}
