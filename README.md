# 🚀 Azure Data Factory — Retail ETL Pipeline


---

## 📺 Demo Video
> 🎬 [Watch the full pipeline demo on YouTube](https://youtu.be/k9bh0fMdX_Y)

---

## 📌 Project Overview

An end-to-end cloud ETL pipeline built on **Microsoft Azure** that ingests live retail product data from a public REST API, applies data cleaning and transformation using **Azure Data Factory Data Flows**, loads the analytics-ready data into **Azure SQL Database**, and visualises insights in **Power BI**.

This project demonstrates real-world data engineering skills including pipeline orchestration, data transformation, cloud storage, automated scheduling, and business intelligence reporting.

---

## 🏗️ Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────────┐
│  Fake Store API  │────▶│  Azure Blob       │────▶│  Azure Data Factory  │
│  (REST API)      │     │  Storage          │     │  Data Flow           │
│  /products       │     │  raw-data/        │     │  (Cleaning Layer)    │
└─────────────────┘     │  products.json    │     └──────────┬──────────┘
                         └──────────────────┘                │
                                                             ▼
                                                  ┌─────────────────────┐
                                                  │  Azure SQL Database  │
                                                  │  dbo.clean_products  │
                                                  └──────────┬──────────┘
                                                             │
                                                             ▼
                                                  ┌─────────────────────┐
                                                  │  Power BI Dashboard  │
                                                  │  (KPIs & Insights)   │
                                                  └─────────────────────┘
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Cloud Platform | Microsoft Azure |
| ETL & Orchestration | Azure Data Factory (ADF) |
| Raw Data Storage | Azure Blob Storage |
| Data Transformation | ADF Data Flow |
| Database | Azure SQL Database |
| Reporting | Power BI Desktop |
| Source API | Fake Store API (REST) |
| Language | T-SQL |
| Version Control | Git / GitHub |

---

## 🔄 Pipeline Breakdown

### 1. Ingestion — Copy Activity
- Connects to Fake Store API via **HTTP Linked Service**
- Pulls raw JSON product data
- Lands raw file into **Azure Blob Storage** (`raw-data/products.json`)

### 2. Transformation — Data Flow (CleanProductsFlow)

| Transformation | Action |
|---|---|
| **Source** | Read raw JSON from Blob Storage |
| **Filter** | Remove rows where `product_id` is null or `price <= 0` |
| **Derived Column** | `trim(title)`, `lower(category)`, flatten `rating.rate` and `rating.count` |
| **Select** | Drop unused columns: `description`, `image`, `rating` (parent) |
| **Sink** | Load clean data into Azure SQL `dbo.clean_products` |

### 3. Destination — Azure SQL Database
```sql
CREATE TABLE clean_products (
    product_id    INT,
    title         VARCHAR(255),
    price         DECIMAL(10,2),
    category      VARCHAR(100),
    rating_score  DECIMAL(3,1),
    rating_count  INT,
    loaded_at     DATETIME DEFAULT GETDATE()
);
```

### 4. Scheduling — Daily Trigger
- Pipeline runs automatically every day at **6:00 AM AEST**
- Built-in ADF monitoring for success/failure alerts

---

## 📊 Data Cleaning Applied

| Issue | Fix Applied |
|---|---|
| Extra whitespace in titles | `trim(title)` |
| Inconsistent category casing | `lower(category)` |
| Nested rating object | Flattened to `rating_score`, `rating_count` |
| Null product IDs | Filtered out via Filter transformation |
| Zero or negative prices | Filtered out via Filter transformation |
| Unused columns (image, description) | Dropped via Select transformation |

---

## 📁 Repository Structure

```
azure-adf-retail-pipeline/
│
├── README.md                          ← Project documentation
├── pipeline/
│   └── FakeStoreETL_Pipeline.json     ← ADF pipeline export
├── sql/
│   └── create_table.sql               ← SQL table creation script
└── screenshots/
    ├── pipeline.png                   ← ADF pipeline canvas
    ├── dataflow.png                   ← Data Flow transformations
    └── sql_results.png                ← Clean data in SQL
```

---

## ⚙️ How to Reproduce This Project

### Prerequisites
- Azure free account (portal.azure.com)
- Power BI Desktop (free)

### Step 1 — Azure Setup
```
1. Create Resource Group: adf-project-rg (Australia East)
2. Create Storage Account with container: raw-data
3. Create Azure SQL Database (free tier): salesdb
4. Create Azure Data Factory V2: aniket-adf
```

### Step 2 — Run SQL Script
```sql
-- Run create_table.sql in Azure SQL Query Editor
```

### Step 3 — Configure ADF
```
1. Create Linked Services: HTTP (API), Blob Storage, Azure SQL
2. Create Datasets: FakeStoreAPI_DS, BlobStorage_DS, AzureSQL_DS
3. Import pipeline from pipeline/FakeStoreETL_Pipeline.json
4. Add Daily Trigger (6:00 AM AEST)
5. Publish All → Trigger Now
```

### Step 4 — Verify
```sql
SELECT * FROM clean_products;
SELECT COUNT(*) FROM clean_products;
SELECT DISTINCT category FROM clean_products;
```

---

## ✅ Key Outcomes

- Built a fully automated cloud ETL pipeline with zero manual intervention
- Achieved clean, validated data with null filtering and text standardisation
- Flattened nested JSON API response into structured relational format
- Scheduled daily pipeline refresh with ADF triggers
- Delivered analytics-ready dataset for Power BI reporting

---

---

## 👨‍💻 Author

**Aniket Solanki**  
Data Analyst | Microsoft PL-300 & AWS Certified  
📍 Parramatta, NSW, Australia  
🔗 [LinkedIn](https://www.linkedin.com/in/aniket-solanki-7618691a6/) | [Portfolio](https://aniketsol.com/)
---

## 📄 License
MIT License — feel free to use this project as a reference.
