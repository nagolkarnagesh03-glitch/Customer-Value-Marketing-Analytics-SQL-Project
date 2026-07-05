-- CREATE DATABASE marketing_db;
USE marketing_db;


SELECT * FROM customers ;

-- CHANGE COLUMNS NAEM-- 

ALTER TABLE customers RENAME COLUMN `Customer` TO customer_id;
ALTER TABLE customers RENAME COLUMN `State` TO state;
ALTER TABLE customers RENAME COLUMN `Customer Lifetime Value` TO clv;
ALTER TABLE customers RENAME COLUMN `Response` TO response;
ALTER TABLE customers RENAME COLUMN `Coverage` TO coverage;
ALTER TABLE customers RENAME COLUMN `Education` TO education;
ALTER TABLE customers RENAME COLUMN `Effective To Date` TO effective_to_date;
ALTER TABLE customers RENAME COLUMN `EmploymentStatus` TO employment_status;
ALTER TABLE customers RENAME COLUMN `Gender` TO gender;
ALTER TABLE customers RENAME COLUMN `Income` TO income;
ALTER TABLE customers RENAME COLUMN `Location Code` TO location_code;
ALTER TABLE customers RENAME COLUMN `Marital Status` TO marital_status;
ALTER TABLE customers RENAME COLUMN `Monthly Premium Auto` TO monthly_premium_auto;
ALTER TABLE customers RENAME COLUMN `Months Since Last Claim` TO months_since_last_claim;
ALTER TABLE customers RENAME COLUMN `Months Since Policy Inception` TO months_since_policy_inception;
ALTER TABLE customers RENAME COLUMN `Number of Open Complaints` TO open_complaints;
ALTER TABLE customers RENAME COLUMN `Number of Policies` TO num_policies;
ALTER TABLE customers RENAME COLUMN `Policy Type` TO policy_type;
ALTER TABLE customers RENAME COLUMN `Policy` TO policy;
ALTER TABLE customers RENAME COLUMN `Renew Offer Type` TO renew_offer_type;
ALTER TABLE customers RENAME COLUMN `Sales Channel` TO sales_channel;
ALTER TABLE customers RENAME COLUMN `Total Claim Amount` TO total_claim_amount;
ALTER TABLE customers RENAME COLUMN `Vehicle Class` TO vehicle_class;
ALTER TABLE customers RENAME COLUMN `Vehicle Size` TO vehicle_size;


-- 1. Duplicate customer_id
SELECT customer_id , COUNT(*)
FROM customers
GROUP BY customer_id 
HAVING COUNT(*) > 1 ;


-- 2. NULL values check
SELECT 
      SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END ) as null_state,
      SUM(CASE WHEN income IS NULL THEN 1 ELSE 0 END ) as null_income,
      SUM(CASE WHEN clv IS NULL THEN 1 ELSE 0 END ) as null_clv,
      SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END ) as null_clv,
      SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END ) as null_gender
FROM customers ;


-- 3. Distinct values check 
SELECT DISTINCT gender 
FROM customers;

SELECT DISTINCT education
FROM customers;

SELECT DISTINCT policy_type
FROM customers ;

SELECT DISTINCT vehicle_class
FROM customers;



-- 4. Negative ya invalid values check
SELECT * 
FROM customers
WHERE income < 0 OR clv < 0 
                 OR monthly_premium_auto < 0 ;
                 
-- 5.Date format check.
SELECT effective_to_date
FROM customers
LIMIT 20 ;


SET SQL_SAFE_UPDATES = 0 ;

-- Trim extra spaces
UPDATE customers 
SET state = TRIM(state);


-- UPDATE gender
UPDATE customers
SET gender = "Male"
WHERE gender = "M" ;

UPDATE customers
SET gender = "FeMale"
WHERE gender = "F" ;


ALTER TABLE customers
ADD COLUMN effective_date DATE;

UPDATE customers
SET effective_date = STR_TO_DATE(effective_to_date,"%m/%d/%y");

SELECT effective_date 
FROM customers
LIMIT 10 ;


-- Q1: High-value customers kaun hain (CLV ke basis pe)?
SELECT customer_id , state, clv , income , num_policies
FROM customers
ORDER BY clv DESC 
LIMIT 10 ;



-- Q2: CLV segments banao (High/Medium/Low)
SELECT 
	  CASE WHEN clv > 20000 THEN "High"
           WHEN clv BETWEEN 8000 AND 19999 THEN "Medium"
           ELSE "Low"
           END AS clv_segment,
COUNT(*) as customers,
AVG(income) as avg_income,
AVG(total_claim_amount) as avg_claim
FROM customers
GROUP BY clv_segment
ORDER BY avg_claim DESC ;


-- Q3: Kaunsa Sales Channel sabse zyada positive response laata hai?
SELECT sales_channel,
COUNT(*) as customers,
SUM(CASE WHEN response = "Yes" THEN 1 ELSE 0 END )as response_yes,
SUM(CASE WHEN response = "Yes" THEN 1 ELSE 0 END ) * 100.0 / COUNT(*) as response_rate_pct
FROM customers
GROUP BY sales_channel
ORDER BY response_rate_pct DESC ;



-- Q4: Renew Offer Type ka response rate
SELECT renew_offer_type,
COUNT(*) as total,
SUM(CASE WHEN response = "Yes" THEN 1 ELSE 0 END ) as accepted,
SUM(CASE WHEN response = "Yes" THEN 1 ELSE 0 END ) * 100.0 / COUNT(*) AS accepted_rate
FROM customers 
GROUP BY renew_offer_type
ORDER BY accepted_rate DESC ;


 
 -- Q5: Loss Ratio — Premium vs Claim (kaun sa vehicle class risky hai)
 SELECT vehicle_class,
 AVG(monthly_premium_auto) as avg_premium,
 AVG(total_claim_amount) as avg_claim ,
 AVG(total_claim_amount) / AVG(monthly_premium_auto) as loss_ratio
 FROM customers
 GROUP BY vehicle_class
 ORDER BY loss_ratio DESC ;
 
 
 -- Q6: Policy Type wise profitability
 
 SELECT policy_type,
 COUNT(*) as total_customers,
 SUM(monthly_premium_auto) as total_premium_collected,
 SUM(total_claim_amount) as total_claim_paid,
SUM(total_claim_amount) - SUM(monthly_premium_auto) AS net_profit
FROM customers
GROUP BY policy_type
ORDER BY net_profit DESC ;



-- Q7: Complaints aur CLV ka relation (kya complaints se value girti hai?)
SELECT open_complaints , 
       COUNT(*) as total_customers,
       AVG(clv) as avg_clv,
       AVG(total_claim_amount) as avg_claim
FROM customers 
GROUP BY open_complaints
ORDER BY open_complaints ;



-- Q8: Kitne customers "at-risk" hain (recently claim kiya, multiple complaints)
SELECT customer_id , state ,  months_since_last_claim , open_complaints, clv
FROM customers
WHERE months_since_last_claim <=3 AND open_complaints >= 2 
ORDER BY clv DESC ;




-- Q9: Employment Status aur Income ka CLV pe impact
SELECT employment_status , 
       COUNT(*) as customers,
       AVG(income) as avg_income,
       AVG(clv) as avg_clv
FROM customers
GROUP BY employment_status
ORDER BY avg_clv DESC ;


-- Q10: State-wise best performing markets
SELECT state , 
      COUNT(*) as total_customers,
      AVG(clv) as avg_clv,
      AVG(monthly_premium_auto) as total_revenue
FROM customers
GROUP BY state
ORDER BY total_revenue DESC ;



-- Q11: Education level aur coverage type ka combination
SELECT  education, coverage,
        COUNT(*) as customers,
        AVG(clv) as avg_clv
FROM customers
GROUP BY education, coverage
ORDER BY avg_clv DESC 
LIMIT 10 ;




      








 
 
 
 





























