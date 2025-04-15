DROP VIEW cohort_analysis;
CREATE OR REPLACE VIEW cohort_analysis AS 
WITH customer_revenue AS (
	SELECT
		s.customerkey,
		s.orderdate,
		SUM(s.quantity*s.netprice*s.exchangerate) AS total_net_revenue,
		count(s.orderkey) AS num_of_orders,
		c.countryfull,
		c.age,
		c.givenname,
		c.surname
	FROM sales s
	LEFT JOIN customer c ON s.customerkey=c.customerkey
	GROUP BY 
		s.orderdate,
		s.customerkey,
		c.countryfull,
		c.age,
		c.givenname,
		c.surname
)

SELECT
	cr.*,
	min(cr.orderdate) over(PARTITION BY cr.customerkey) AS first_purchase_date,
	extract(YEAR FROM min(cr.orderdate) over(PARTITION BY cr.customerkey)) AS cohort_year
	
FROM customer_revenue cr