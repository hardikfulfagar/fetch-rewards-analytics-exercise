WITH AvgSpend AS (
    SELECT
        rewardsReceiptStatus,
        AVG(totalSpent) AS average_spend
    FROM
        Receipts
    WHERE
        rewardsReceiptStatus IN ('Accepted', 'Rejected')
    GROUP BY
        rewardsReceiptStatus
)


SELECT
    CASE
        WHEN (SELECT average_spend FROM AvgSpend WHERE rewardsReceiptStatus = 'Accepted') >
             (SELECT average_spend FROM AvgSpend WHERE rewardsReceiptStatus = 'Rejected')
        THEN 'Accepted'
        ELSE 'Rejected'
    END AS greater_average_spend;