
# SQL Reporting Tasks: Customer Insights and Business Metrics

This repository contains a collection of SQL queries developed to support business intelligence for a financial services platform. The queries extract insights from customer, plan, savings, and withdrawal data to support operations, marketing, and strategic decision-making.

📘 Overview of Queries

---

1. Cross-Sell Opportunity: Customers with Both Savings and Investment Plans

Objective:
Identify customers who have at least one funded savings plan and one funded investment plan.

Key Metrics:
- `owner_id`, `name`
- Number of savings plans (`savings_count`)
- Number of investment plans (`investment_count`)
- Total confirmed deposits (`total_deposits`)

Use Case:
Used by the marketing team to identify cross-selling opportunities.

---

2. Inactive Plans: No Inflows in Over 1 Year

Objective: 
Find active (unlocked) savings or investment plans with no deposit activity in the last 365 days.

Key Metrics:
- `plan_id`, `owner_id`
- Plan `type` (Savings or Investment)
- `last_transaction_date`
- `inactivity_days` (days since last deposit)

Use Case:  
Used by the operations team to identify dormant or at-risk plans for customer re-engagement campaigns.

---

3. Customer Lifetime Value (CLV) Estimation

Objective:  
Estimate Customer Lifetime Value using a simplified model based on deposit transaction volume and account tenure.

Formula:
`CLV = (total_transactions / tenure_months) × 12 × avg_profit_per_transaction`  
Where `profit_per_transaction = 0.1%` of each deposit (in kobo).

Key Metrics:
- `customer_id`, `name`
- `tenure_months` (since sign-up)
- `total_transactions` (confirmed deposits)
- `estimated_clv` (in naira)

Use Case:  
Used by the marketing and finance teams to prioritize high-value customers and forecast revenue potential.

---

4. Optimized Cross-Sell Query

Objective:  
Improved performance version of the cross-sell query using CTEs and pre-aggregated data.

Improvements:
it took more time to create queries with:
- Faster execution via `WITH` clauses and reduced joins
- Avoids unnecessary `DISTINCT` and heavy `HAVING` filtering

Use Case: 
Supports real-time dashboards and larger datasets for analytics workflows.

---

🧾 Tables Used

| Table | Description |
|-------|-------------|
| `users_customuser` | Customer demographics and sign-up data |
| `plans_plan` | Customer plans (savings/investment) |
| `savings_savingsaccount` | Deposit transaction records |
| `withdrawals_withdrawal` | Withdrawal transaction records |

---

⚙️ Notes

- All monetary values are stored in kobo and converted to naira (divide by 100).
- Savings and investment plans are differentiated using flags:
  - `is_regular_savings`, `open_savings_plan`
  - `is_a_fund`, `is_fixed_investment`
- Only active (unlocked) plans are considered for most reports.

---

📩 Contact

For questions or enhancements, please contact the Business Intelligence Team.
cements, please contact the Business Intelligence Team.
