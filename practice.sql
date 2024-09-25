-- Problem 1 from leetcode
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';

-- Problem 2
SELECT name
FROM Customer
WHERE referee_id <> 2 or referee_id IS NULL;

-- Problem 3
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000;

--Problem 4
SELECT DISTINCT(author_id) AS id
FROM Views 
WHERE author_id = viewer_id
ORDER BY author_id;

-- Problem 5
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;

-- Problem 6
SELECT EmployeeUNI.unique_id, Employees.name
FROM EmployeeUNI
FULL OUTER JOIN Employees
ON EmployeeUNI.id = Employees.id;

-- Problem 7
SELECT Product.product_name, Sales.year, Sales.price
FROM Sales
JOIN Product
ON Sales.product_id = Product.product_id;