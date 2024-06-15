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
    SUM(ri.itemPrice * ri.quantityPurchased) AS total_spend
FROM
    Receipts r
JOIN
    rewardsReceiptItems ri ON r.receiptId = ri.receiptId
JOIN
    Brands b ON ri.brandId = b.brandId AND ri.barcode = b.barcode
JOIN
    CpgDetails c ON b.cpgId = c.cpgId
WHERE
    r.userId IN (SELECT userId FROM RecentUsers)
GROUP BY
    b.name
ORDER BY
    total_spend DESC
LIMIT 1;
