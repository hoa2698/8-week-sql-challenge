-- Data cleaning
SELECT customer_id, order_id, pizza_id,
CASE
	WHEN exclusions = NULL or exclusions = '' or exclusions LIKE 'null' THEN null
    ELSE exclusions
    END AS exclusions,
CASE 
	WHEN extras = NULL or extras = '' or extras LIKE 'null' THEN null
    ELSE extras
    END AS extras
INTO customer_orders_updated
FROM pizza_runner.customer_orders;

SELECT order_id, runner_id,
CASE
	WHEN pickup_time = NULL or pickup_time = '' or pickup_time LIKE 'null' THEN null
    ELSE pickup_time
    END AS pickup_time,
CASE
	WHEN distance = NULL or distance = '' or distance LIKE 'null' THEN null
    WHEN distance LIKE '%km' THEN trim('km' from distance)
    ELSE distance
    END AS distance,
CASE
	WHEN duration = NULL or duration = '' or duration LIKE 'null' THEN null
    WHEN duration LIKE '%mins' THEN trim('mins' from duration)
    WHEN duration LIKE '%minute' THEN trim('minute' from duration)
    WHEN duration LIKE '%minutes' THEN trim('minutes' from duration)
    ELSE duration
    END AS duration,
CASE
	WHEN cancellation = NULL or cancellation = '' or cancellation LIKE 'null' THEN null
    ELSE cancellation
    END AS cancellation
INTO runner_orders_updated
FROM pizza_runner.runner_orders;
    
ALTER TABLE runner_orders_updated
ALTER COLUMN pickup_time TYPE TIMESTAMP WITH TIME ZONE USING TO_TIMESTAMP(pickup_time, 'YYYY-MM-DD HH24:MI:SS'),
ALTER COLUMN duration TYPE INTEGER USING (duration::INTEGER),
ALTER COLUMN distance TYPE FLOAT USING (distance::FLOAT);


-- Question 1
SELECT COUNT(customer_id)
FROM customer_orders_updated;
