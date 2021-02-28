-- ��� ������, � ������� � �������� ���� ������� urgent ��� �������� ���������� � Animal
SELECT Purchasing.PurchaseOrderLines.Description AS description
FROM Purchasing.PurchaseOrderLines
WHERE Purchasing.PurchaseOrderLines.Description LIKE 'Animal%' OR
		Purchasing.PurchaseOrderLines.Description LIKE '%urgent%'

--�����������, � ������� �� ���� ������� �� ������ ������
SELECT Sales.Customers.CustomerID AS [CustID without orders]
FROM Sales.Customers
WHERE Sales.Customers.CustomerID NOT IN 
	(SELECT DISTINCT Sales.CustomerTransactions.CustomerID
	 FROM Sales.CustomerTransactions)
ORDER BY [CustID without orders]

/*������� � ��������� ������, � ������� ���� �������, ������� ��������, � �������� ��������� �������, 
�������� ����� � ����� ����� ���� ��������� ���� - ������ ����� �� 4 ������, ���� ������ ������ ������ ���� ������, 
� ����� ������ ����� 100$ ���� ���������� ������ ������ ����� 20. �������� ������� ����� ������� � ������������ 
�������� ��������� ������ 1000 � ��������� ��������� 100 �������. ���������� ������ ���� �� ������ ��������, 
����� ����, ���� �������.
*/

/*
������ �����������, ������� ���� ��������� �� 2014� ��� � ��������� Road Freight ��� Post, 
�������� �������� ����������, ��� ����������� ���� ������������ �����
*/


--��� �� � ����� �������� � �� ���������� ��������, ������� �������� ����� Chocolate frogs 250g
SELECT TOP 10 
	Sales.CustomerTransactions.TransactionDate AS [last top 10 orders],
	Sales.Customers.CustomerName AS [Customer Name],
	Sales.Customers.CustomerID [Customer ID]
FROM Sales.CustomerTransactions JOIN Sales.Customers
	ON Sales.CustomerTransactions.CustomerID = Sales.Customers.CustomerID
ORDER BY [last top 10 orders] DESC