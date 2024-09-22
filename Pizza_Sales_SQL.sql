---Basic---:

-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) as total_orders_placed
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),2) AS Total_Revenue
FROM
    pizzas
        INNER JOIN
     order_details ON pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name AS Pizza, pizzas.price AS Max_priced
FROM
    pizzas
        JOIN 
    pizza_types ON pizzas.pizza_type_id=pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size, COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC 
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name AS Top_ordered_pizza,
    SUM(order_details.quantity) AS Quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Quantity DESC
LIMIT 5;

---Intermediate---:

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category AS Category,
    SUM(order_details.quantity) AS Quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(orders.order_time) AS Time, COUNT(orders.order_id) AS Quantity
FROM
    orders
GROUP BY Time
ORDER BY Time;

-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    pizza_types.category, COUNT(pizza_types.name) AS pizza_no
FROM
    pizza_types
GROUP BY pizza_types.category
ORDER BY pizza_no;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(Total_pizza_per_day),0) AS Avg_pizzas_ordered_per_day
FROM
    (SELECT 
        orders.order_date AS Date, SUM(order_details.quantity) AS Total_pizza_per_day
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS Sales;
    

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name AS Name_of_pizza,
    ROUND(SUM(order_details.quantity * pizzas.price),2) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue DESC
LIMIT 3;

---Advanced---:

-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.category AS Category_of_pizza,
    ROUND(((SUM(order_details.quantity * pizzas.price) / (SELECT 
                    SUM(order_details.quantity * pizzas.price)
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id)) * 100),
            2) AS percent_pizza
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY percent_pizza DESC
LIMIT 3;

-- Analyze the cumulative revenue generated over time.

select order_date as Date,Amount_per_day,sum(Amount_per_day) over(order by order_date) as Cumulative_Amount from 
(Select 
     orders.order_date,
     ROUND(SUM(order_details.quantity * pizzas.price),2) as Amount_per_day 
FROM 
    order_details 
          join 
    pizzas on order_details.pizza_id = pizzas.pizza_id
         join 
    orders on orders.order_id = order_details.order_id
    group by orders.order_date) as Sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category,name,rank_per_category from
(select category,name,revenue,rank() over(partition by category order by revenue desc) as rank_per_category from 
(Select 
     pizza_types.category,
     pizza_types.name,
     sum(order_details.quantity * pizzas.price) as revenue 
FROM 
    pizza_types
            join 
    pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
            join 
    order_details on order_details.pizza_id = pizzas.pizza_id
    group by pizza_types.category,pizza_types.name) as a ) as b
    where rank_per_category<=3;

