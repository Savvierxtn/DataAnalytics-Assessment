SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        WHEN p.open_savings_plan = 1 THEN 'Savings'
        WHEN p.is_fixed_investment = 1 THEN 'Investment'
        ELSE 'Unknown'
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE, MAX(s.transaction_date)) AS inactivity_days
FROM
    plans_plan p
LEFT JOIN
    savings_savingsaccount s ON s.plan_id = p.id AND s.confirmed_amount > 0
WHERE
    p.locked = FALSE
    AND (p.is_regular_savings = 1 OR p.is_fixed_investment = 1 OR p.open_savings_plan = 1 OR p.is_a_fund = 1)
GROUP BY
    p.id, p.owner_id, p.is_regular_savings, p.is_a_fund, p.is_fixed_investment, p.open_savings_plan
HAVING
    MAX(s.transaction_date) IS NULL OR DATEDIFF(CURRENT_DATE, MAX(s.transaction_date)) > 365
ORDER BY
    inactivity_days DESC;
