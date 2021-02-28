-- 1. All products in which the name is marked urgently or the name begins with Animal
SELECT Purchasing.PurchaseOrderLines.Description AS description
FROM Purchasing.PurchaseOrderLines
WHERE Purchasing.PurchaseOrderLines.Description LIKE 'Animal%' OR
		Purchasing.PurchaseOrderLines.Description LIKE '%urgent%'

--2. Suppliers who did not have a single order
SELECT Purchasing.Suppliers.SupplierID AS [Supplier ID without orders]
FROM Purchasing.Suppliers
WHERE Purchasing.Suppliers.SupplierID NOT IN 
	(SELECT DISTINCT Purchasing.SupplierTransactions.SupplierID
	 FROM Purchasing.SupplierTransactions)
ORDER BY [Supplier ID without orders]

/*3. Продажи с названием месяца, в котором была продажа, номером квартала, к которому относится продажа, 
включите также к какой трети года относится дата - каждая треть по 4 месяца, дата забора заказа должна быть задана, 
с ценой товара более 100$ либо количество единиц товара более 20. Добавьте вариант этого запроса с постраничной 
выборкой пропустив первую 1000 и отобразив следующие 100 записей. Соритровка должна быть по номеру квартала, 
трети года, дате продажи.
*/

/*
4. Заказы поставщикам, которые были исполнены за 2014й год с доставкой Road Freight или Post, 
добавьте название поставщика, имя контактного лица принимавшего заказ
*/


--5. 10 latest by date of sales with the name of the customer and the name of the salesperson who placed the order
WITH Top10OrdersByDateDesc (OrderID, CustomerID, SalespersonID)
AS
(
	SELECT TOP 10
		Sales.Orders.OrderID AS OrderID,
		Sales.Orders.CustomerID AS CustomerID,
		Sales.Orders.SalespersonPersonID AS SalespersonID
	FROM Sales.Orders
	ORDER BY Sales.Orders.OrderDate DESC)

SELECT
	CustomersTop10.CustomerName AS [Customer Name],
	SalespersonTop10.SalespersonName AS [Salesperson Name]
FROM 
	(SELECT
		Application.People.FullName AS SalespersonName,
		Top10OrdersByDateDesc.OrderID AS SalespersonOrderID
	FROM Application.People JOIN Top10OrdersByDateDesc
		ON Application.People.PersonID = Top10OrdersByDateDesc.SalespersonID
	) AS SalespersonTop10
	JOIN
	(SELECT
		Sales.Customers.CustomerName,
		Top10OrdersByDateDesc.OrderID AS CustomerOrderID
	FROM Sales.Customers JOIN Top10OrdersByDateDesc
		ON Sales.Customers.CustomerID = Top10OrdersByDateDesc.CustomerID
	) AS CustomersTop10
	ON SalespersonTop10.SalespersonOrderID = CustomersTop10.CustomerOrderID

--6. Все ид и имена клиентов и их контактные телефоны, которые покупали товар Chocolate frogs 250g