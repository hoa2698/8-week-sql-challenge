-- QUESTION 1
SELECT sales.customer_id, SUM(menu.price) AS total_amount_spent
FROM dannys_diner.menu as menu
INNER JOIN dannys_diner.sales
	ON sales.product_id = menu.product_id
GROUP BY sales.customer_id
ORDER BY sales.customer_id;


-- QUESTION 2
SELECT sales.customer_id, COUNT(DISTINCT sales.order_date) AS visited_days
FROM dannys_diner.sales
GROUP BY sales.customer_id
ORDER BY customer_id;

-- QUESTION 3
SELECT sales.customer_id, sales.order_date, menu.product_name
FROM dannys_diner.menu as menu
INNER JOIN dannys_diner.sales as sales
ON sales.product_id = menu.product_id
WHERE sales.order_date = (
  select min(sales_1.order_date)
  from dannys_diner.sales as sales_1
  WHERE sales.customer_id =sales_1.customer_id
);


-- QUESTION 4
SELECT menu.product_name, COUNT(sales.product_id) as times_purchased
FROM dannys_diner.menu as menu
INNER JOIN dannys_diner.sales as sales
ON menu.product_id = sales.product_id
GROUP BY menu.product_name
LIMIT 1;


-- QUESTION 5
WITH
	customer_order_counts
AS (
  SELECT sales.customer_id, menu.product_name, COUNT(menu.product_name) as order_count
  FROM dannys_diner.menu as menu
  INNER JOIN dannys_diner.sales as sales
  ON sales.product_id = menu.product_id
  GROUP BY menu.product_name, sales.customer_id
  ORDER BY order_count DESC
)
SELECT *
FROM customer_order_counts AS oc
WHERE oc.order_count = (
  SELECT max(oc_2.order_count)
  FROM customer_order_counts AS oc_2
  WHERE oc_2.customer_id = oc.customer_id
)
ORDER BY oc.customer_id;


-- QUESTION 6
WITH	
	member_sales
AS (
  SELECT members.join_date, sales.customer_id, sales.product_id, sales.order_date, DENSE_RANK() OVER(PARTITION BY sales.customer_id ORDER BY sales.order_date) Rank
  FROM dannys_diner.sales as sales
  JOIN dannys_diner.members as members
  ON members.customer_id = sales.customer_id
  WHERE sales.order_date >= members.join_date
)
SELECT member_sales.customer_id, menu.product_name, member_sales.order_date
FROM member_sales
JOIN dannys_diner.menu as menu
ON member_sales.product_id = menu.product_id
WHERE rank = 1
ORDER BY member_sales.customer_id;


-- QUESTION 7
WITH	
	member_sales
AS (
  SELECT members.join_date, sales.customer_id, sales.product_id, sales.order_date, DENSE_RANK() OVER(PARTITION BY sales.customer_id ORDER BY sales.order_date) Rank
  FROM dannys_diner.sales as sales
  JOIN dannys_diner.members as members
  ON members.customer_id = sales.customer_id
  WHERE sales.order_date <= members.join_date
)
SELECT member_sales.customer_id, menu.product_name, member_sales.order_date
FROM member_sales
JOIN dannys_diner.menu as menu
ON member_sales.product_id = menu.product_id
WHERE rank = 1
ORDER BY member_sales.customer_id;


-- QUESTION 8
SELECT sales.customer_id, COUNT(sales.product_id) as total_items, SUM(menu.price) as total_amount_spent
FROM dannys_diner.sales as sales
JOIN dannys_diner.menu as menu
	ON sales.product_id = menu.product_id
JOIN dannys_diner.members as members
	ON sales.customer_id = members.customer_id
WHERE sales.order_date < members.join_date
GROUP BY sales.customer_id
ORDER BY sales.customer_id;


-- QUESTION 9
WITH points_earned AS(
  SELECT *,
  CASE 
  	WHEN product_name = 'sushi' THEN price * 20
  	ELSE price * 10
  END AS points
  FROM dannys_diner.menu
)
SELECT sales.customer_id, SUM(points_earned.points) as total_points
FROM dannys_diner.sales as sales
LEFT JOIN points_earned
ON points_earned.product_id = sales.product_id
GROUP BY sales.customer_id
ORDER BY sales.customer_id;


-- QUESTION 10
WITH members_in_first_week
AS (
  SELECT sales.customer_id, sales.order_date, members.join_date, sales.product_id, menu.product_name, menu.price, 
  CASE
  	WHEN sales.order_date < members.join_date THEN 0
  	WHEN sales.order_date > members.join_date + INTERVAL '7 days' THEN 0
  	ELSE 1
  END AS in_first_week
  FROM dannys_diner.sales as sales
  INNER JOIN dannys_diner.menu as menu
  ON sales.product_id = menu.product_id
  INNER JOIN dannys_diner.members as members
  ON sales.customer_id = members.customer_id
  WHERE sales.order_date < '2021-02-01'
), member_points
AS (
  SELECT members_in_first_week.customer_id, members_in_first_week.product_id, members_in_first_week.order_date, members_in_first_week.price, members_in_first_week. in_first_week,
  CASE 
  	WHEN members_in_first_week.in_first_week = 1 then members_in_first_week.price * 20
  	WHEN members_in_first_week.product_id = 1 then members_in_first_week.price * 20
  	ELSE members_in_first_week.price * 10
  END AS points
  FROM members_in_first_week
)
SELECT member_points.customer_id, SUM(member_points.points) as points_earned
FROM member_points
GROUP BY member_points.customer_id
ORDER BY member_points.customer_id;


-- Bonus questions
-- QUESTION 11
SELECT sales.customer_id, sales.order_date, menu.product_name, menu.price,
CASE
	WHEN members.join_date > sales.order_date then 'N'
    WHEN members.join_date <= sales.order_date then 'Y'
    ELSE 'N'
END AS members_info
FROM dannys_diner.sales as sales
LEFT JOIN dannys_diner.menu as menu
ON sales.product_id = menu.product_id
LEFT JOIN dannys_diner.members as members
ON sales.customer_id = members.customer_id;


-- QUESTION 12
WITH customer_order_summary
AS (
	SELECT sales.customer_id, sales.order_date, menu.product_name, menu.price,
	CASE
		WHEN members.join_date > sales.order_date then 'N'
    	WHEN members.join_date <= sales.order_date then 'Y'
    	ELSE 'N'
	END AS members_info
	FROM dannys_diner.sales as sales
	LEFT JOIN dannys_diner.menu as menu
	ON sales.product_id = menu.product_id
	LEFT JOIN dannys_diner.members as members
	ON sales.customer_id = members.customer_id
)
SELECT *,
CASE 
	WHEN members_info = 'N' then NULL
    ELSE
    	RANK() OVER(PARTITION BY customer_order_summary.customer_id, customer_order_summary.members_info ORDER BY customer_order_summary.order_date)
END as ranking
FROM customer_order_summary;
