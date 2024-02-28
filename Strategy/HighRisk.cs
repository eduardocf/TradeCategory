using TradeCategory.Interface;

namespace TradeCategory.Strategy
{
    internal class HighRisk : ICategory
    {
        public string Name => "HIGHRISK";

        public bool IsCategoryIdentified(ITrade trade)
        {
            return trade.Value >= 1000000 && trade.ClientSector == "Private";
        }
    }
}
