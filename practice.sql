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