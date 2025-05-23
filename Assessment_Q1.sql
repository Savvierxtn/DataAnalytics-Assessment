WITH plan_summary AS (
    SELECT
        owner_id,
        COUNT(CASE WHEN is_regular_savings = 1 OR open_savings_plan = 1 THEN 1 END) AS savings_count,
        COUNT(CASE WHEN is_a_fund = 1 OR is_fixed_investment = 1 THEN 1 END) AS investment_count
    FROM
        plans_plan
    GROUP BY
        owner_id
),
deposit_summary AS (
    SELECT
        owner_id,
        SUM(confirmed_amount) AS total_confirmed
    FROM
        savings_savingsaccount
    GROUP BY
        owner_id
)
SELECT
    u.id AS owner_id,
    u.name,
    COALESCE(p.savings_count, 0) AS savings_count,
    COALESCE(p.investment_count, 0) AS investment_count,
    ROUND(COALESCE(d.total_confirmed, 0) / 100.0, 2) AS total_deposits
FROM
    users_customuser u
LEFT JOIN
    plan_summary p ON p.owner_id = u.id
LEFT JOIN
    deposit_summary d ON d.owner_id = u.id
WHERE
    COALESCE(p.savings_count, 0) > 0
    AND COALESCE(p.investment_count, 0) > 0
ORDER BY
    total_deposits DESC;
