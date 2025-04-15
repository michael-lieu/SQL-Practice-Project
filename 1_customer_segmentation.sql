WITH customer_ltv AS(	
	SELECT
		customerkey,
		cleaned_name,
		SUM(total_net_revenue) AS total_LTV
	FROM cohort_analysis
	GROUP BY 
		customerkey,
		cleaned_name
), percentile_cte AS(

SELECT 
	percentile_cont(0.25) WITHIN GROUP(ORDER BY total_ltv) AS ltv_25th_pct,
	percentile_cont(0.75) WITHIN GROUP(ORDER BY total_ltv) AS ltv_75th_pct
	
FROM customer_ltv 
), tier_cte AS(
	SELECT 
		c.*,
		CASE
			WHEN c.total_ltv <= p.ltv_25th_pct THEN '1 - Low tier customer'
			WHEN c.total_ltv >= p.ltv_25th_pct AND c.total_ltv <= p.ltv_75th_pct THEN '2 - Middle tier customer'
			ELSE '3 - High tier customer'
		END AS customer_segment
	FROM
		customer_ltv AS c,
		percentile_cte AS p
)

SELECT
	customer_segment,
	sum(total_ltv) AS total_ltv,
	sum(total_ltv) * 100/(SELECT sum(total_ltv) FROM tier_cte) AS percentage_of_ltv,
	count(DISTINCT customerkey) AS customer_count,
	sum(total_ltv)/count(DISTINCT customerkey) AS average_ltv_per_customer	
FROM tier_cte
GROUP BY customer_segment