-- Все товары, в которых в название есть пометка urgent или название начинается с Animal
SELECT Purchasing.PurchaseOrderLines.Description AS description
FROM Purchasing.PurchaseOrderLines
WHERE Purchasing.PurchaseOrderLines.Description LIKE 'Animal%' OR
		Purchasing.PurchaseOrderLines.Description LIKE '%urgent%'

--Поставщиков, у которых не было сделано ни одного заказа
SELECT Sales.Customers.CustomerID AS [CustID without orders]
FROM Sales.Customers
WHERE Sales.Customers.CustomerID NOT IN 
	(SELECT DISTINCT Sales.CustomerTransactions.CustomerID
	 FROM Sales.CustomerTransactions)
ORDER BY [CustID without orders]

/*Продажи с названием месяца, в котором была продажа, номером квартала, к которому относится продажа, 
включите также к какой трети года относится дата - каждая треть по 4 месяца, дата забора заказа должна быть задана, 
с ценой товара более 100$ либо количество единиц товара более 20. Добавьте вариант этого запроса с постраничной 
выборкой пропустив первую 1000 и отобразив следующие 100 записей. Соритровка должна быть по номеру квартала, 
трети года, дате продажи.
*/

/*
Заказы поставщикам, которые были исполнены за 2014й год с доставкой Road Freight или Post, 
добавьте название поставщика, имя контактного лица принимавшего заказ
*/


--Все ид и имена клиентов и их контактные телефоны, которые покупали товар Chocolate frogs 250g
SELECT TOP 10 
	Sales.CustomerTransactions.TransactionDate AS [last top 10 orders],
	Sales.Customers.CustomerName AS [Customer Name],
	Sales.Customers.CustomerID [Customer ID]
FROM Sales.CustomerTransactions JOIN Sales.Customers
	ON Sales.CustomerTransactions.CustomerID = Sales.Customers.CustomerID
ORDER BY [last top 10 orders] DESC