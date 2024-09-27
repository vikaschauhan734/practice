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

-- Problem 8
SELECT Visits.customer_id, COUNT(Visits.visit_id) AS count_no_trans
FROM Visits
FULL OUTER JOIN Transactions
ON Visits.visit_id = Transactions.visit_id
WHERE transaction_id IS NULL
GROUP BY Visits.customer_id;

-- Problem 9
SELECT current_day.id
FROM Weather AS current_day
WHERE current_day.id IN (
    SELECT current_day.id
    FROM Weather AS pre_day
    WHERE current_day.temperature > pre_day.temperature AND current_day.recordDate = pre_day.recordDate + 1 );

-- Problem 10
SELECT a.machine_id, ROUND((SELECT AVG(a1.timestamp) FROM Activity a1 where a1.activity_type='end' and a1.machine_id = a.machine_id)-(SELECT AVG(a1.timestamp) FROM Activity a1 where a1.activity_type='start' and a1.machine_id = a.machine_id) ,3) AS processing_time
FROM Activity a
GROUP BY a.machine_id;

-- Problem 11
SELECT Employee.name, Bonus.bonus
FROM Employee
FULL OUTER Join Bonus
On Employee.empId = Bonus.empId
Where Bonus.bonus < 1000 OR Bonus.bonus IS NULL;
