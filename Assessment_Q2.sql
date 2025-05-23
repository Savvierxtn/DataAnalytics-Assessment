-- Step 1: Start from users, join their savings transactions
WITH all_transactions AS (
    SELECT 
        s.owner_id AS id,
        DATE_FORMAT(s.transaction_date, '%Y-%m') AS txn_month
    FROM savings_savingsaccount s
    JOIN users_customuser u ON s.owner_id = u.id
    WHERE s.confirmed_amount > 0
),

-- Step 2: Count transactions and active months per user
monthly_counts AS (
    SELECT 
        id,
        COUNT(*) AS total_txns,
        COUNT(DISTINCT txn_month) AS active_months
    FROM all_transactions
    GROUP BY id
),

-- Step 3: Compute average transactions per month
monthly_avg AS (
    SELECT 
        id,
        total_txns / active_months AS avg_txn_per_month
    FROM monthly_counts
),

-- Step 4: Classify users by frequency category
categorized AS (
    SELECT 
        id,
        CASE
            WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txn_per_month
    FROM monthly_avg
)

-- Step 5: Aggregate results by category
SELECT 
    frequency_category,
    COUNT(DISTINCT id) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;
