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

-- Problem 12
SELECT s.student_id, s.student_name, sub.subject_name, COALESCE(COUNT(e.student_id), 0) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;

-- Problem 13
SELECT e.name 
FROM Employee AS e
RIGHT JOIN (SELECT managerId
FROM (SELECT managerId, count(managerId) AS ct
FROM Employee
GROUP BY managerId) AS subquery
WHERE ct >= 5) AS d
ON e.id = d.managerId;

-- Problem 14
SELECT s.user_id,
       IFNULL(ROUND(SUM(c.action = 'confirmed') / COUNT(c.user_id), 2), 0.00) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
ON s.user_id = c.user_id
GROUP BY s.user_id;

-- Problem 15
SELECT *
FROM Cinema
WHERE id % 2 <> 0 AND NOT description LIKE '%boring%'
ORDER BY rating DESC

-- Problem 16
SELECT p.product_id, IFNULL(ROUND(SUM(p.price*u.units)/SUM(u.units),2),0) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
ON p.product_id = u.product_id AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;