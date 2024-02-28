using TradeCategory;
using TradeCategory.Interface;
using TradeCategory.Strategy;

var portfolio = new List<ITrade>
        {
            new Trade { Value = 2000000, ClientSector = "Private" },
            new Trade { Value = 400000, ClientSector = "Public" },
            new Trade { Value = 500000, ClientSector = "Public" },
            new Trade { Value = 3000000, ClientSector = "Public" },
            new Trade { Value = 15000000, ClientSector = "Government" },
            new Trade { Value = 500, ClientSector = "Private" }
        };

List<ICategory> categories =
        [
            new LowRisk(),
            new MediumRisk(),
            new HighRisk()
        ];

CategoryIdentifier categoryIdentifier = new(categories);
List<string> tradeCategories = categoryIdentifier.IdentifyCategory(portfolio);

Console.ForegroundColor=ConsoleColor.Blue;
Console.WriteLine("Categorized Trades:\n");
Console.ForegroundColor = ConsoleColor.White;

Console.WriteLine(string.Join(", ", tradeCategories));
//tradeCategories.ForEach(i => Console.Write("{0}, ", i));