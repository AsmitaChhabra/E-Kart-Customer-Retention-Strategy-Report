-- 1. View complete customer table
SELECT * 
FROM `ekartdataset.customer_t`;

-- 2. Count total rows in customer table
SELECT COUNT(*) AS total 
FROM `ekartdataset.customer_t`;

-- 3. Count customers by occupation (sorted descending)
SELECT OCCUPATION, COUNT(*) AS count
FROM `ekartdataset.customer_t`
GROUP BY OCCUPATION
ORDER BY count DESC;

-- 4. View distinct occupation categories
SELECT DISTINCT OCCUPATION
FROM `ekartdataset.customer_t`;

-- 5. View sample records from sales table (first 20 rows)
SELECT * 
FROM `ekartdataset.sales_t`
LIMIT 20;

-- 6. Count total rows in sales table
SELECT COUNT(*) AS total 
FROM `ekartdataset.sales_t`;

-- 7. Join customer and sales tables to view key info
SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  c.occupation,
  s.revenue,
  s.total_orders
FROM `ekart-assignment.ekartdataset.customer_t` c
JOIN `ekart-assignment.ekartdataset.sales_t` s
ON c.customer_id = s.customer_id
LIMIT 10;

-- 8. Clean occupation field in joined data
SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  CASE 
    WHEN c.occupation = 'Blue Collar' THEN 'Blue-Collar'
    ELSE c.occupation
  END AS cleaned_occupation,
  s.revenue,
  s.total_orders
FROM `ekart-assignment.ekartdataset.customer_t` c
JOIN `ekart-assignment.ekartdataset.sales_t` s
ON c.customer_id = s.customer_id
LIMIT 10;

-- 9. Creating age categories based on DOB
SELECT
  c.customer_id,
  CASE
    WHEN DATE_DIFF(CURRENT_DATE(), c.DOB, YEAR) <= 19 THEN '19 or below'
    WHEN DATE_DIFF(CURRENT_DATE(), c.DOB, YEAR) BETWEEN 20 AND 29 THEN '20-29'
    WHEN DATE_DIFF(CURRENT_DATE(), c.DOB, YEAR) BETWEEN 30 AND 39 THEN '30-39'
    WHEN DATE_DIFF(CURRENT_DATE(), c.DOB, YEAR) BETWEEN 40 AND 49 THEN '40-49'
    ELSE '50 and above'
  END AS age_category
FROM `ekart-assignment.ekartdataset.customer_t` c
JOIN `ekart-assignment.ekartdataset.sales_t` s
ON c.customer_id = s.customer_id
LIMIT 10;

-- 10. Final cleaned dataset with demographic and behavioral insights
SELECT
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  c.email_id,
  CASE 
    WHEN c.occupation = 'Blue Collar' THEN 'Blue-Collar'
    ELSE c.occupation
  END AS cleaned_occupation,
  c.DOB,
  DATE_DIFF(CURRENT_DATE(), DATE(c.DOB), YEAR) AS age,
  CASE
    WHEN DATE_DIFF(CURRENT_DATE(), DATE(c.DOB), YEAR) <= 19 THEN '19 & below'
    WHEN DATE_DIFF(CURRENT_DATE(), DATE(c.DOB), YEAR) BETWEEN 20 AND 29 THEN '20-29'
    WHEN DATE_DIFF(CURRENT_DATE(), DATE(c.DOB), YEAR) BETWEEN 30 AND 39 THEN '30-39'
    WHEN DATE_DIFF(CURRENT_DATE(), DATE(c.DOB), YEAR) BETWEEN 40 AND 49 THEN '40-49'
    ELSE '50 and above'
  END AS age_category,
  s.total_orders,
  s.revenue,
  s.average_order_value,
  s.carriage_revenue,
  s.first_order_date,
  s.latest_order_date,
  s.averageshipping,
  s.avgdaysbetweenorders,
  s.dayssincelastorder,
  
  -- Daily orders and revenue
  s.monday_orders, s.tuesday_orders, s.wednesday_orders, s.thursday_orders,
  s.friday_orders, s.saturday_orders, s.sunday_orders,
  s.monday_revenue, s.tuesday_revenue, s.wednesday_revenue, s.thursday_revenue,
  s.friday_revenue, s.saturday_revenue, s.sunday_revenue,

  -- Weekly behavior
  s.week1_day01_day07_orders,
  s.week2_day08_day15_orders,
  s.week3_day16_day23_orders,
  s.week4_day24_day31_orders,
  s.week1_day01_day07_revenue,
  s.week2_day08_day15_revenue,
  s.week3_day16_day23_revenue,
  s.week4_day24_day31_revenue,

  -- Time-of-day ordering and revenue
  s.time_0000_0600_orders,
  s.time_0601_1200_orders,
  s.time_1200_1800_orders,
  s.time_1801_2359_orders,
  s.time_0000_0600_revenue,
  s.time_0601_1200_revenue,
  s.time_1200_1800_revenue,
  s.time_1801_2359_revenue

FROM `ekart-assignment.ekartdataset.customer_t` c
JOIN `ekart-assignment.ekartdataset.sales_t` s
ON c.customer_id = s.customer_id;
