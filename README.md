# SQL - Sales Analysis

## Overview
Analysis of customer behavior, retention, and lifetime value for an e-commerce company to improve customer retention and maximize revenue.

## Entity Relationship Diagram

![ERD](/images/contoso_ERD.png)


## Cohort_analysis view
As part of the project, a view was created in DBeaver in order to be able to reference aggregated columns easily without needing to write out the code for them repeatedly.

See the SQL code in the following link for the creation of this view: [view builder script](/view%20builder%20script.sql)

## Business Questions
1. **Customer segmentation:** Who are our most valuable customers?
2. **Cohort analysis:** How do different customer groups generate revenue?
3. **Customer retention:** Which customers have not repurchased a product recently?



## Analysis approach


### Question 1.
- Categorised customers based on their total lifetime value (LTV)
- Assigned customers to High, Mid, and Low-value tier segments
- Calculated key metrics: total revenue

Query: [Customer segmentation](/1_cohort_analysis.sql)

**Visualisation**
![Customer segmentation analysis](/images/1_customer_segementation.png)


**Key findings**
- High-value segment (25% of customers) drives 66% of revenue ($135.4M)
- Mid-value segment (50% of customers) generates 32% of revenue ($66.6M)
- Low-value segment (25% of customers) accounts for 2% of revenue ($4.3M)

**Business insights**
- High-Value: Losing one customer in the high value tier will impact revenue more significantly than the other two tiers, efforts should be emphasised to retain these customers.
- Mid-Value: Create upgrade paths through personalised promotions and also put efforts in to retaining the business of these customers.
- Low-Value: Design re-engagement campaigns and price-sensitive promotions to increase purchase frequency

### Question 2: Cohort analysis
- Tracked revenue and customer count per cohort
- Cohorts were grouped by year of first purchase
- Analysed customer retention at a cohort level

Query: [Cohort analysis](/2_cohort_analysis.sql)


**Visualisation**
![Cohort Analysis](/images/2_cohort_analysis.png)

**Key findings**
- Revenue per customer shows an alarming decreasing trend over time.
- 2022-2024 cohorts are consistently performing worse than earlier cohorts.
- Although net revenue is increasing, this is likely due to a larger customer base which is not indicative of customer value.

**Business insights**
- Value from each customer is decreasing over time and should undergo further investigation as to why this is happening.
- In 2023 there was a drop in customer acquisition which is concerning and we should look to find ways to increase this in the future.


### Question 3.
- Identified customers at risk of churning
- Analysed last purchase patterns
- Calculated customer specific metrics

Query: [Customer retention](/3_customer_retention.sql)

**Visualisation**
![Customer retention analysis](/images/3_customer_churn_cohort_year.png)


**Key findings**
- Cohort churn stabilizes at ~90% after 2-3 years, indicating a predictable long-term retention pattern.  
- Retention rates are consistently low (8-10%) across all cohorts, suggesting retention issues are systemic rather than specific to certain years.  
- Newer cohorts (2022-2023) show similar churn trajectories, signaling that without intervention, future cohorts will follow the same pattern.  

**Business insights**
- Strengthen early engagement strategies to target the first 1-2 years with onboarding incentives, loyalty rewards, and personalized offers to improve long-term retention.  
- Re-engage high-value churned customers by focusing on targeted win-back campaigns rather than broad retention efforts, as reactivating valuable users may yield higher ROI.  
- Predict & preempt churn risk and use customer-specific warning indicators to proactively intervene with at-risk users before they lapse.

## Strategic reccomendations 

1. **Customer Value Optimization** (Customer Segmentation)
   - Launch VIP program for 12,372 high-value customers (66% revenue)
   - Create personalized upgrade paths for mid-value segment ($66.6M → $135.4M opportunity)
   - Design price-sensitive promotions for low-value segment to increase purchase frequency

2. **Cohort Performance Strategy** (Customer Revenue by Cohort)
   - Target 2022-2024 cohorts with personalized re-engagement offers
   - Implement loyalty/subscription programs to stabilize revenue fluctuations
   - Apply successful strategies from high-spending 2016-2018 cohorts to newer customers

3. **Retention & Churn Prevention** (Customer Retention)
   - Strengthen first 1-2 year engagement with onboarding incentives and loyalty rewards
   - Focus on targeted win-back campaigns for high-value churned customers
   - Implement proactive intervention system for at-risk customers before they lapse

## Technical details

- **Database:** PostgreSQL
- **Analysis tools:** PostgreSQL
- **Visualisation tool** ChatGPT

