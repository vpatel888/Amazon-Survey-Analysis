-- CSAT METRIC

SELECT *
FROM Amazon.`amazon customer behavior survey`;

-- What is the CSAT score?
SELECT (COUNT(shopping_satisfaction)/602) * 100 AS CSAT
FROM Amazon.`amazon customer behavior survey`
WHERE shopping_satisfaction = 1 OR shopping_satisfaction = 2;

-- What areas for improvement are most frequently mentioned by less satisfied customers? (customer service got the highest)
SELECT improvement_areas, COUNT(shopping_satisfaction) AS "Unsatisfied customers"
FROM Amazon.`amazon customer behavior survey`
WHERE shopping_satisfaction = 5 OR shopping_satisfaction = 4
GROUP BY improvement_areas
ORDER BY  COUNT(shopping_satisfaction) DESC;

-- What service aspects do highly satisfied customers appreciate the most? (competitive prices got the highest)
SELECT Service_Appreciation, COUNT(shopping_satisfaction) AS "Satisfied customers", (COUNT(shopping_satisfaction)/602) * 100 AS CSAT
FROM Amazon.`amazon customer behavior survey`
WHERE shopping_satisfaction = 1 OR shopping_satisfaction = 2
GROUP BY Service_Appreciation
ORDER BY  COUNT(shopping_satisfaction) DESC;

-- Is there a possible correlation between recommendation accuracy and satisfaction? (there appears to be a correlation)
SELECT Recommendation_Accuracy, AVG(Shopping_Satisfaction)
FROM Amazon.`amazon customer behavior survey`
GROUP BY Recommendation_Accuracy
ORDER BY Recommendation_Accuracy;

SELECT Recommendation_Accuracy, Shopping_Satisfaction
FROM Amazon.`amazon customer behavior survey`
ORDER BY Recommendation_Accuracy, Shopping_Satisfaction;

-- Is there a possible correlation between customer_reviews_importance and satisfaction? (there is a slight correlation)
SELECT customer_reviews_importance, Shopping_Satisfaction
FROM Amazon.`amazon customer behavior survey`
ORDER BY customer_reviews_importance, Shopping_Satisfaction;

SELECT customer_reviews_importance, AVG(Shopping_Satisfaction)
FROM Amazon.`amazon customer behavior survey`
GROUP BY customer_reviews_importance
ORDER BY customer_reviews_importance;

-- PERCEIVED RECOMMENDATION/SEARCH ACCURACY METRIC

-- What percentage of customers rate the recommendations as accurate? (not a lot)
SELECT (COUNT(Recommendation_Accuracy)/602) * 100 AS satisfied_with_accuracy
FROM Amazon.`amazon customer behavior survey`
WHERE  Recommendation_Accuracy = 1 OR Recommendation_Accuracy = 2;

-- Do customers who receive recommendations more frequently also perceive them as more accurate? (there is a positive correlation)
SELECT personalized_recommendation_frequency, Recommendation_Accuracy
FROM Amazon.`amazon customer behavior survey`
ORDER BY personalized_recommendation_frequency, Recommendation_Accuracy;

SELECT personalized_recommendation_frequency, AVG(Recommendation_Accuracy)
FROM Amazon.`amazon customer behavior survey`
GROUP BY personalized_recommendation_frequency
ORDER BY personalized_recommendation_frequency;

-- Are users who perceive recommendations as accurate more likely to do add_to_cart browsing than those who don't perceive recommendations as accurate? (yes. 42 percent vs 32  percent)
WITH recommendation_accurate_cte AS (
	SELECT Add_to_Cart_Browsing, COUNT(Recommendation_Accuracy) AS add_to_cart_count
	FROM Amazon.`amazon customer behavior survey`
	WHERE Recommendation_Accuracy = 1 OR Recommendation_Accuracy = 2
	GROUP BY Add_to_Cart_Browsing
)
,sum_cte AS (
	SELECT Add_to_Cart_Browsing, add_to_cart_count, SUM(add_to_cart_count) OVER () AS total
	FROM recommendation_accurate_cte
)
SELECT Add_to_Cart_Browsing, add_to_cart_count, total, add_to_cart_count/total * 100 AS percentage
FROM sum_cte;

WITH recommendation_accurate_cte AS (
	SELECT Add_to_Cart_Browsing, COUNT(Recommendation_Accuracy) AS add_to_cart_count
	FROM Amazon.`amazon customer behavior survey`
	WHERE Recommendation_Accuracy = 4 OR Recommendation_Accuracy = 5
	GROUP BY Add_to_Cart_Browsing
)

,sum_cte AS (
	SELECT Add_to_Cart_Browsing, add_to_cart_count, SUM(add_to_cart_count) OVER () AS total
	FROM recommendation_accurate_cte
)

SELECT Add_to_Cart_Browsing, add_to_cart_count, total, add_to_cart_count/total * 100 AS percentage
FROM sum_cte;

-- Is there a relationship between browsing frequency and the perceived accuracy of recommendations? (there is a positive correlation)
SELECT Browsing_Frequency, AVG(Recommendation_Accuracy)
FROM Amazon.`amazon customer behavior survey`
GROUP BY Browsing_Frequency 
ORDER BY AVG(Recommendation_Accuracy);

-- how does search_results_exploration and Recommendation_Accuracy relate? (people tend to explore multiple pages if the recommendation accuracy is higher)
SELECT Search_Result_Exploration, AVG(Recommendation_Accuracy)
FROM Amazon.`amazon customer behavior survey`
GROUP BY Search_Result_Exploration
ORDER BY AVG(Recommendation_Accuracy);

-- for people who find Recommendation_Accuracy high, what is their shopping satisfaction?
-- for people who don't find Recommendation_Accuracy low, what is their shopping satisfaction?
SELECT AVG(shopping_satisfaction)
FROM Amazon.`amazon customer behavior survey`
WHERE Recommendation_Accuracy = 1 OR Recommendation_Accuracy = 2;

SELECT AVG(shopping_satisfaction)
FROM Amazon.`amazon customer behavior survey`
WHERE Recommendation_Accuracy = 4 OR Recommendation_Accuracy = 5;


-- PERCEPTION OF CUSTOMER REVIEWS METRIC

-- What percentage of customers consider reviews to be “very important or important” in their decision-making process? (47 percent)
SELECT (COUNT(Customer_Reviews_Importance)/602) * 100 AS Customer_Reviews_Importance
FROM Amazon.`amazon customer behavior survey`
WHERE Customer_Reviews_Importance = 1 OR Customer_Reviews_Importance = 2;

-- What percentage of Amazon customers find reviews helpful in their decision-making? (only 26 percent)
SELECT (COUNT(Recommendation_Helpfulness)/602) * 100 AS Customer_Reviews_Helpfulness
FROM Amazon.`amazon customer behavior survey`
WHERE Recommendation_Helpfulness = 'Yes';

-- Do customers who value reviews tend do more add_to_cart_browsing than those who don't? (Yes)
WITH value_review_customers_CTE AS (
	SELECT Add_to_Cart_Browsing, COUNT(Customer_Reviews_Importance) AS responses
	FROM Amazon.`amazon customer behavior survey`
	WHERE Customer_Reviews_Importance = 1 OR Customer_Reviews_Importance = 2
	GROUP BY Add_to_Cart_Browsing
)
, sum_cte AS (SELECT *, SUM(responses) OVER () AS total_responses
FROM value_review_customers_CTE)

SELECT *, responses/total_responses * 100 AS percentage
FROM sum_cte;

WITH value_review_customers_CTE AS (
	SELECT Add_to_Cart_Browsing, COUNT(Customer_Reviews_Importance) AS responses
	FROM Amazon.`amazon customer behavior survey`
	WHERE Customer_Reviews_Importance = 4 OR Customer_Reviews_Importance = 5
	GROUP BY Add_to_Cart_Browsing
)
, sum_cte AS (SELECT *, SUM(responses) OVER () AS total_responses
FROM value_review_customers_CTE)

SELECT *, responses/total_responses * 100 AS percentage
FROM sum_cte;

-- Which combination of review perception variables (importance, reliability, helpfulness) correlates most with a high shopping satisfaction?) (Review_Reliability: Heavily, Review_Helpfulness: Yes, AVG(Customer_Reviews_Importance): 1.6036)
SELECT Review_Reliability, Review_Helpfulness, AVG(Customer_Reviews_Importance), AVG(shopping_satisfaction)
FROM Amazon.`amazon customer behavior survey`
GROUP BY Review_Reliability, Review_Helpfulness
ORDER BY AVG(shopping_satisfaction);

-- for people who find reviews important, what is their satisfaction level? (Higher Satisfaction)
-- for people who don't find reviews important, what is their satisfaction level? (Lower Satisfaction)
SELECT AVG(shopping_satisfaction)
FROM Amazon.`amazon customer behavior survey`
WHERE Customer_Reviews_Importance = 1 OR Customer_Reviews_Importance = 2;

SELECT AVG(shopping_satisfaction)
FROM Amazon.`amazon customer behavior survey`
WHERE Customer_Reviews_Importance = 4 OR Customer_Reviews_Importance = 5;

-- how does search_results_exploration and customer_reviews_importance relate? (people tend to browse more pages if customer_review_importance is higher)
SELECT Search_Result_Exploration, AVG(Customer_Reviews_Importance)
FROM Amazon.`amazon customer behavior survey`
GROUP BY Search_Result_Exploration
ORDER BY AVG(Customer_Reviews_Importance);

-- how does browsing frequency and review_importance relate? (there is a relation)
SELECT Browsing_Frequency, AVG(Customer_Reviews_Importance)
FROM Amazon.`amazon customer behavior survey`
GROUP BY Browsing_Frequency
ORDER BY AVG(Customer_Reviews_Importance);

-- how does browsing frequency and shopping_satisfaction relate? (there is a relation)
SELECT Browsing_Frequency, AVG(Shopping_Satisfaction)
FROM Amazon.`amazon customer behavior survey`
GROUP BY Browsing_Frequency
ORDER BY AVG(Shopping_Satisfaction);

-- how does search_results_exploration and shopping_satisfaction relate? (people tend to browse more pages if customer_review_importance is higher)
SELECT Search_Result_Exploration, AVG(shopping_satisfaction)
FROM Amazon.`amazon customer behavior survey`
GROUP BY Search_Result_Exploration
ORDER BY AVG(shopping_satisfaction);


