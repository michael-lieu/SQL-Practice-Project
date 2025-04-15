SELECT
	cohort_year,
	COUNT(DISTINCT customerkey) AS total_customers,
	sum(total_net_revenue) AS total_revenue,
	sum(total_net_revenue)/COUNT(DISTINCT customerkey) AS customer_revenue
FROM cohort_analysis
WHERE orderdate = first_purchase_date 
GROUP BY cohort_year
