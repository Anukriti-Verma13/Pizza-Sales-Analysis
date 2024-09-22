# **Pizza Sales Analysis Project**

## Project Overview

Welcome to the **Pizza Sales Analysis Project**! This initiative focuses on extracting valuable insights from a pizza restaurant's sales data using **MySQL**. Our goal is to analyze various aspects of the business, including:

- **Total Orders and Revenue**: Evaluate the overall performance of the restaurant.
- **Popular and Unpopular Pizzas**: Identify customer favorites and less popular items.
- **Order Distribution**: Analyze when orders are placed to optimize staffing and operations.
- **Financial Contributions**: Calculate revenue contributions from different pizza types.
- **Customer Preferences**: Examine preferences for pizza sizes and categories.

By transforming raw data into actionable insights, we aim to enhance customer satisfaction and optimize overall operations.

## Dataset Overview

The project utilizes multiple related tables:

1. **Orders Table**: Contains `order_id`, `order_date`, `order_time`, and `customer_id`.
2. **Order Details Table**: Contains `order_details_id`, `order_id` (foreign key), `pizza_id` (foreign key), and `quantity`.
3. **Pizzas Table**: Contains `pizza_id`, `name`, `price`, `size`, and `pizza_type_id` (foreign key).
4. **Pizza Types Table**: Contains `pizza_type_id` and `category` (e.g., Vegetarian, Non-Vegetarian, Vegan).

## Key Metrics

The analysis focuses on several key metrics:

- **Total Number of Orders**: Count of all orders placed.
- **Total Revenue**: Sum of revenue generated from pizza sales.
- **Most Popular Pizzas and Sizes**: Identification of best-selling items.
- **Order Distribution by Hour**: Examination of order patterns throughout the day.
- **Revenue Contribution**: Breakdown of revenue by different pizza types and sizes.

## SQL Techniques Utilized

To achieve our analysis goals, we will leverage various **MySQL** techniques:

- **Aggregation Functions**: Utilize functions like `SUM()`, `COUNT()`, `AVG()`, `MAX()`, and `MIN()`.
- **Window Functions**: Apply `SUM() OVER()` and `RANK() OVER()` for advanced calculations.
- **Date and Time Functions**: Use `HOUR()` to analyze order timing.
- **Mathematical Functions**: Implement `ROUND()` for formatting results.
- **Joins and Subqueries**: Combine and filter data effectively.
- **Grouping and Filtering**: Utilize `GROUP BY` and `HAVING` for data segmentation.
- **Ordering and Limiting Results**: Apply `ORDER BY` and `LIMIT` to control output.

## Conclusion

This project serves as a comprehensive example of leveraging **MySQL** for business analysis, providing deep insights into the sales dynamics of a pizza restaurant. By utilizing SQL techniques, we can make informed decisions that enhance operational efficiency and customer satisfaction.
