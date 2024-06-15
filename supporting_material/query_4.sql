WITH TotalItems AS (
    SELECT
        rewardsReceiptStatus,
        SUM(purchasedItemCount) AS total_items_purchased
    FROM
        Receipts
    WHERE
        rewardsReceiptStatus IN ('Accepted', 'Rejected')
    GROUP BY
        rewardsReceiptStatus
)
SELECT
    CASE
        WHEN (SELECT total_items_purchased FROM TotalItems WHERE rewardsReceiptStatus = 'Accepted') >
             (SELECT total_items_purchased FROM TotalItems WHERE rewardsReceiptStatus = 'Rejected')
        THEN 'Accepted'
        ELSE 'Rejected'
    END AS greater_total_items_purchased;
