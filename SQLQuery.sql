 
-- Question 1
SELECT TOP 5 IT.brandcode as 'Top Brands', COUNT(IT.brandCode) as 'Receipts scanned'
FROM itemlist as IT
	INNER JOIN receipts as RE ON IT.receipts_id = RE.id
WHERE IT.brandCode IS NOT NULL AND 
	(MONTH(RE.dateScanned) = (SELECT MONTH(MAX(R1.datescanned))-1 FROM receipts as R1) AND
	YEAR(RE.dateScanned) = (SELECT YEAR(MAX(R2.datescanned)) FROM receipts as R2))
GROUP BY IT.brandcode
ORDER BY COUNT(IT.brandCode) DESC

-- Question 2
SELECT TOP 5 IT.brandcode as 'Top Brands', COUNT(IT.brandCode) as 'Receipts scanned'
FROM itemlist as IT
	INNER JOIN receipts as RE ON IT.receipts_id = RE.id
WHERE IT.brandCode IS NOT NULL AND 
	(MONTH(RE.dateScanned) = (SELECT MONTH(MAX(R1.datescanned))-2 FROM receipts as R1) AND
	YEAR(RE.dateScanned) = (SELECT YEAR(MAX(R2.datescanned)) FROM receipts as R2))
GROUP BY IT.brandcode
ORDER BY COUNT(IT.brandCode) DESC

-- Question 3 & 4
SELECT rewardsReceiptStatus as 'Receipt status', AVG(totalSpent) as 'Average spend', SUM(purchasedItemCount) as 'Total number of items purchased'
FROM receipts
WHERE rewardsReceiptStatus IN ('FINISHED', 'REJECTED')
GROUP BY rewardsReceiptStatus

-- Question 5
SELECT TOP 1 IT.brandcode as 'Brand with most spend', SUM(IT.itemprice) as 'Total spend'
FROM itemlist as IT
	INNER JOIN receipts as RE ON IT.receipts_id = RE.id
	INNER JOIN users as US ON RE.userId = US.ID
WHERE IT.brandcode IS NOT NULL AND US.createdDate > dateadd(month,-8,CURRENT_TIMESTAMP)
GROUP BY IT.brandcode
ORDER BY SUM(IT.itemprice) DESC

-- Question 6
SELECT TOP 1 IT.brandcode as 'Brand with most transcations', COUNT(IT.brandcode) as 'Total transactions'
FROM itemlist as IT
	INNER JOIN receipts as RE ON IT.receipts_id = RE.id
	INNER JOIN users as US ON RE.userId = US.ID
WHERE IT.brandcode IS NOT NULL AND US.createdDate > dateadd(month,-8,CURRENT_TIMESTAMP)
GROUP BY IT.brandcode
ORDER BY COUNT(IT.brandcode) DESC