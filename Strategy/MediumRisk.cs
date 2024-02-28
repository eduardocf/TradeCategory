using TradeCategory.Interface;

namespace TradeCategory.Strategy
{
    internal class MediumRisk : ICategory
    {
        public string Name => "MEDIUMRISK";

        public bool IsCategoryIdentified(ITrade trade)
        {
            return trade.Value >= 1000000 && trade.ClientSector == "Public";
        }
    }
}
