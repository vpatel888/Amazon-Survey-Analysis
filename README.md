# Amazon Survey Analysis

### Project Background

Amazon, the largest e-commerce company in the world, sells a wide variety of consumer products online from its warehouses and third-party vendors. An existing dataset contains Amazon survey responses that provides a look into customer perceptions towards the company and their interactions with its online platform. The purpose of this project is to uncover any patterns in consumer behavior and understand what Amazon needs to improve with its online platform so that customers can have a better shopping experience. 

Insights and Recommendations are provided on the following North Star Metrics:

* **Customer Satisfaction Score (CSAT):** A metric that demonstrates consumers overall satisfaction with Amazon. This is calculated using the shopping_satisfaction variable that uses a likert scale (1 = Very Unsatisfied to 5 = Very Satisfied). 

* **Personalized Recommendation Accuracy:** A metric that demonstrates how accurate consumers believe Amazon's personalized recommendation are. This is calculated using the recommendation_accuracy variable that uses a likert scale (1 = Very Inaccurate to 5 = Very Accurate). 

* **Perception of Customer Reviews:** A metric that demonstrates how much consumers value reviews when making decisions. This is calculated using the customers_review_importance variable that uses a likert scale (1 = Very Unimportant to 5 = Very Important).

### Summary of Insights

#### **CSAT (Customer Satisfaction Score):**
##### **Score: 51.33% (percentage of customers satsifed with Amazon overall)**
* The top 3 aspects satisfied customers appreciate: Competitive Prices (1), Wide Product Selection (2), Product Recommendations (3).
* The top 3 areas unsatisfied customers want improved: Customer Service Responsiveness (1), Product Quality and Accuracy (2), Reducing Packaging Waste (3).
* Customers who view recommendations as accurate tend to have a higher customer satisfaction score (CSAT). The Pearson Correlation Coefficient is 0.5140, which is generally a moderate positive correlation. 
* Customers who value reviews in their purchasing decisions tend to have higher customer satisfaction score (CSAT). The Pearson Correlation Coefficient is 0.4023, which is generally a moderate positive correlation. 

#### **Personalized Recommendation Accuracy:**
##### **Score: 39.37% (percentage of customers who view personalized recommendations as accurate)**
* Customers who claim to get more frequent recommendations tend to view recommendations as more accurate. The Pearson Correlation Coefficient is 0.4379, which is generally a moderate positive correlation. 
* Customers who view recommendations as accurate are more likely to add products to their cart while browsing than those who don't view recommendations as accurate.
* Customers who explore multiple pages of search results view recommendations with higher accuracy than those who only explore one page.

#### **Customer Reviews Importance:**
##### **Score: 47.18% (percentage of customers who view reviews are important when making purchasing decisions)**
* Customers who explore multiple pages of search results value reviews higher in their purchasing decisions than those who only explore one page.
* Customers who value reviews higher in their purchasing decisions are more likely to add products to their cart while browsing the website than those who don't value reviews as much.

### Limitations of Dashboard
Due to software issues, I was unable to implement the dropdown button that would switch between the graphs. Here's a description of the issue if you are interested: https://community.tableau.com/s/question/0D5cw00000KJXZXCA5/tableau-public-apple-silicon-crashing-when-creating-a-list-parameter. As an alternative, I implemented a text-box that would switch the charts when the user types a particular letter. The screenshot is below, but I highly recommend interacting with the dashboard's text box features so you can view all of the charts: 

https://public.tableau.com/views/AmazonConsumerBehavior/Dashboard2?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link  

<img width="2198" height="1698" alt="Dashboard 2 (2)" src="https://github.com/user-attachments/assets/67ccecba-25d2-488b-b17b-fe25fb4fe972" />


### Recommendations and Next Steps
* Investigate what issues unsatisifed customers have with Customer Service Responsiveness and implement changes based on frequent issues that are reported. 
* Continue to maintain competitive pricing and emphasize pricing in marketing strategy to push potential customers away from competitors
* Since personalized recommendation is likely to lead to more user engagement and overall satisfaction, look into making improvements for the AI recommendation system
* Since trusting review accuracy is likely to lead to more user engagement and overall satisfaction, look into improving AI systems that detect fake reviews as well as making sure that human moderators are equipped with the best tools to spot fake reviews 
  
