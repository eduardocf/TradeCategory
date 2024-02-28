using TradeCategory.Interface;

namespace TradeCategory
{
    internal class CategoryIdentifier(List<ICategory> categories)
    {
        private readonly List<ICategory> _categories = categories;

        public List<string> IdentifyCategory(List<ITrade> portfolio)
        {
            List<string> tradeCategories = [];

            foreach (var trade in portfolio)
            {
                bool isCategorized = false;
                foreach (var category in _categories)
                {
                    if (category.IsCategoryIdentified(trade))
                    {
                        tradeCategories.Add(category.Name);
                        isCategorized = true;
                        break;
                    }
                }

                if (!isCategorized)
                {
                    tradeCategories.Add("UNCATEGORIZED");
                }
            }

            return tradeCategories;
        }
    }
}
