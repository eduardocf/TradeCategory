# TradeCategory

There are different approaches to Category Rules and even some combinations on rules availability.

For pattern demonstration I implemented a Strategy Pattern where each category rule implements an interface and is internally defined.
Other approaches include:

- Database, be it relational or NoSQL
- JSON document fed to the program
- Use the same implemented Strategy pattern combined with rules from a database delegating definition to an abstract class
- 