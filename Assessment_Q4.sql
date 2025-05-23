SELECT
    u.id AS customer_id,
    u.name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND(
        (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE), 0)) * 12 *
        (AVG(s.confirmed_amount) * 0.001 / 100), 2
    ) AS estimated_clv
FROM
    users_customuser u
JOIN
    savings_savingsaccount s ON s.owner_id = u.id
WHERE
    s.confirmed_amount > 0
GROUP BY
    u.id, u.name, u.date_joined
ORDER BY
    estimated_clv DESC;
