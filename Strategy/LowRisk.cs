using TradeCategory.Interface;

namespace TradeCategory.Strategy
{
    internal class LowRisk : ICategory
    {
        public string Name => "LOWRISK";

        public bool IsCategoryIdentified(ITrade trade)
        {
            return trade.Value < 1000000 && trade.ClientSector == "Public";
        }
    }
}
