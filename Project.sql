CREATE DATABASE GlobalLogisticsDB

USE GlobalLogisticsDB

SELECT * FROM Shipment_Details 


ALTER TABLE Port_Master       ALTER COLUMN Port_ID       NVARCHAR(50) NOT NULL
ALTER TABLE Carrier_Master    ALTER COLUMN Carrier_ID    NVARCHAR(50) NOT NULL
ALTER TABLE Customer_Master   ALTER COLUMN Customer_ID   NVARCHAR(50) NOT NULL
ALTER TABLE Container_Master  ALTER COLUMN Container_ID  NVARCHAR(50) NOT NULL
ALTER TABLE Warehouse_Master  ALTER COLUMN Warehouse_ID  NVARCHAR(50) NOT NULL
ALTER TABLE Shipment_Details  ALTER COLUMN Shipment_ID   NVARCHAR(50) NOT NULL
ALTER TABLE Customs_Clearance ALTER COLUMN Clearance_ID  NVARCHAR(50) NOT NULL
ALTER TABLE Customs_Clearance ALTER COLUMN Shipment_ID   NVARCHAR(50) NOT NULL
ALTER TABLE Cost_Analysis     ALTER COLUMN Cost_ID       NVARCHAR(50) NOT NULL
ALTER TABLE Cost_Analysis     ALTER COLUMN Shipment_ID   NVARCHAR(50) NOT NULL
ALTER TABLE Delivery_Tracking ALTER COLUMN Tracking_ID   NVARCHAR(50) NOT NULL
ALTER TABLE Delivery_Tracking ALTER COLUMN Shipment_ID   NVARCHAR(50) NOT NULL

SELECT * FROM Vessel_Schedule

ALTER TABLE shipment_Details ALTER COLUMN Customer_ID NVARCHAR(50) 
ALTER TABLE shipment_Details ALTER COLUMN Container_ID NVARCHAR(50)
ALTER TABLE shipment_Details ALTER COLUMN Carrier_ID NVARCHAR(50) 
ALTER TABLE shipment_Details ALTER COLUMN Origin_Port_ID NVARCHAR(50)
ALTER TABLE shipment_Details ALTER COLUMN Destination_Port_ID NVARCHAR(50) 
ALTER TABLE Vessel_Schedule ALTER COLUMN Carrier_ID NVARCHAR(50)
ALTER TABLE Vessel_Schedule  ALTER COLUMN Origin_Port_ID      NVARCHAR(50)
ALTER TABLE Vessel_Schedule  ALTER COLUMN Destination_Port_ID NVARCHAR(50)


ALTER TABLE Port_Master       ADD CONSTRAINT pk_port      PRIMARY KEY (Port_ID)
ALTER TABLE Carrier_Master    ADD CONSTRAINT pk_carrier   PRIMARY KEY (Carrier_ID)
ALTER TABLE Customer_Master   ADD CONSTRAINT pk_customer  PRIMARY KEY (Customer_ID)
ALTER TABLE Container_Master  ADD CONSTRAINT pk_container PRIMARY KEY (Container_ID)
ALTER TABLE Warehouse_Master  ADD CONSTRAINT pk_warehouse PRIMARY KEY (Warehouse_ID)
ALTER TABLE Shipment_Details  ADD CONSTRAINT pk_shipment  PRIMARY KEY (Shipment_ID)
ALTER TABLE Customs_Clearance ADD CONSTRAINT pk_customs   PRIMARY KEY (Clearance_ID)
ALTER TABLE Cost_Analysis     ADD CONSTRAINT pk_cost      PRIMARY KEY (Cost_ID)
ALTER TABLE Delivery_Tracking ADD CONSTRAINT pk_tracking  PRIMARY KEY (Tracking_ID)
ALTER TABLE Customs_Clearance ADD CONSTRAINT uq_customs_ship UNIQUE (Shipment_ID)
ALTER TABLE Cost_Analysis     ADD CONSTRAINT uq_cost_ship    UNIQUE (Shipment_ID)



SELECT 
    t.name AS Table_Name,
    k.name AS Constraint_Name,
    k.type_desc AS Constraint_Type
FROM sys.key_constraints k
JOIN sys.tables t ON k.parent_object_id = t.object_id
ORDER BY t.name;


ALTER TABLE Shipment_Details  ADD CONSTRAINT fk_ship_customer  FOREIGN KEY (Customer_ID)         REFERENCES Customer_Master(Customer_ID);
ALTER TABLE Shipment_Details  ADD CONSTRAINT fk_ship_container FOREIGN KEY (Container_ID)        REFERENCES Container_Master(Container_ID);
ALTER TABLE Shipment_Details  ADD CONSTRAINT fk_ship_carrier   FOREIGN KEY (Carrier_ID)          REFERENCES Carrier_Master(Carrier_ID);
ALTER TABLE Shipment_Details  ADD CONSTRAINT fk_ship_origin    FOREIGN KEY (Origin_Port_ID)      REFERENCES Port_Master(Port_ID);
ALTER TABLE Shipment_Details  ADD CONSTRAINT fk_ship_dest      FOREIGN KEY (Destination_Port_ID) REFERENCES Port_Master(Port_ID);
ALTER TABLE Customs_Clearance ADD CONSTRAINT fk_customs_ship   FOREIGN KEY (Shipment_ID)         REFERENCES Shipment_Details(Shipment_ID);
ALTER TABLE Cost_Analysis     ADD CONSTRAINT fk_cost_ship      FOREIGN KEY (Shipment_ID)         REFERENCES Shipment_Details(Shipment_ID);
ALTER TABLE Delivery_Tracking ADD CONSTRAINT fk_track_ship     FOREIGN KEY (Shipment_ID)         REFERENCES Shipment_Details(Shipment_ID);
ALTER TABLE Vessel_Schedule   ADD CONSTRAINT fk_vessel_carrier FOREIGN KEY (Carrier_ID)          REFERENCES Carrier_Master(Carrier_ID);
ALTER TABLE Vessel_Schedule   ADD CONSTRAINT fk_vessel_origin  FOREIGN KEY (Origin_Port_ID)      REFERENCES Port_Master(Port_ID);
ALTER TABLE Vessel_Schedule   ADD CONSTRAINT fk_vessel_dest    FOREIGN KEY (Destination_Port_ID) REFERENCES Port_Master(Port_ID);

SELECT DISTINCT Port_ID FROM (
    SELECT Origin_Port_ID AS Port_ID FROM Shipment_Details
    UNION SELECT Destination_Port_ID FROM Shipment_Details
    UNION SELECT Origin_Port_ID FROM Vessel_Schedule
    UNION SELECT Destination_Port_ID FROM Vessel_Schedule
) x
WHERE Port_ID NOT IN (SELECT Port_ID FROM Port_Master)
ORDER BY Port_ID;

UPDATE Port_Master SET Port_ID = 'VNHCM' WHERE Port_ID = 'VNSGN';   -- Ho Chi Minh City
UPDATE Port_Master SET Port_ID = 'SADMM' WHERE Port_ID = 'SARUH';   -- Dammam

INSERT INTO Port_Master (Port_ID, Port_Name, Country, Port_Type, Port_Status) VALUES
('AUSYD','Port of Sydney (Botany)','Australia','Seaport','Active'),
('CNQDG','Port of Qingdao','China','Seaport','Active'),
('CNXMN','Port of Xiamen','China','Seaport','Active'),
('COCTG','Port of Cartagena','Colombia','Seaport','Active'),
('EGALY','Port of Alexandria','Egypt','Seaport','Active'),
('ESVLC','Port of Valencia','Spain','Seaport','Active'),
('IDJKT','Port of Tanjung Priok (Jakarta)','Indonesia','Seaport','Active'),
('JPTYO','Port of Tokyo','Japan','Seaport','Active'),
('JPYOK','Port of Yokohama','Japan','Seaport','Active'),
('KRINC','Port of Incheon','South Korea','Seaport','Active'),
('MXVER','Port of Veracruz','Mexico','Seaport','Active'),
('MYTPP','Port of Tanjung Pelepas','Malaysia','Seaport','Active'),
('PHMNL','Port of Manila','Philippines','Seaport','Active'),
('QADOH','Hamad Port (Doha)','Qatar','Seaport','Active'),
('SADMJ','King Abdulaziz Port (Dammam)','Saudi Arabia','Seaport','Active'),
('TWKHH','Port of Kaohsiung','Taiwan','Seaport','Active'),
('USHOU','Port of Houston','United States','Seaport','Active'),
('USSAV','Port of Savannah','United States','Seaport','Active'),
('VNHCP','Port of Ho Chi Minh City','Vietnam','Seaport','Active');

SELECT * FROM Port_Master WHERE Port_ID IN ('VNSGN','SARUH');

SELECT * FROM Port_Master

ALTER TABLE Shipment_Details ADD CONSTRAINT fk_ship_origin FOREIGN KEY (Origin_Port_ID)      REFERENCES Port_Master(Port_ID);
ALTER TABLE Shipment_Details ADD CONSTRAINT fk_ship_dest   FOREIGN KEY (Destination_Port_ID) REFERENCES Port_Master(Port_ID);
ALTER TABLE Vessel_Schedule  ADD CONSTRAINT fk_vessel_origin FOREIGN KEY (Origin_Port_ID)      REFERENCES Port_Master(Port_ID);
ALTER TABLE Vessel_Schedule  ADD CONSTRAINT fk_vessel_dest   FOREIGN KEY (Destination_Port_ID) REFERENCES Port_Master(Port_ID);

SELECT * FROM Shipment_Details

SELECT 'Duplicate Shipment_ID' AS check_name, COUNT(*) - COUNT(DISTINCT Shipment_ID) AS violations FROM Shipment_Details
UNION ALL SELECT 'Duplicate Shipment_ID in Cost',    COUNT(*) - COUNT(DISTINCT Shipment_ID) FROM Cost_Analysis
UNION ALL SELECT 'Duplicate Shipment_ID in Customs', COUNT(*) - COUNT(DISTINCT Shipment_ID) FROM Customs_Clearance
UNION ALL SELECT 'Shipment without cost record',     COUNT(*) FROM Shipment_Details s LEFT JOIN Cost_Analysis c ON s.Shipment_ID = c.Shipment_ID WHERE c.Shipment_ID IS NULL
UNION ALL SELECT 'Shipment without customs record',  COUNT(*) FROM Shipment_Details s LEFT JOIN Customs_Clearance c ON s.Shipment_ID = c.Shipment_ID WHERE c.Shipment_ID IS NULL
UNION ALL SELECT 'Negative or zero weight',          COUNT(*) FROM Shipment_Details WHERE Shipment_Weight <= 0
UNION ALL SELECT 'Negative cost value',              COUNT(*) FROM Cost_Analysis WHERE Transportation_Cost < 0 OR Warehouse_Cost < 0 OR Customs_Cost < 0 OR Total_Logistics_Cost < 0
UNION ALL SELECT 'Total cost <> sum of parts',       COUNT(*) FROM Cost_Analysis WHERE ABS(Transportation_Cost + Warehouse_Cost + Customs_Cost - Total_Logistics_Cost) > 0.02
UNION ALL SELECT 'Expected_Delivery_Date before shipment', COUNT(*) FROM Shipment_Details WHERE Planned_Delivery_Date < Shipment_Date
UNION ALL SELECT 'Actual delivery before shipment',  COUNT(*) FROM Shipment_Details WHERE Actual_Delivery_Date < Shipment_Date
UNION ALL SELECT 'Delivered/Delayed with no actual date', COUNT(*) FROM Shipment_Details WHERE Shipment_Status IN ('Delivered','Delayed') AND Actual_Delivery_Date IS NULL
UNION ALL SELECT 'Booked/In Transit/Cancelled with actual date', COUNT(*) FROM Shipment_Details WHERE Shipment_Status IN ('Booked','In Transit','Cancelled') AND Actual_Delivery_Date IS NOT NULL
UNION ALL SELECT 'Status outside allowed list',      COUNT(*) FROM Shipment_Details WHERE Shipment_Status NOT IN ('Booked','In Transit','Delivered','Delayed','Cancelled') OR Shipment_Status IS NULL
UNION ALL SELECT 'Arrival before departure (voyage)', COUNT(*) FROM Vessel_Schedule WHERE Arrival_Date < Departure_Date;

EXEC sp_readerrorlog 0, 1, 'GlobalLogisticsDB';

SELECT name, state_desc FROM sys.databases WHERE name = 'GlobalLogisticsDB';

EXEC sp_readerrorlog 0, 1, 'memory';
EXEC sp_readerrorlog 0, 1, 'operating system error';

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Shipment_Details'
ORDER BY ORDINAL_POSITION;


--duplicates and values
SELECT COUNT(*) - COUNT(DISTINCT Shipment_ID) AS dup_shipments FROM Shipment_Details

SELECT COUNT(*) - COUNT(DISTINCT Shipment_ID) AS dup_cost      FROM Cost_Analysis

SELECT COUNT(*) - COUNT(DISTINCT Shipment_ID) AS dup_customs    FROM Customs_Clearance

SELECT COUNT(*) AS bad_weight FROM Shipment_Details WHERE Shipment_Weight <= 0

SELECT COUNT(*) AS negative_cost FROM Cost_Analysis

WHERE Transportation_Cost < 0 OR Warehouse_Cost < 0 OR Customs_Cost < 0 OR Total_Logistics_Cost < 0

SELECT COUNT(*) AS total_mismatch FROM Cost_Analysis

WHERE ABS(Transportation_Cost + Warehouse_Cost + Customs_Cost - Total_Logistics_Cost) > 0.02

--dates and status
SELECT * FROM Shipment_Details

SELECT COUNT(*) AS Expected_Delivery_Date 
FROM Shipment_Details
WHERE Expected_Delivery_Date < Shipment_Date

SELECT COUNT(*) AS ACTUAL_SHIPMENTS
FROM Shipment_Details
WHERE Actual_Delivery_Date < Shipment_Date

SELECT COUNT(*) AS delivered_no_date FROM Shipment_Details
WHERE Shipment_Status IN ('Delivered','Delayed') AND Actual_Delivery_Date IS NULL


SELECT COUNT(*) AS Delivered_Shipments
FROM Shipment_Details
WHERE Shipment_Status IN ('Delivered')

SELECT * FROM Shipment_Details

SELECT COUNT(*) AS OPEN_WITH_DATE
FROM Shipment_Details
WHERE Shipment_Status IN ('Delivered','In Transit','Booked')
AND Actual_Delivery_Date IS NOT NULL

SELECT Shipment_Status,COUNT(*) AS COUNT_ 
FROM Shipment_Details 
GROUP BY Shipment_status

SELECT COUNT(*) AS no_cost FROM Shipment_Details s
WHERE NOT EXISTS (SELECT 1 FROM Cost_Analysis c WHERE c.Shipment_ID = s.Shipment_ID)

SELECT COUNT(*) AS no_customs FROM Shipment_Details s
WHERE NOT EXISTS (SELECT 1 FROM Customs_Clearance c WHERE c.Shipment_ID = s.Shipment_ID)

--business KPIs
--Total Shipments 

SELECT * FROM Shipment_Details

SELECT COUNT(Shipment_ID)
FROM Shipment_Details

--On-Time Delivery Percentage 
SELECT COUNT(*) AS Delivered,
ROUND(100*SUM(CASE WHEN DATEDIFF(day,Expected_Delivery_Date,Actual_Delivery_Date) <= 4 THEN 1 ELSE 0 END) /COUNT(*),2) AS On_Time_Delivery
FROM Shipment_Details
WHERE Shipment_Status IN ('Delivered','Delayed') 
AND Actual_Delivery_Date IS NOT NULL

--Shipment Delay Percentage 
SELECT COUNT(*) AS Delivered,
ROUND(100*SUM(CASE WHEN DATEDIFF(day,Expected_Delivery_Date,Actual_Delivery_Date) > 4 THEN 1 ELSE 0 END) /COUNT(*),2) AS On_Time_Delivery
FROM Shipment_Details
WHERE Shipment_Status IN ('Delivered','Delayed') 
AND Actual_Delivery_Date IS NOT NULL

--Average Transit Time 
SELECT COUNT(*) AS DELIVERED,
ROUND(AVG(CAST(DATEDIFF(day,Shipment_Date,Actual_Delivery_Date) as FLOAT)),2) AS Average_Transit_Time
FROM Shipment_Details
WHERE Shipment_Status IN ('Delivered','Delayed') 
AND Actual_Delivery_Date IS NOT NULL


 --Port Congestion Rate
SELECT p.Port_Name, COUNT(*) AS vessel_calls,
       SUM(CASE WHEN v.Vessel_Status = 'Delayed' THEN 1 ELSE 0 END) AS delayed_calls,
       ROUND(100.0 * SUM(CASE WHEN v.Vessel_Status = 'Delayed' THEN 1 ELSE 0 END) / COUNT(*), 2) AS congestion_rate_pct
FROM Vessel_Schedule v
JOIN Port_Master p ON p.Port_ID = v.Destination_Port_ID
WHERE v.Vessel_Status IN ('Arrived','Departed','Delayed')
GROUP BY p.Port_Name
ORDER BY congestion_rate_pct DESC

--Container Utilization  Percentage 
SELECT * FROM Container_Master

SELECT ROUND(100*SUM(CASE WHEN Container_Status IN ('Loaded','In Transit','Reserved') THEN 1 ELSE 0 END)/COUNT(*),2) AS container_utilization
FROM Container_Master

--Carrier SLA Compliance Percentage 
SELECT * FROM Carrier_Master
SELECT * FROM Shipment_Details

SELECT 
c.Carrier_Name, COUNT(*) AS delivered,
ROUND(100.0 * SUM(CASE WHEN DATEDIFF(day, s.Expected_Delivery_Date, s.Actual_Delivery_Date) <= 4 THEN 1 ELSE 0 END) / COUNT(*), 2) AS sla_compliance_pct
FROM Shipment_Details s
JOIN Carrier_Master c ON c.Carrier_ID = s.Carrier_ID
WHERE s.Shipment_Status IN ('Delivered','Delayed') AND s.Actual_Delivery_Date IS NOT NULL
GROUP BY c.Carrier_Name
ORDER BY sla_compliance_pct DESC

--Transportation Cost per Shipment 
SELECT * FROM Cost_Analysis

SELECT 
ROUND(AVG(Transportation_Cost),2) AS Transportation_Cost_per_Shipment
FROM Cost_Analysis

--Total Logistics Cost 
SELECT  
ROUND(SUM(Total_Logistics_Cost),2) asTotal_Logistics_Cost
FROM Cost_Analysis

--Customs Clearance Time 
SELECT * FROM Customs_Clearance

SELECT 
ROUND(AVG(CAST(DATEDIFF(day,b.Shipment_Date,a.Clearance_date) AS FLOAT )),2) AS Customs_Clearance_Time
FROM Customs_Clearance a
INNER JOIN Shipment_Details b
ON a.Shipment_ID = b.Shipment_ID
WHERE a.Clearance_Status IN ('Cleared') 
AND a.Clearance_Date IS NOT NULL


--Delivery Success Rate 
SELECT * FROM Shipment_Details

SELECT 
ROUND(100* SUM(CASE WHEN Shipment_Status IN ('Delivered','Delayed') AND Actual_Delivery_Date IS NOT NULL THEN 1 ELSE 0 END) /
SUM(CASE WHEN Shipment_Status <> 'Cancelled' THEN 1 ELSE 0 END),2) AS Delivery_Success_Rate 
FROM Shipment_Details

--Analytical queries
--Shipments by status
SELECT * FROM Shipment_Details
SELECT * FROM Cost_Analysis

SELECT
Shipment_Status,
COUNT(*) AS COUNT_
FROM Shipment_Details
GROUP BY Shipment_Status

--Shipments per month
WITH CTE AS 
(
SELECT 
FORMAT(Shipment_Date,'yyyy-MM') AS MONTH_,
COUNT(*) AS TOTAL_COUNT
FROM Shipment_Details
WHERE Shipment_Date IS  NOT NULL
GROUP BY FORMAT(Shipment_Date,'yyyy-MM')
)
SELECT 
MONTH_,
TOTAL_COUNT 
FROM CTE

--Total cost split
SELECT * FROM Cost_Analysis

SELECT 
ROUND(SUM(Transportation_Cost),2) AS Transportation_Cost,
ROUND(SUM(Warehouse_Cost),2) AS Warehouse_Cost,
ROUND(SUM(Customs_Cost),2) AS Customs_Cost,
ROUND(SUM(Total_Logistics_Cost),2) AS Total_Logistics_cost
FROM Cost_Analysis 

--Top 10 customers by cost
SELECT * FROM Shipment_Details
SELECT * FROM Cost_Analysis

SELECT 
TOP  10
a.Customer_ID,
SUM(b.Total_Logistics_Cost) AS TOTAL_COST
FROM Shipment_Details a
INNER JOIN Cost_Analysis b
ON a.Shipment_ID = b.Shipment_ID
GROUP BY a.Customer_ID
ORDER BY SUM(b.Total_Logistics_Cost) DESC

--Late shipments by customs status
SELECT * FROM Customs_Clearance
SELECT * FROM Shipment_Details

SELECT 
b.Clearance_Status,
COUNT(*) AS DELIVERIES,
SUM(CASE WHEN DATEDIFF(day,a.Expected_Delivery_Date,a.Actual_Delivery_Date) > 4 THEN 1 ELSE 0 END) AS Late_Shipments
FROM Shipment_Details a 
JOIN Customs_Clearance b
ON a.Shipment_ID = b.Shipment_ID
WHERE a.Actual_DElivery_Date IS NOT NULL
GROUP BY b.Clearance_Status

--Routes with the most late shipments
SELECT * FROM Shipment_Details

SELECT 
Origin_Port_ID,
Destination_Port_ID,
COUNT(*) AS DELIVERED,
SUM(CASE WHEN DATEDIFF(day,Expected_Delivery_Date,Actual_Delivery_Date) > 4 THEN 1 ELSE 0 END) AS Late_Shipments
FROM Shipment_Details 
WHERE Actual_Delivery_Date IS NOT NULL
GROUP BY Origin_Port_ID,Destination_Port_ID
ORDER BY Late_Shipments DESC

--Customs status count
SELECT * FROM Customs_Clearance

SELECT 
Clearance_Status,
COUNT(*) AS Status_
FROM Customs_Clearance
GROUP BY Clearance_Status

--Shipments by carrier service status
SELECT * FROM Shipment_Details
SELECT * FROM Carrier_Master

SELECT 
b.Service_Status,
COUNT(*)
FROM Shipment_Details a
JOIN Carrier_Master b
ON a.Carrier_ID = b.Carrier_ID 
GROUP BY b.Service_Status

--Views for the dashboards

SELECT * FROM Port_Master

CREATE VIEW VW_Shipments AS
SELECT
a.Shipment_ID,
a.Shipment_Date,
YEAR(a.Shipment_Date) AS Ship_Year,
MONTH(a.Shipment_Date) AS Ship_Month,
a.Shipment_Status,
a.Actual_Delivery_Date,
DATEDIFF(day,a.Shipment_Date,a.Actual_Delivery_Date) AS Transition_Days,
DATEDIFF(day,a.Expected_Delivery_Date,a.Actual_Delivery_Date) AS Delay_Days,
CASE WHEN DATEDIFF(day,a.Expected_Delivery_Date,a.Actual_Delivery_Date) <= 4 THEN 1 ELSE 0 END AS ON_TIME_DELIVERY,
CASE WHEN DATEDIFF(day,a.Expected_Delivery_Date,a.Actual_Delivery_Date) > 4 THEN 1 ELSE 0 END AS LATE_DELIVERY,
CASE WHEN a.Actual_Delivery_Date IS NOT NULL THEN 1 ELSE 0 END AS DELIVERED,
b.Carrier_Name,
h.Customer_Name,
c.Port_Name AS Origin_Port,
cd.Port_Name AS Destination_Port,
c.Country,
e.Transportation_Cost,
e.Warehouse_Cost,
e.Customs_Cost,
e.Total_Logistics_Cost,
f.Clearance_status,
DATEDIFF(day,f.Clearance_Date,a.Shipment_Date) AS Clearance_days
FROM Shipment_Details a
JOIN Carrier_Master b
ON a.Carrier_ID = b.Carrier_ID
JOIN Customer_Master h
ON h.Customer_ID = a.Customer_ID
JOIN Port_Master c
ON c.Port_ID = a.Origin_Port_ID
JOIN Port_Master cd
ON cd.Port_ID  = a.Destination_Port_ID
LEFT JOIN Cost_Analysis e       
ON e.Shipment_ID  = a.Shipment_ID
LEFT JOIN Customs_Clearance f
ON f.Shipment_ID = a.Shipment_ID

SELECT COUNT(*) FROM vw_shipments     
SELECT TOP 5 * FROM vw_shipments


--monthly trend
CREATE VIEW vw_monthly AS
SELECT Ship_Year, Ship_Month,
       COUNT(*)                      AS Total_Shipments,
       SUM(DELIVERED)             AS Delivered_Shipments,
       SUM(LATE_DELIVERY)                  AS Late_Shipments,
       AVG(Transition_Days * 1.0)       AS Avg_Transit_Days,
       SUM(Total_Logistics_Cost)     AS Total_Cost
FROM vw_shipments
WHERE Ship_Year IS NOT NULL
GROUP BY Ship_Year, Ship_Month

--KPI summary
CREATE VIEW vw_kpi_summary AS
SELECT COUNT(*)                        AS Total_Shipments,
       SUM(DELIVERED)               AS Delivered_Shipments,
       100.0 * SUM(ON_TIME_DELIVERY) / SUM(DELIVERED) AS On_Time_Pct,
       100.0 * SUM(LATE_DELIVERY)    / SUM(DELIVERED) AS Delay_Pct,
       AVG(Transition_Days * 1.0)         AS Avg_Transit_Days,
       SUM(Total_Logistics_Cost)       AS Total_Logistics_Cost,
       AVG(Transportation_Cost)        AS Transport_Cost_Per_Shipment
FROM vw_shipments

--carriers
CREATE VIEW vw_carriers AS
SELECT Carrier_Name,
       COUNT(*)                AS Total_Shipments,
       SUM(DELIVERED)       AS Delivered_Shipments,
       SUM(ON_TIME_DELIVERY)         AS On_Time_Shipments,
       SUM(LATE_DELIVERY)            AS Late_Shipments,
       AVG(Transition_Days * 1.0) AS Avg_Transit_Days,
       AVG(Transportation_Cost) AS Avg_Transport_Cost
FROM vw_shipments
GROUP BY Carrier_Name

--routes
CREATE VIEW vw_routes AS
SELECT Origin_Port, Destination_Port,
       COUNT(*)                AS Total_Shipments,
       SUM(DELIVERED)       AS Delivered_Shipments,
       SUM(LATE_DELIVERY)            AS Late_Shipments,
       AVG(Transition_Days * 1.0) AS Avg_Transit_Days,
       AVG(Total_Logistics_Cost) AS Avg_Total_Cost
FROM vw_shipments
GROUP BY Origin_Port, Destination_Port

--port traffic
CREATE VIEW vw_port_traffic AS
SELECT Destination_Port, Country,
       COUNT(*)          AS Inbound_Shipments,
       SUM(DELIVERED) AS Delivered_Shipments,
       SUM(LATE_DELIVERY)      AS Late_Shipments
FROM vw_shipments
GROUP BY Destination_Port,Country

--port congestion
CREATE VIEW vw_port_congestion AS
SELECT p.Port_Name, p.Country,
       COUNT(*) AS Vessel_Calls,
       SUM(CASE WHEN v.Vessel_Status = 'Delayed' THEN 1 ELSE 0 END) AS Delayed_Calls
FROM Vessel_Schedule v
JOIN Port_Master p ON p.Port_ID = v.Destination_Port_ID
WHERE v.Vessel_Status IN ('Arrived', 'Departed', 'Delayed')
GROUP BY p.Port_Name, p.Country

--costs by month
CREATE VIEW vw_costs AS
SELECT Ship_Year, Ship_Month,
       SUM(Transportation_Cost) AS Transportation_Cost,
       SUM(Warehouse_Cost)      AS Warehouse_Cost,
       SUM(Customs_Cost)        AS Customs_Cost,
       SUM(Total_Logistics_Cost) AS Total_Cost
FROM vw_shipments
WHERE Ship_Year IS NOT NULL
GROUP BY Ship_Year, Ship_Month

--customs
CREATE VIEW vw_customs AS
SELECT Clearance_Status,
       COUNT(*)                 AS Clearances,
       SUM(DELIVERED)        AS Delivered_Shipments,
       SUM(LATE_DELIVERY)             AS Late_Shipments,
       AVG(Clearance_Days * 1.0) AS Avg_Clearance_Days
FROM vw_shipments
WHERE Clearance_Status IS NOT NULL
GROUP BY Clearance_Status

SELECT Shipment_ID, Actual_Delivery_Date FROM Shipment_Details WHERE Shipment_Status IS NULL;

UPDATE Shipment_Details SET Shipment_Status = 'Delivered'  WHERE Shipment_Status IS NULL AND Actual_Delivery_Date IS NOT NULL
UPDATE Shipment_Details SET Shipment_Status = 'In Transit' WHERE Shipment_Status IS NULL AND Actual_Delivery_Date IS NULL

--TRANSPOTING THE VIEWS INTO CSV FILES TO IMPORT INTO TABLEAU
SELECT * FROM vw_shipments
SELECT * FROM vw_routes
SELECT * FROM vw_port_traffic

SELECT TOP 3 * FROM vw_port_traffic