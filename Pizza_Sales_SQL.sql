---Basic:

-- Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id)
FROM
    pizzahut.orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM
    pizzahut.order_details
        JOIN
    pizzahut.pizzas ON pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    MAX(price)
FROM
    pizzahut.pizzas;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size, COUNT(order_details.order_details_id)
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size;


-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS most_sale_quantity
FROM
    pizzahut.pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY most_sale_quantity DESC
LIMIT 5;

Intermediate:

-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS qty_pizza_category
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category
ORDER BY qty_pizza_category DESC;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time), COUNT(order_id)
FROM
    pizzahut.orders
GROUP BY HOUR(order_time);


-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(qty), 0) AS avg_pizzas_perday
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS qty
    FROM
        pizzahut.orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_qty;
    

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3;

Advanced:

-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_sales
                FROM
                    pizzahut.order_details
                        JOIN
                    pizzahut.pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY revenue DESC
LIMIT 3;

-- Analyze the cumulative revenue generated over time.

select order_date,sum(revenue)over(order by order_date) as cum_revenue from 
(select orders.order_date,sum(order_details.quantity * pizzas.price) as revenue from order_details 
join pizzas on order_details.pizza_id = pizzas.pizza_id
join orders on orders.order_id = order_details.order_id
group by order_date) as sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category,name,revenue from
(select category,name,revenue,rank() over(partition by category order by revenue desc) as rn from 
(select pizza_types.category,pizza_types.name,sum( (order_details.quantity) *(pizzas.price)) as revenue from pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by category,name) as a ) as b
where rn <=3;

