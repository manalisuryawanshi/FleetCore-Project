---

# Fleetcor Project - Account Management Impact and Visualization  

## 📌 Executive Summary  

### **1. Write-Off Saving Analysis**  
We analyzed write-off data across different business segments (fuel customers, universal customers, company card, etc.) to identify key cost-reduction strategies, revenue opportunities, and customer retention insights.  

### **Key Findings:**  

#### **Top Factors Affecting Customer Performance:**  
- `WO_AMOUNT`  
- `days_past_due`  
- `Segment_Score`  
- `NSF_AMT`  
- `CREDIT_LIMIT`  

#### **Best-Performing Customers Have:**  
- `days_past_due = 0`  
- `NSF_AMT = 5`  
- `WO_AMOUNT = 60`  
- `CREDIT_LIMIT > 5K`  

### **Model Used:**  
Multi-Variable Linear Regression in **R**  

---


### **2. Attrition Analysis**  
We examined changes in spending, gallons pumped, and revenue across different business segments.  

**Key Factors Identified:**  
- `GALLONS`  
- `FUEL_SPEND`  
- `NONFUEL_SPEND`  
- `TOT_SPEND`  
_(Further analysis in progress)_  

---

### **3. Tableau Dashboard Insights**  

We developed a Tableau dashboard with key visualizations:  

#### **📈 Average Loss Over Time**  
- Fluctuations in average write-off amounts from **Oct 2022 - Aug 2023**  
- Peak write-off amount in **Oct 2022: $12,293.07** → Declined to **$4,286.91 by Feb 2023**  
- After implementing strategies, write-off **dropped sharply to $1,960.49 in June 2023**  

#### **📊 Days Past Due vs. Credit Limit**  
- Customers with **fewer days past due** tend to have **higher credit limits** (good customers)  
- Customers with **more days past due** have **lower credit limits** (high risk)  

#### **📉 Average Segment Score Over Time**  
- **High-risk customers remain stable (~50 score)**  
- **Medium-risk customers show fluctuations but potential improvement**  
- **Low-risk customers are declining**, indicating a shift in risk assessment  

#### **🗺️ Customer NSF Distribution (Map Visualization)**  
- **Texas (TX)** has the **highest count (71,536 customers)** with NSF issues  
- **Other high-risk states:** Georgia (GA), North Carolina (NC), Maryland (MD)  

#### **⛽ Fuel vs. Non-Fuel Spend Analysis**  
- **Avg. fuel spend rarely exceeds $1000**  
- **Avg. non-fuel spend peaks at $10,000 but drops sharply** → Indicates many accounts locked due to non-payment  

---

## 🛠️ Data Processing & Modeling  

### **🔹 Data Cleaning & Preparation**  
1. Cleaned and modified raw data  
2. Stored processed data in **SQL Server database**  
3. Created **Entity-Relationship Diagram (ERD)**  

### **🔹 Data Modeling (SQL Queries & Views)**  
1. Created database **views** for structured analysis  
2. Executed queries to extract key insights  

### **🔹 Data Consolidation**  
1. Selected random sample (due to large dataset size)  
2. Removed null records  
3. Saved processed data in **CSV format**  

---

## 📌 Technologies Used  

- **Python** (Data Processing)  
- **R** (Multi-Variable Linear Regression)  
- **SQL Server** (Database Storage & Queries)  
- **Tableau** (Data Visualization)  

---

## 🚀 Future Enhancements  

- Optimize machine learning model for attrition prediction  
- Implement automated alerts for high-risk customers  
- Explore additional segmentation techniques for better risk assessment  

---

