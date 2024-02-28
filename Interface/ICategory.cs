namespace TradeCategory.Interface
{
    interface ICategory
    {
        string Name { get; }
        bool IsCategoryIdentified(ITrade trade);
    }
}
