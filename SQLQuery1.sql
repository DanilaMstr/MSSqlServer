SELECT 
	DATEADD(day, Nums.n - 1, '20060101') AS orderdate,
	O.orderid,
	O.custid,
	O.empid
FROM dbo.Nums
	LEFT JOIN Sales.Orders AS O
	ON O.orderdate = DATEADD(day, Nums.n - 1, '20060101')
WHERE n <= DATEDIFF(day, '20060101', '20081231') + 1
ORDER BY O.orderdate;