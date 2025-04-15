WITH rn_cte AS (	
	SELECT
		cohort_year,
		customerkey,
		cleaned_name,
		orderdate,
		row_number() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
		first_purchase_date
	FROM cohort_analysis
), last_purchase_cte AS (
	SELECT
		cohort_year,
		customerkey,
		cleaned_name,
		first_purchase_date,
		orderdate AS last_purchase_date
	FROM rn_cte
	WHERE rn = 1
		AND first_purchase_date < (SELECT max(orderdate) FROM sales) - INTERVAL '6 months' -- defining churned customers AS customers who haven't purchased IN the LAST six months
),churned_analysis_cte AS (
	SELECT
		cohort_year,
		customerkey,
		cleaned_name,
		first_purchase_date,
		last_purchase_date,
		CASE	
			WHEN last_purchase_date < (SELECT max(orderdate) FROM sales) - INTERVAL '6 months' THEN 'Churned customer'
			ELSE 'Active customer'
		END AS customer_status
	FROM last_purchase_cte
)

SELECT
	cohort_year,
	customer_status,
	count(customerkey) AS num_customers,
	sum(count(customerkey)) over(PARTITION BY cohort_year) AS total_customers, -- finding total amount OF customers FOR EACH cohort YEAR.
	round(count(customerkey) * 100/sum(count(customerkey)) over(PARTITION BY cohort_year),2) AS customer_percentage
FROM churned_analysis_cte 
GROUP BY customer_status, cohort_year