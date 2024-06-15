WITH RecentUsers AS (
    SELECT
        userId
    FROM
        Users
    WHERE
        createdDate >= date('now', '-6 months')
)
SELECT
    b.name AS brand_name,
    COUNT(ri.rewardsReceiptItemId) AS transaction_count
FROM
    Receipts r
JOIN
    rewardsReceiptItems ri ON r.receiptId = ri.receiptId
JOIN
    Brands b ON ri.brandId = b.brandId AND ri.barcode = b.barcode
WHERE
    r.userId IN (SELECT userId FROM RecentUsers)
GROUP BY
    b.name
ORDER BY
    transaction_count DESC
LIMIT 1;
