### Server Utilization Time [Link](https://datalemur.com/questions/total-utilization-time)

Amazon Web Services (AWS) is powered by fleets of servers. Senior management has requested data-driven solutions to optimize server usage. Write a query that calculates the total time that the fleet of servers was running. The output should be in units of full days.

Assumptions:
* Each server might start and stop several times.
* The total time in which the server fleet is running can be calculated as the sum of each server's uptime.

```sql
WITH cte AS(
SELECT 
  *,
  lead(status_time,1) OVER(PARTITION BY server_id ORDER BY status_time) as ld
FROM server_utilization)

SELECT
  sum(EXTRACT(DAY FROM ld) - EXTRACT(DAY FROM status_time)) as runtime
FROM cte 
WHERE session_status = 'start';
```

---

### 3-Topping Pizzas [Link](https://datalemur.com/questions/pizzas-topping-cost)
You’re a consultant for a major pizza chain that will be running a promotion where all 3-topping pizzas will be sold for a fixed price, and are trying to understand the costs involved.

Given a list of pizza toppings, consider all the possible 3-topping pizzas, and print out the total cost of those 3 toppings. Sort the results with the highest total cost on the top followed by pizza toppings in ascending order.

Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, followed by the second and third. P.S. Be careful with the spacing (or lack of) between each ingredient. Refer to our Example Output.

Notes:
* Do not display pizzas where a topping is repeated. For example, ‘Pepperoni,Pepperoni,Onion Pizza’.
* Ingredients must be listed in alphabetical order. For example, 'Chicken,Onions,Sausage'. 'Onion,Sausage,Chicken' is not acceptable.

![image](https://github.com/user-attachments/assets/d8457f74-34a5-4cd0-a4a0-586f2247965a)

```sql
SELECT 
  concat(p1.topping_name,',',p2.topping_name,',',p3.topping_name) AS pizz_name,
  p1.ingredient_cost+p2.ingredient_cost+p3.ingredient_cost AS pizz_cost
FROM pizza_toppings p1
CROSS JOIN pizza_toppings p2
CROSS JOIN pizza_toppings p3
WHERE 
  p1.topping_name < p2.topping_name AND 
  p2.topping_name < p3.topping_name
ORDER BY 2 DESC, 1;
```

---
