-- The transaction_id is the unique id for this dataset
-- Checking for duplicates

SELECT transaction_id, COUNT(*) count
FROM sales_staging
GROUP BY 1
HAVING count > 1;

-- No duplicates

-- Renaming Columns For Convenience

SELECT *
FROM sales_staging;

ALTER TABLE sales_staging
RENAME COLUMN `Transaction ID` TO transaction_id;

ALTER TABLE sales_staging
RENAME COLUMN `Price Per Unit` TO price_per_unit;

ALTER TABLE sales_staging
RENAME COLUMN `Total Spent` TO total_spent;

ALTER TABLE sales_staging
RENAME COLUMN `Payment Method` TO payment_method;

ALTER TABLE sales_staging
RENAME COLUMN `Transaction Date` TO transaction_date;



-- Changing Datatypes

-- Changing transaction_id data type from text to VARCHAR
ALTER TABLE sales_staging
MODIFY transaction_id VARCHAR(100);

-- Setting transaction_id as primary key
ALTER TABLE sales_staging
ADD PRIMARY KEY (transaction_id);


-- Dealing with Blanks

-- Checking types of Quantity
SELECT quantity, count(*) count
FROM sales_staging
GROUP BY 1;

-- Checking types of price_per_unit
SELECT price_per_unit, count(*) count
FROM sales_staging
GROUP BY 1;

-- 'Unknown', 'Error' and blanks found throughout multiple columns.
-- Standardizing to NULL

UPDATE sales_staging
SET 
    total_spent = CASE
        WHEN total_spent IN ('Unknown', 'Error', '') THEN NULL
        ELSE total_spent
    END,
    item = CASE
        WHEN item IN ('Unknown', 'Error', '') THEN NULL
        ELSE item
    END,
    payment_method = CASE
        WHEN payment_method IN ('Unknown', 'Error', '') THEN NULL
        ELSE payment_method
    END,
    location = CASE
        WHEN location IN ('Unknown', 'Error', '') THEN NULL
        ELSE location
    END,
    transaction_date = CASE
        WHEN transaction_date IN ('Unknown', 'Error', '') THEN NULL
        ELSE transaction_date
    END,
    quantity = CASE
        WHEN quantity IN ('Unknown', 'Error', '') THEN NULL
        ELSE quantity
    END,
    price_per_unit = CASE
        WHEN price_per_unit IN ('Unknown', 'Error', '') THEN NULL
        ELSE price_per_unit
    END;

-- Changing Data Types
ALTER TABLE sales_staging
MODIFY Quantity INT;

ALTER TABLE sales_staging
MODIFY price_per_unit DOUBLE;

ALTER TABLE sales_staging
MODIFY total_spent DOUBLE;

-- Standardizing Date
UPDATE sales_staging
SET transaction_date = STR_TO_DATE(transaction_date, '%Y-%m-%d');

ALTER TABLE sales_staging
MODIFY transaction_date DATE;


-- Filling In NULLS

-- Retrieving items with price_per_unit that are NULL
SELECT DISTINCT item, price_per_unit
FROM sales_staging
WHERE price_per_unit IS NULL
ORDER BY 1 DESC;

-- Retrieving items with price_per_unit not NULL
SELECT DISTINCT item, price_per_unit
FROM sales_staging
WHERE price_per_unit IS NOT NULL
ORDER BY 1 DESC;

-- Looking at how many rows with missing price_per_unit
SELECT DISTINCT item, COUNT(*)
	FROM sales_staging
	WHERE price_per_unit IS NULL
	GROUP BY item WITH ROLLUP
	ORDER BY 1 DESC;

-- 533 rows

-- Self joining table
SELECT t1.item, t1.price_per_unit, t2.item, t2.price_per_unit
FROM sales_staging t1
JOIN sales_staging t2
	ON t1.item = t2.item
    AND t1.price_per_unit IS NULL
    AND t2.price_per_unit IS NOT NULL;
    
-- Filling in missing price_per_unit
UPDATE sales_staging t1
JOIN (SELECT item, price_per_unit
	FROM sales_staging
    WHERE price_per_unit IS NOT NULL
    ) t2 ON t1.item = t2.item
SET t1.price_per_unit = t2.price_per_unit
WHERE t1.price_per_unit IS NULL;

SELECT *
FROM sales_staging
WHERE price_per_unit;

-- Filling In NULL values for Quantity where price_per_unit is NULL
SELECT transaction_id,
	CASE
		WHEN quantity IS NULL THEN (total_spent/price_per_unit)
        ELSE quantity
        END,
	CASE
		WHEN price_per_unit IS NULL THEN (total_spent/quantity)
        ELSE price_per_unit
        END
FROM sales_staging;

UPDATE sales_staging
SET quantity = CASE
			WHEN quantity IS NULL THEN (total_spent/price_per_unit)
			ELSE quantity
			END,
price_per_unit = CASE
			WHEN price_per_unit IS NULL THEN (total_spent/quantity)
			ELSE price_per_unit
			END;
            
SELECT *
FROM sales_staging
WHERE total_spent IS NULL;

UPDATE sales_staging
SET total_spent = CASE
			WHEN total_spent IS NULL THEN (quantity * price_per_unit)
			ELSE total_spent
			END;
            
SELECT *
FROM sales_staging;

SELECT DISTINCT item, price_per_unit
FROM sales_staging
ORDER BY 1 DESC;

UPDATE sales_staging
SET item = 'Unknown'
WHERE item IS NULL AND price_per_unit = 4;

-- Filling NULL Item Names
UPDATE sales_staging t1
JOIN (SELECT price_per_unit, item
	FROM sales_staging
    WHERE item IS NOT NULL) t2
ON t1.price_per_unit = t2.price_per_unit
SET t1.item = t2.item
WHERE t1.item IS NULL;

-- Setting NULLS to 'Unknown' For payment_method and location
UPDATE sales_staging
SET payment_method = 'Unknown'
WHERE payment_method IS NULL;

UPDATE sales_staging
SET location = 'Unknown'
WHERE location IS NULL;
