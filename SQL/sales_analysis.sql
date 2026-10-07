-- ============================================================
-- SALES DATA SQL ANALYSIS
-- Database: sales_analysis
-- Table: chandoo_sales_data
-- Database Engine: MySQL 8.0
-- ============================================================

USE sales_analysis;


-- ============================================================
-- 1. EXPLORE THE TABLE
-- ============================================================

SELECT *
FROM chandoo_sales_data;


-- ============================================================
-- 2. DATA QUALITY CHECK
-- ============================================================

SELECT
    COUNT(*) AS Total_Records,
    SUM(Sales_Person IS NULL) AS Null_Sales_Person,
    SUM(Country IS NULL) AS Null_Country,
    SUM(Product IS NULL) AS Null_Product,
    SUM(Date IS NULL) AS Null_Date,
    SUM(Amount IS NULL) AS Null_Amount,
    SUM(Boxes_Shipped IS NULL) AS Null_Boxes_Shipped
FROM chandoo_sales_data;


-- ============================================================
-- 3. TOTAL SALES
-- ============================================================

SELECT
    ROUND(SUM(Amount), 2) AS Total_Sales
FROM chandoo_sales_data;


-- ============================================================
-- 4. TOTAL BOXES SHIPPED
-- ============================================================

SELECT
    SUM(Boxes_Shipped) AS Total_Boxes_Shipped
FROM chandoo_sales_data;


-- ============================================================
-- 5. TOTAL PRODUCTS, COUNTRIES AND SALESPEOPLE
-- ============================================================

SELECT
    COUNT(DISTINCT Product) AS Total_Products,
    COUNT(DISTINCT Country) AS Total_Countries,
    COUNT(DISTINCT Sales_Person) AS Total_Salespeople
FROM chandoo_sales_data;


-- ============================================================
-- 6. MONTHLY SALES
-- ============================================================

SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month_Number,
    MONTHNAME(Date) AS Month,
    ROUND(SUM(Amount), 2) AS Total_Sales
FROM chandoo_sales_data
GROUP BY
    YEAR(Date),
    MONTH(Date),
    MONTHNAME(Date)
ORDER BY
    Year,
    Month_Number;


-- ============================================================
-- 7. MONTH-OVER-MONTH SALES GROWTH
-- ============================================================

WITH MonthlySales AS (
    SELECT
        YEAR(Date) AS Year,
        MONTH(Date) AS Month_Number,
        MONTHNAME(Date) AS Month,
        SUM(Amount) AS Total_Sales
    FROM chandoo_sales_data
    GROUP BY
        YEAR(Date),
        MONTH(Date),
        MONTHNAME(Date)
)

SELECT
    Year,
    Month_Number,
    Month,
    ROUND(Total_Sales, 2) AS Total_Sales,
    ROUND(
        (
            Total_Sales -
            LAG(Total_Sales) OVER (
                ORDER BY Year, Month_Number
            )
        )
        /
        NULLIF(
            LAG(Total_Sales) OVER (
                ORDER BY Year, Month_Number
            ),
            0
        ) * 100,
        2
    ) AS MoM_Growth_Percent
FROM MonthlySales
ORDER BY
    Year,
    Month_Number;


-- ============================================================
-- 8. TOTAL SALES BY COUNTRY
-- ============================================================

SELECT
    Country,
    ROUND(SUM(Amount), 2) AS Total_Sales
FROM chandoo_sales_data
GROUP BY Country
ORDER BY Total_Sales DESC;


-- ============================================================
-- 9. TOP 10 PRODUCTS BY SALES
-- ============================================================

SELECT
    Product,
    ROUND(SUM(Amount), 2) AS Total_Sales
FROM chandoo_sales_data
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 10;


-- ============================================================
-- 10. TOP 10 PRODUCTS BY BOXES SHIPPED
-- ============================================================

SELECT
    Product,
    SUM(Boxes_Shipped) AS Total_Boxes_Shipped
FROM chandoo_sales_data
GROUP BY Product
ORDER BY Total_Boxes_Shipped DESC
LIMIT 10;


-- ============================================================
-- 11. SALES PER BOX BY PRODUCT
-- ============================================================

SELECT
    Product,
    ROUND(SUM(Amount), 2) AS Total_Sales,
    SUM(Boxes_Shipped) AS Total_Boxes,
    ROUND(
        SUM(Amount) / NULLIF(SUM(Boxes_Shipped), 0),
        2
    ) AS Sales_Per_Box
FROM chandoo_sales_data
GROUP BY Product
ORDER BY Sales_Per_Box DESC;


-- ============================================================
-- 12. TOP 10 SALESPEOPLE BY SALES
-- ============================================================

SELECT
    Sales_Person,
    ROUND(SUM(Amount), 2) AS Total_Sales
FROM chandoo_sales_data
GROUP BY Sales_Person
ORDER BY Total_Sales DESC
LIMIT 10;


-- ============================================================
-- 13. SALESPEOPLE BY BOXES SHIPPED
-- ============================================================

SELECT
    Sales_Person,
    SUM(Boxes_Shipped) AS Total_Boxes
FROM chandoo_sales_data
GROUP BY Sales_Person
ORDER BY Total_Boxes DESC;


-- ============================================================
-- 14. SALES PER BOX BY SALESPEOPLE
-- ============================================================

SELECT
    Sales_Person,
    ROUND(SUM(Amount), 2) AS Total_Sales,
    SUM(Boxes_Shipped) AS Total_Boxes,
    ROUND(
        SUM(Amount) / NULLIF(SUM(Boxes_Shipped), 0),
        2
    ) AS Sales_Per_Box
FROM chandoo_sales_data
GROUP BY Sales_Person
ORDER BY Sales_Per_Box DESC;


-- ============================================================
-- 15. SALES PER TRANSACTION BY SALESPEOPLE
-- ============================================================

SELECT
    Sales_Person,
    COUNT(*) AS Transactions,
    ROUND(SUM(Amount), 2) AS Total_Sales,
    ROUND(
        SUM(Amount) / COUNT(*),
        2
    ) AS Sales_Per_Transaction
FROM chandoo_sales_data
GROUP BY Sales_Person
ORDER BY Sales_Per_Transaction DESC;


-- ============================================================
-- 16. MONTHLY BOXES SHIPPED
-- ============================================================

SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month_Number,
    MONTHNAME(Date) AS Month,
    SUM(Boxes_Shipped) AS Total_Boxes
FROM chandoo_sales_data
GROUP BY
    YEAR(Date),
    MONTH(Date),
    MONTHNAME(Date)
ORDER BY
    Year,
    Month_Number;


-- ============================================================
-- 17. MONTH-OVER-MONTH BOXES SHIPPED
-- ============================================================

WITH MonthlyBoxes AS (
    SELECT
        YEAR(Date) AS Year,
        MONTH(Date) AS Month_Number,
        MONTHNAME(Date) AS Month,
        SUM(Boxes_Shipped) AS Total_Boxes
    FROM chandoo_sales_data
    GROUP BY
        YEAR(Date),
        MONTH(Date),
        MONTHNAME(Date)
)

SELECT
    Year,
    Month_Number,
    Month,
    Total_Boxes,
    ROUND(
        (
            Total_Boxes -
            LAG(Total_Boxes) OVER (
                ORDER BY Year, Month_Number
            )
        )
        /
        NULLIF(
            LAG(Total_Boxes) OVER (
                ORDER BY Year, Month_Number
            ),
            0
        ) * 100,
        2
    ) AS MoM_Growth_Percent
FROM MonthlyBoxes
ORDER BY
    Year,
    Month_Number;


-- ============================================================
-- 18. CREATE ANALYTICAL VIEW FOR POWER BI
-- ============================================================

CREATE OR REPLACE VIEW sales_analysis_view AS
SELECT
    Sales_Person,
    Country,
    Product,
    Date,
    YEAR(Date) AS Year,
    MONTH(Date) AS Month_Number,
    MONTHNAME(Date) AS Month,
    Amount AS Sales,
    Boxes_Shipped,
    ROUND(
        Amount / NULLIF(Boxes_Shipped, 0),
        2
    ) AS Sales_Per_Box
FROM chandoo_sales_data;


-- ============================================================
-- 19. VERIFY POWER BI VIEW
-- ============================================================

SELECT *
FROM sales_analysis_view
LIMIT 10;