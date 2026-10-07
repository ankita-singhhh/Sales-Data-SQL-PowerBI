# 🍫 Sales Data Analysis & Power BI Dashboard

An end-to-end **Data Analyst portfolio project** using **MySQL 8.0 + SQL + Power BI** to analyze chocolate sales data and build an interactive business dashboard.

**Workflow:** Excel/CSV → MySQL → SQL Cleaning & Analysis → Power BI → Interactive Dashboard

## 🛠️ Tools Used

- MySQL 8.0
- SQL
- Power BI Desktop
- Microsoft Excel / CSV
- Git & GitHub

## 🧠 Skills Demonstrated

### SQL
- Data loading and cleaning
- Date and currency transformation
- `GROUP BY` and aggregate functions
- Window functions
- Month-over-Month analysis
- Analytical SQL views
- Data quality validation

### Power BI
- MySQL data connection
- KPI cards
- Line charts
- Horizontal bar charts
- Donut charts
- Top-N filtering
- Interactive slicers
- Month sorting
- Cross-filtering and dashboard formatting

### Data Analysis
- Sales trend analysis
- Country performance
- Product performance
- Salesperson performance
- Sales-per-box efficiency
- Business insights

---

# 📊 Dataset

The dataset contains **1,094 sales records** covering **January 2022 to August 2022**.

| Metric | Value |
|---|---:|
| Sales Records | 1,094 |
| Total Sales | $6.18M |
| Boxes Shipped | 177,007 |
| Products | 22 |
| Countries | 6 |
| Salespeople | 25 |

Main columns:

| Column | Description |
|---|---|
| `Sales_Person` | Salesperson responsible for the transaction |
| `Country` | Country/market |
| `Product` | Chocolate product |
| `Date` | Transaction date |
| `Amount` | Sales amount |
| `Boxes_Shipped` | Number of boxes shipped |

---

# 🧹 Data Cleaning

The raw data required transformation before analysis.

Key steps:

- Converted text dates such as `4-Jan-22` into MySQL `DATE`.
- Removed `$`, commas, and spaces from sales amounts.
- Converted sales amounts to `DECIMAL(12,2)`.
- Converted `Boxes_Shipped` to integer values.
- Checked row counts and NULL values.
- Created an analytical SQL view for Power BI.

### Analytical View

```sql
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
    ROUND(Amount / NULLIF(Boxes_Shipped, 0), 2) AS Sales_Per_Box
FROM chandoo_sales_data;
```

---

# 💰 Key KPIs

- **Total Sales:** $6.18M
- **Total Boxes:** 177K
- **Total Products:** 22
- **Total Countries:** 6
- **Total Salespeople:** 25

---

# 📈 Monthly Sales Analysis

| Month | Sales | MoM Change |
|---|---:|---:|
| January | $896,105 | — |
| February | $699,377 | -21.95% |
| March | $749,483 | +7.16% |
| April | $674,051 | -10.06% |
| May | $752,892 | +11.70% |
| June | $865,144 | +14.91% |
| July | $803,425 | -7.13% |
| August | $743,148 | -7.50% |

**Insight:** January had the highest monthly sales at approximately $896K. June also performed strongly at approximately $865K. February recorded the largest monthly decline.

---

# 🌍 Sales by Country

| Rank | Country | Sales |
|---:|---|---:|
| 1 | Australia | $1,137,367 |
| 2 | UK | $1,051,792 |
| 3 | India | $1,045,800 |
| 4 | USA | $1,035,349 |
| 5 | Canada | $962,899 |
| 6 | New Zealand | $950,418 |

**Insight:** Australia was the highest-performing country, while New Zealand had the lowest total sales among the six markets.

---

# 🍫 Top 10 Products by Sales

| Rank | Product | Sales |
|---:|---|---:|
| 1 | Smooth Sliky Salty | $349,692 |
| 2 | 50% Dark Bites | $341,712 |
| 3 | White Choc | $329,147 |
| 4 | Peanut Butter Cubes | $324,842 |
| 5 | Eclairs | $312,445 |
| 6 | 99% Dark & Pure | $299,796 |
| 7 | 85% Dark Bars | $299,229 |
| 8 | Organic Choco Syrup | $294,700 |
| 9 | Spicy Special Slims | $293,454 |
| 10 | Mint Chip Choco | $283,969 |

**Insight:** Smooth Sliky Salty was the highest-selling product by revenue.

---

# 📦 Sales-per-Box Analysis

Formula:

```text
Sales per Box = Sales Amount / Boxes Shipped
```

Key findings:

- **Almond Choco:** highest sales per box at approximately **$41.20**
- **White Choc:** approximately **$39.95**
- **70% Dark Bites:** lowest at approximately **$26.40**
- **Rafaelita Blaksland:** highest salesperson sales-per-box efficiency at approximately **$48.93**

This separates **sales volume** from **sales efficiency**.

---

# 👥 Salesperson Analysis

### Top 10 Salespeople by Sales

| Rank | Salesperson | Sales |
|---:|---|---:|
| 1 | Ches Bonnell | $320,901 |
| 2 | Oby Sorrel | $316,645 |
| 3 | Madelene Upcott | $316,099 |
| 4 | Brien Boise | $312,816 |
| 5 | Kelci Walkden | $311,710 |
| 6 | Van Tuxwell | $303,149 |
| 7 | Dennison Crosswaite | $291,669 |
| 8 | Beverie Moffet | $278,922 |
| 9 | Kaine Padly | $266,490 |
| 10 | Marney O'Breen | $259,742 |

Additional findings:

- **Karlen McCaffrey** shipped the most boxes: **9,658**
- **Madelene Upcott** had the highest average sales per transaction: approximately **$7,024.42**

---

# 📊 Power BI Dashboard

The final dashboard contains:

### KPI Cards
- 📊 Total Sales
- 📦 Total Boxes
- ◇ Total Products
- 🌐 Total Countries
- 👥 Total Salespeople

### Visualizations
- 📈 Monthly Sales Trend
- 🌐 Sales by Country
- 📦 Top 10 Products by Sales
- 👥 Top 10 Salespeople by Sales
- 🍩 Top 5 Products — Sales Mix

### Interactive Filters
- Year
- Month
- Country

All slicers dynamically filter the dashboard visuals.

## 🖼️ Dashboard Screenshot

Place the final screenshot at:

```text
Screenshots/dashboard.png
```

Then add:

```markdown
![Sales Performance Dashboard](Screenshots/dashboard.png)
```

---

# ❓ Business Questions Answered

1. What is the total sales generated during the analysis period?
2. How do sales change month over month?
3. Which month generated the highest sales?
4. Which countries generate the highest sales?
5. What are the top 10 products by sales?
6. Which products have the highest sales per box?
7. Who are the top 10 salespeople by sales?
8. Who has the highest sales-per-box efficiency?
9. How many products are represented?
10. How many countries are represented?
11. How many salespeople are represented?
12. How does performance change when filtering by month or country?

---

# 🔎 Key SQL Queries

### Total Sales

```sql
SELECT SUM(Amount) AS Total_Sales
FROM chandoo_sales_data;
```

### Sales by Country

```sql
SELECT
    Country,
    SUM(Amount) AS Total_Sales
FROM chandoo_sales_data
GROUP BY Country
ORDER BY Total_Sales DESC;
```

### Monthly Sales

```sql
SELECT
    MONTH(Date) AS Month_Number,
    MONTHNAME(Date) AS Month,
    SUM(Amount) AS Total_Sales
FROM chandoo_sales_data
GROUP BY MONTH(Date), MONTHNAME(Date)
ORDER BY Month_Number;
```

### Top 10 Products

```sql
SELECT
    Product,
    SUM(Amount) AS Total_Sales
FROM chandoo_sales_data
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 10;
```

### Top 10 Salespeople

```sql
SELECT
    Sales_Person,
    SUM(Amount) AS Total_Sales
FROM chandoo_sales_data
GROUP BY Sales_Person
ORDER BY Total_Sales DESC
LIMIT 10;
```

### Sales per Box

```sql
SELECT
    Product,
    ROUND(SUM(Amount) / NULLIF(SUM(Boxes_Shipped), 0), 2) AS Sales_Per_Box
FROM chandoo_sales_data
GROUP BY Product
ORDER BY Sales_Per_Box DESC;
```

---

# 💡 Business Insights

### 1. Strong overall sales
The business generated approximately **$6.18M** during the eight-month period.

### 2. Monthly fluctuations
Sales varied significantly across months, with the largest decline occurring in February and a strong recovery in June.

### 3. Australia leads the markets
Australia generated approximately **$1.14M**, the highest country-level sales.

### 4. Product concentration
The top products contribute a significant share of sales, with Smooth Sliky Salty ranking first.

### 5. Volume is not the same as efficiency
The salesperson shipping the most boxes is not necessarily the salesperson with the highest sales-per-box efficiency.

---

# 📁 Repository Structure

```text
Sales-Data-SQL-PowerBI/
│
├── README.md
│
├── Data/
│   └── chandoo_sales_data.csv
│
├── SQL/
│   ├── data_quality.sql
│   ├── sales_analysis.sql
│   └── sales_analysis_view.sql
│
├── PowerBI/
│   └── Sales_Performance_Dashboard.pbix
│
└── Screenshots/
    └── dashboard.png
```

---

# 🚀 How to Reproduce

### 1. Create the database

```sql
CREATE DATABASE sales_analysis;
USE sales_analysis;
```

### 2. Create the table

```sql
CREATE TABLE chandoo_sales_data (
    Sales_Person VARCHAR(100),
    Country VARCHAR(50),
    Product VARCHAR(100),
    Date DATE,
    Amount DECIMAL(12,2),
    Boxes_Shipped INT
);
```

### 3. Load and clean the data

Run the SQL scripts in the `SQL` folder.

### 4. Create the analytical view

Use the `sales_analysis_view` query shown above.

### 5. Connect Power BI

Connect Power BI Desktop to:

```text
Server: localhost:3306
Database: sales_analysis
```

Use `sales_analysis_view` as the main Power BI data source.

### 6. Build the dashboard

Create the KPI cards, charts, slicers, and formatting shown in the project.

---

# 🎯 Conclusion

This project demonstrates an end-to-end **Data Analyst workflow**:

**Raw Data → Data Cleaning → SQL Analysis → Power BI Visualization → Interactive Dashboard → Business Insights**

It demonstrates practical skills in **SQL, data cleaning, exploratory analysis, KPI development, dashboard design, and business-oriented reporting**.

---

