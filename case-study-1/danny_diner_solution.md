# **SQL Challenge Week 1: Danny's Diner 🍜**

## Welcome to SQL Challenge Week 1: Danny's Diner! 
- I'm excited to introduce the SQL Challenged brought to you by [Data with Danny] (https://www.datawithdanny.com/), and I kicked off this challenge with study case #1: [Danny's Diner] (https://8weeksqlchallenge.com/case-study-1/).

## Challenge Overview
- Danny's Diner is a fictional data analysis challenge that involves working with a dataset from a restaurant named "Danny's Diner." The challenge typically provides participants with a database containing various tables, such as customer data, menu items, reservations, and transaction history. 

## Problem Statement
- My task in this challenge is to dive in and uncover some seriously delectable insights. There are three main questions to tackle:

- 1. **Popular Dishes**: Determining which menu items are the most frequently ordered by customers.
- 2. **Peak Dining Hours**: Exploring when the restaurant experiences peak hours of customer activity, helping to optimize staffing and service.
- 3. **Reservation Patterns**: Investigating how far in advance customers typically make reservations, which can inform reservation management.

## Case Study Questions
**1. What is the total amount each customer spent at the restaurant?**
| customer_id | total_spent |
| ----------- | ----------- |
| A           | 76          |
| B           | 74          |
| C           | 36          |

- Customer A spent 76$ at the restaurant.
- Customer B spent 74$ at the restaurant.
- Customer C spent 36$ at the restaurant.

**2. How many days has each customer visited the restaurant?**
| customer_id | days_visited |
| ----------- | ------------ |
| A           | 4            |
| B           | 6            |
| C           | 2            |

- Customer A has visited the restaurant for 4 days.
- Customer B has visited the restaurant for 6 days.
- Customer C has visited the restaurant for 2 days.

**3. What was the first item from the menu purchased by each customer?**
| customer_id | product_name |
|-------------|--------------|
| A           | sushi        |
| B           | curry        |
| C           | ramen        |

- Sushi was the first item purchased by customer A.
- Curry was the first item purchased by customer B.
- Ramen was the first item purchased by customer C.
  
**4. What is the most purchased item on the menu and how many times was it purchased by all customers?**
| product_name | time_purchased |
|--------------|----------------|
| ramen        | 8              |

- Ramen is the most purchased item on the menu, and it was purchased 8 times by all customers.

**5. Which item was the most popular for each customer?**
| customer_id | product_name | count |
| ----------- | -------------|-------|
| A           | ramen        |  3    |
| B           | sushi        |  2    |
| B           | curry        |  2    |
| B           | ramen        |  2    |
| C           | ramen        |  3    |

- Ramen was enjoyed the most by customers A and C, while customer B enjoyed every food on the menu.

**6. Which item was purchased first by the customer after they became a member?**
| customer_id | product_name  | 
| ----------- | --------------|
| A           |  curry        | 
| B           |  sushi        | 

- Customer A purchased curry first after they became a member.
- Customer B purchased sushi first after they became a member.

**7. Which item was purchased just before the customer became a member?**
| customer_id | product_name  |
| ----------- | --------------|
| A           |  sushi        | 
| A           |  curry        | 
| B           |  curry        | 

- Customer A purchased sushi and curry before the customer became a member.
- Customer B purchased curry before the customer became a member.

**8. What is the total items and amount spent for each member before they became a member?**
| customer_id | total_items | total_amount_spent |
|-------------|-------------|--------------------|
| A           | 2           | 25                 |
| B           | 3           | 40                 |

- Customer A spent 25$ in total on 2 items before they became a member.
- Customer B spent 40$ in total on 3 items before they became a member.

**9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?**
| customer_id | total_points |
|-------------|--------------|
| A           | 860          |
| B           | 940          |
| C           | 360          |

- Customer A would have 860 points.
- Customer B would have 940 points.
- Customer C would have 360 points.
  
**10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?**
| customer_id | total_points |
|-------------|--------------|
| A           | 1370         |
| B           | 940          |

- Customer A has 1370 points while customer B has 940 points at the end of January.

## Bonus questions
**11. Join all the things**
| customer_id | product_name | price | members_info|
| ----------- | -------------|-------| ------------|
| A           | curry        |  15   | Y           |
| A           | ramen        |  12   | Y           |
| A           | ramen        |  12   | Y           |
| A           | ramen        |  12   | Y           |
| A           | sushi        |  10   | N           |
| A           | curry        |  15   | N           |
| B           | sushi        |  10   | N           |
| B           | sushi        |  10   | Y           |
| B           | curry        |  15   | N           |
| B           | curry        |  15   | N           |
| B           | ramen        |  12   | Y           |
| B           | ramen        |  12   | Y           |
| C           | ramen        |  12   | N           |
| C           | ramen        |  12   | N           |
| C           | ramen        |  12   | N           |

**12. Rank all the things**
- Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.

| customer_id | product_name | price | members_info| ranking|
| ----------- | -------------|-------| ------------| -------|
| A           | sushi        |  10   | N           | null   |
| A           | curry        |  15   | N           | null   |
| A           | curry        |  15   | Y           | 1      |
| A           | ramen        |  12   | Y           | 2      |
| A           | ramen        |  12   | Y           | 3      |
| A           | ramen        |  12   | Y           | 3      |
| B           | curry        |  15   | N           | null   |
| B           | curry        |  15   | N           | null   |
| B           | sushi        |  10   | N           | null   |
| B           | sushi        |  10   | Y           | 1      |
| B           | ramen        |  12   | Y           | 2      |
| B           | ramen        |  12   | N           | 3      |
| C           | ramen        |  12   | N           | null   |
| C           | ramen        |  12   | N           | null   |
| C           | ramen        |  12   | N           | null   |
