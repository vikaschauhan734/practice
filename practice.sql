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

-- Problem 17
SELECT p.project_id, ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project p
JOIN Employee e
ON p.employee_id = e.employee_id
GROUP BY p.project_id;

-- Problem 18
SELECT contest_id, ROUND(COUNT(user_id)*100/(SELECT COUNT(*) AS total_users FROM Users), 2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;

-- Problem 19
SELECT query_name, ROUND(AVG(rating/position), 2) AS quality,
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;

-- Problem 20
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country, COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count, SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country;

-- Problem 21
WITH FirstOrders AS (SELECT customer_id, MIN(order_date) AS first_order_date FROM Delivery GROUP BY customer_id),
FirstOrdersDetails AS (SELECT D.delivery_id, D.customer_id, D.order_date, D.customer_pref_delivery_date,
           CASE 
               WHEN D.order_date = D.customer_pref_delivery_date THEN 1
               ELSE 0
           END AS is_immediate
    FROM Delivery D
    JOIN FirstOrders F
    ON D.customer_id = F.customer_id AND D.order_date = F.first_order_date
)
SELECT ROUND(100.0 * SUM(is_immediate) / COUNT(*), 2) AS immediate_percentage
FROM FirstOrdersDetails;

-- Problem 22
WITH FirstLogin AS (SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
),
NextDayLogin AS (SELECT a.player_id
    FROM Activity a
    JOIN FirstLogin f ON a.player_id = f.player_id
    WHERE a.event_date = DATE_ADD(f.first_login, INTERVAL 1 DAY)
)
SELECT ROUND(COUNT(DISTINCT n.player_id) / COUNT(DISTINCT f.player_id), 2) AS fraction
FROM FirstLogin f
LEFT JOIN NextDayLogin n ON f.player_id = n.player_id;


-- Problem 23
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;

-- Problem 24
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date
ORDER BY activity_date;

-- Problem 25
SELECT s.product_id, s.year AS first_year, s.quantity, s.price
FROM Sales s
JOIN (SELECT product_id, MIN(year) AS first_year
    FROM Sales GROUP BY product_id
) AS first_sales
ON s.product_id = first_sales.product_id AND s.year = first_sales.first_year;

-- Problem 26
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;

-- Problem 27
SELECT user_id, COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;

-- Problem 28
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);

-- Problem 29
SELECT e.employee_id, e.name, COUNT(r.employee_id) AS reports_count, ROUND(AVG(r.age), 0) AS average_age
FROM Employees e
JOIN Employees r 
ON e.employee_id = r.reports_to
GROUP BY e.employee_id, e.name
ORDER BY e.employee_id;

-- Problem 30
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y'
   OR employee_id IN (
       SELECT employee_id
       FROM Employee
       GROUP BY employee_id
       HAVING COUNT(*) = 1
   );

-- Problem 31
SELECT x, y, z,
       CASE 
           WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes'
           ELSE 'No'
       END AS triangle
FROM Triangle;

-- Problem 32
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT num,
           LAG(num) OVER (ORDER BY id) AS prev_num,
           LEAD(num) OVER (ORDER BY id) AS next_num
    FROM Logs
) subquery
WHERE num = prev_num AND num = next_num;

-- Problem 33
SELECT 
    product_id, 
    COALESCE((
        SELECT new_price 
        FROM Products p2 
        WHERE p1.product_id = p2.product_id 
        AND p2.change_date <= '2019-08-16' 
        ORDER BY p2.change_date DESC 
        LIMIT 1
    ), 10) AS price
FROM 
    (SELECT DISTINCT product_id FROM Products) p1;

-- Problem 34
WITH OrderedQueue AS (
    SELECT person_name, weight, turn, 
           SUM(weight) OVER (ORDER BY turn) AS cumulative_weight
    FROM Queue
)
SELECT person_name
FROM OrderedQueue
WHERE cumulative_weight <= 1000
ORDER BY turn DESC
LIMIT 1;

-- Problem 35
SELECT 'Low Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000
UNION ALL
SELECT 'Average Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income BETWEEN 20000 AND 50000
UNION ALL
SELECT 'High Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income > 50000;

-- Problem 36
SELECT e.employee_id
FROM Employees e
LEFT JOIN Employees m ON e.manager_id = m.employee_id
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND m.employee_id IS NULL
ORDER BY e.employee_id;

-- Problem 37
SELECT 
    CASE 
        WHEN id % 2 = 1 AND id + 1 <= (SELECT MAX(id) FROM Seat) THEN id + 1
        WHEN id % 2 = 0 THEN id - 1
        ELSE id
    END AS id, student
FROM Seat
ORDER BY id;

-- Problem 38
WITH UserMovieCount AS (
    SELECT u.name, COUNT(mr.movie_id) AS movie_count
    FROM Users u
    JOIN MovieRating mr ON u.user_id = mr.user_id
    GROUP BY u.name),
MovieAverageRating AS (
    SELECT m.title, AVG(mr.rating) AS avg_rating
    FROM Movies m
    JOIN MovieRating mr ON m.movie_id = mr.movie_id
    WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY m.title)

(SELECT name AS results
FROM UserMovieCount
WHERE movie_count = (SELECT MAX(movie_count) FROM UserMovieCount)
ORDER BY name
LIMIT 1)
UNION ALL
(SELECT title AS results
FROM MovieAverageRating
WHERE avg_rating = (SELECT MAX(avg_rating) FROM MovieAverageRating)
ORDER BY title
LIMIT 1);

-- Problem 39
WITH Customer_Totals AS (
  SELECT
    visited_on,
    SUM(amount) AS total_amount
  FROM
    Customer
  GROUP BY
    visited_on
)

SELECT
  c.visited_on,
  SUM(ct.total_amount) AS amount,
  ROUND(AVG(ct.total_amount), 2) AS average_amount
FROM
  Customer_Totals c
JOIN
  Customer_Totals ct ON ct.visited_on BETWEEN DATE_ADD(c.visited_on, INTERVAL -6 DAY) AND c.visited_on
GROUP BY
  c.visited_on
HAVING
  COUNT(*) = 7
ORDER BY
  c.visited_on ASC;

-- Problem 40
SELECT user_id,
CONCAT(UPPER(SUBSTRING(name, 1, 1)),LOWER(SUBSTRING(name, 2))) AS name
FROM Users
ORDER BY user_id;

-- Problem 41
SELECT *
FROM Patients
WHERE conditions LIKE '%DIAB1%';

-- Problem 42
SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id, accepter_id AS friend
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id, requester_id AS friend
    FROM RequestAccepted
) AS Friendships
GROUP BY id
ORDER BY num DESC
LIMIT 1;

-- Problem 43
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1)
AND (lat, lon) IN (SELECT lat, lon FROM Insurance GROUP BY lat, lon HAVING COUNT(*) = 1);

-- Problem 44
DELETE p1
FROM Person p1
JOIN Person p2
ON p1.email = p2.email
AND p1.id > p2.id;

-- Problem 45
WITH NumberCounts AS (
SELECT num, COUNT(num) OVER (PARTITION BY num) AS count_n
FROM MyNumbers  
)
SELECT MAX(num) as num
FROM NumberCounts
WHERE count_n = 1;

-- Problem 46
SELECT 
    (SELECT DISTINCT salary 
     FROM Employee 
     ORDER BY salary DESC 
     LIMIT 1 OFFSET 1) AS SecondHighestSalary;

-- Problem 47
WITH empdep AS (SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary, 
    DENSE_RANK() OVER (PARTITION BY d.name ORDER BY e.salary DESC) AS salary_rank
FROM Employee e
LEFT JOIN Department d
ON e.departmentId = d.id)
SELECT Department, Employee, Salary
FROM empdep
WHERE salary_rank <= 3;

-- Problem 48
SELECT sell_date, COUNT(DISTINCT(product)) AS num_sold,
GROUP_CONCAT(DISTINCT(product) ORDER BY product ASC) AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;

-- Problem 49
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

-- Problem 50
SELECT user_id, name, mail
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9._-]*@leetcode\\.com$';