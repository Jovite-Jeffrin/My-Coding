### Case Study #3 - Foodie-Fi [Link](https://8weeksqlchallenge.com/case-study-3/)

##### Table 1: plans
Customers can choose which plans to join Foodie-Fi when they first sign up.

Basic plan customers have limited access and can only stream their videos and is only available monthly at $9.90

Pro plan customers have no watch time limits and are able to download videos for offline viewing. Pro plans start at $19.90 a month or $199 for an annual subscription.

Customers can sign up to an initial 7 day free trial will automatically continue with the pro monthly subscription plan unless they cancel, downgrade to basic or upgrade to an annual pro plan at any point during the trial.

When customers cancel their Foodie-Fi service - they will have a churn plan record with a null price but their plan will continue until the end of the billing period.

Dataset Link: [Link](https://github.com/Jovite-Jeffrin/My-Coding/blob/4f57bc716d3b70167d1babfdcb706a161bd5a8c1/SQL/8%20Week%20SQL%20Challenge/Case%20Study%203/plans_data.csv)

##### Table 2: subscriptions
Customer subscriptions show the exact date where their specific plan_id starts.

If customers downgrade from a pro plan or cancel their subscription - the higher plan will remain in place until the period is over - the start_date in the subscriptions table will reflect the date that the actual plan changes.

When customers upgrade their account from a basic plan to a pro or annual pro plan - the higher plan will take effect straightaway.

When customers churn - they will keep their access until the end of their current billing period but the start_date will be technically the day they decided to cancel their service.

Dataset Link: [Link](https://github.com/Jovite-Jeffrin/My-Coding/blob/4f57bc716d3b70167d1babfdcb706a161bd5a8c1/SQL/8%20Week%20SQL%20Challenge/Case%20Study%203/subscriptions_data.csv)

---

#### Data Analysis Questions
