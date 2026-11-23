# 🚢 OceanLink Global Logistics & Port Operations Analytics

End-to-end analytics project that turns 10 raw Excel files (126,000+ rows) into one trusted view of shipments, ports, carriers and costs, using **Python, SQL Server, Power BI and Tableau**.

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=tableau&logoColor=white)

---

## 📌 Business Problem
OceanLink Global Logistics Pvt. Ltd. had no single source of truth. The business faced:
- Shipment delays and no visibility of on-time performance
- Limited visibility of port congestion
- Unknown warehouse utilization
- No carrier performance comparison
- Rising logistics and customs costs
- Customs clearance delays
- Manual reporting and no centralized KPIs

## 🎯 Objectives
1. Clean and validate the 10 source datasets
2. Load them into SQL Server (`GlobalLogisticsDB`) with primary and foreign keys
3. Calculate the business KPIs in SQL
4. Build 6 Power BI report pages and 5 Tableau dashboards
5. Document the method, assumptions and insights

## 🏗 Architecture
```
Excel (10 raw files)
   → Python / Pandas (profile, clean, reconcile)
   → Cleaned Dim_ / Fact_ tables (star schema)
   → SQL Server (PK/FK, validation checks, KPI queries, 9 views)
   → Power BI (Import mode, DAX, 6 pages)
   → Tableau (5 dashboards on CSV exports of the views)
```

## 🧹 Data Cleaning Highlights
- Removed **282 duplicate rows** (shipments, costs, customs, tracking events)
- Fixed 21 invalid shipment dates (left NULL, not guessed)
- Standardised 64 status text variants into 5 clean values
- Derived 18 missing statuses from dates and the latest tracking event
- Imputed 72 missing weights using the median of the same container type (flagged)
- Reconciled 41 missing customs fees against the cost table
- Added 17 ports missing from the port master so foreign keys could be created
- Every removed row is kept in an audit file

## 🗄 SQL Server Database
- 10 tables with primary and foreign keys
- Validation checks for duplicates, orphan rows, negative costs and status/date contradictions
- **12 analytical queries** (window functions, month-over-month growth, route and carrier ranking)
- **9 reporting views** that feed Power BI so dashboards never touch raw tables

## 📊 Key KPIs
| KPI | Result |
|---|---|
| Total Shipments | 20,000 |
| On-Time Delivery % | 84.75% |
| Shipment Delay % | 15.25% |
| Average Transit Time | 21.14 days |
| Port Congestion Rate | 6.70% |
| Container Utilization % | 59.80% |
| Carrier SLA Compliance | 80.1% to 87.5% |
| Avg Transportation Cost per Shipment | 36,222 |
| Total Logistics Cost | 3.74 billion |
| Customs Clearance Time | 19.64 days |
| Delivery Success Rate | 68.21% |

Warehouse utilization was **not computed** because no transaction table carries a Warehouse_ID. It was reported as a data gap rather than invented.

## 📈 Dashboards

### Power BI (6 pages)
Executive Overview · Shipment Performance · Port Operations · Warehouse Performance · Carrier Performance · Cost Analysis

### Tableau (5 dashboards)
Executive Summary · Global Port Performance · Shipment Delay Analysis · Route Performance Analysis · Executive Recommendations

> 📷 Add dashboard screenshots here, e.g. `![Executive Overview](images/powerbi_executive_overview.png)`

## 💡 Key Insights
- **Customs is the biggest driver of delay and cost.** Held shipments are late 77% of the time (pending 95%), and customs fees make up about 76.5% of total logistics cost.
- **Savannah has the highest port congestion** at 15.7% of calls delayed, against 6.7% for the network. Jebel Ali, Antwerp-Bruges and Vancouver follow.
- **Carrier performance varies**: on-time rates range from 80.1% (CMA CGM) to 87.5% (Seaboard Marine).
- **Highest inbound delay**: Mundra (20.9%), Ho Chi Minh City (20.5%) and Vancouver (19.3%).
- **1,888 shipments (9.4%)** were handled by suspended carriers.
- **3,996 In Transit and 2,038 Booked shipments** are past their planned dates, which points to stale status updates.

## ✅ Recommendations
1. Pre-clear customs documents and escalate holds older than 5 days
2. Focus cost savings on duties and fees rather than freight rates
3. Run improvement plans for weak carriers or shift volume to strong ones
4. Add buffer days and review berth slots at congested ports
5. Block bookings for suspended carriers
6. Automate status closure from tracking events
7. Add validation at data entry and add Warehouse_ID to shipment and cost records

## ⚠️ Assumptions & Limitations
- On-time means delivered within 4 days of the expected date, based on the pattern in the data
- 5,048 customs clearance dates fall after delivery; kept and flagged for business confirmation
- Currency is not stated in the source, so costs are treated as plain numbers
- Power BI shows 84.77% on-time against 84.75% in SQL because of a small difference in the delivered base
- The Tableau source holds 12,967 delivered and delayed shipments, so counts differ from Power BI's 20,000, while percentages match

## 📁 Repository Structure
```
OceanLink-Logistics-Analytics/
├── data/            # raw and cleaned files
├── python/          # cleaning notebooks
├── sql/             # schema, validation checks, KPI queries, views
├── powerbi/         # .pbix file
├── tableau/         # .twbx file
├── images/          # dashboard screenshots
├── reports/         # data quality report, project documentation PDF
└── README.md
```
*(Adjust the folder names to match your repository.)*

## 🛠 Tools Used
Python (Pandas, Jupyter) · SQL Server & SSMS · Power BI Desktop (DAX) · Tableau

## 👤 Author
**Battu Rahul Sai**
🌐 [Portfolio](https://rahul20052005.github.io) · 💼 [LinkedIn](YOUR_LINKEDIN_URL) · 💻 [GitHub](https://github.com/RAHUL20052005)
