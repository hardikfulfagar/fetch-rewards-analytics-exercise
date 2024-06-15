WITH RecentMonth AS (
    SELECT
        MAX(purchaseDate) AS most_recent_date
    FROM
        Receipts
)
SELECT
    b.name AS brand_name,
    COUNT(r.receiptId) AS receipt_count
FROM
    Receipts r
JOIN
    rewardsReceiptItems ri ON r.receiptId = ri.receiptId
JOIN
    Brands b ON ri.brandId = b.brandId AND ri.barcode = b.barcode
JOIN
    CpgDetails c ON b.cpgId = c.cpgId
WHERE
    r.purchaseDate >= date('now', 'start of month', '-1 month') AND
    r.purchaseDate < date('now', 'start of month')
GROUP BY
    b.name
ORDER BY
    receipt_count DESC
LIMIT 5;
