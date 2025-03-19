use transportation;
-- Question 1 #Mysql
SELECT DAYNAME(Date) AS DayOfWeek,
ROUND(AVG(count), 2) AS AvgFareEvasion
FROM daily_ridership
GROUP BY Date
ORDER BY AvgFareEvasion DESC
LIMIT 3;

-- Question 2 #Mysql
SELECT  v.vehicle_class_category AS VehicleType, ROUND(AVG(c.crz_entries), 2) AS AvgCongestionEntries
FROM congestion_relief_zone c
JOIN vehicles v 
ON c.vehicle_class = v.vehicle_class
GROUP BY v.vehicle_class
ORDER BY AvgCongestionEntries DESC
LIMIT 1;

-- Question 3 #Mysql
SELECT 
 t.hour_of_day AS Hour,
 SUM(tb.traffic_count) AS TotalCrossings
FROM tunnel_and_bridge_crossings tb
JOIN time_records t 
ON tb.timestamp_record = t.timestamp_record
GROUP BY t.hour_of_day
ORDER BY TotalCrossings DESC
LIMIT 1;

-- Question 4 #Mysql
SELECT  t.time_period_quarter AS TimePeriod,
SUM(f.fare_evasion) AS TotalFareEvasion,
COUNT(v.id) AS TotalTrafficViolations
FROM fare_evasion f
JOIN time_records t 
ON f.time_period = t.time_period_quarter
LEFT JOIN congestion_relief_zone v 
ON t.timestamp_record = v.toll_ten_minute_block
GROUP BY t.time_period_quarter
ORDER BY TotalFareEvasion DESC;

SELECT t.Date AS TimePeriod,
SUM(d.count) AS TotalRidership
FROM daily_ridership d
JOIN time_records t 
ON d.Date = t.Date
GROUP BY t.Date
ORDER BY TotalRidership DESC;

SELECT t.date AS TimePeriod,
COUNT(v.id) AS TotalTrafficViolations
FROM time_records t
JOIN congestion_relief_zone v 
ON t.timestamp_record = v.toll_ten_minute_block
GROUP BY t.date
ORDER BY TotalTrafficViolations;

-- Question 5 #Mysql
SELECT  tb.payment_method,
 SUM(traffic_count) AS UsageCount
FROM tunnel_and_bridge_crossings tb
GROUP BY tb.payment_method
ORDER BY UsageCount DESC
LIMIT 1;

-- Question 6 #Mysql
select Mode, sum(Count) AS SUM from daily_ridership
GROUP BY Mode;

-- Question 7 #Psql
SELECT 
    se.station_id,
    COUNT(*) AS TotalEntrances,  
    SUM(tb.traffic_count) AS TotalTrafficVolume
FROM station_entry_exit se
JOIN tunnel_bridge_crossings tb ON se.station_id = tb.facility_id
GROUP BY se.station_id
ORDER BY TotalTrafficVolume DESC;


-- Question 8 #Psql
SELECT violation_description AS ViolationType, 
    COUNT(*) AS ViolationCount
FROM traffic_violations
GROUP BY violation_description
ORDER BY ViolationCount DESC
LIMIT 10;

SELECT violation_month AS ViolationMonth, 
    COUNT(*) AS ViolationCount
FROM traffic_violations
GROUP BY violation_month
ORDER BY ViolationCount DESC;

SELECT 
    time_period AS Quarter, 
    SUM(fare_evasion) AS TotalFareEvasion
FROM fare_evasion
GROUP BY time_period
ORDER BY TotalFareEvasion DESC;


-- Question 9 #Psql
SELECT 
    age_group5 AS AgeGroup,
    gender AS Gender,
    COUNT(*) AS ViolationCount
FROM traffic_violations
GROUP BY age_group5, gender
ORDER BY ViolationCount DESC;
SELECT 
    age_group5 AS AgeGroup,
    COUNT(*) AS ViolationCount
FROM traffic_violations
GROUP BY age_group5
ORDER BY ViolationCount DESC;

SELECT tv.age_group5 AS AgeGroup,
    COUNT(tv.age_group5) AS TrafficViolations,
    SUM(fe.fare_evasion) AS FareEvasion
FROM traffic_violations tv
LEFT JOIN fare_evasion fe ON tv.age_group5 = fe.time_period
GROUP BY tv.age_group5
ORDER BY TrafficViolations DESC, FareEvasion DESC;


-- Question 10 #Psql
SELECT tv.police_agency AS EnforcementAgency,
    COUNT(*) AS ViolationCount
FROM traffic_violations tv
GROUP BY tv.police_agency
ORDER BY ViolationCount DESC;

SELECT tv.police_agency AS EnforcementAgency,
    COUNT(tv.violation_charged_code) AS TrafficViolations,
    SUM(fe.fare_evasion) AS FareEvasion
FROM traffic_violations tv
LEFT JOIN fare_evasion fe 
    ON CONCAT(tv.violation_year, '-Q', CEIL(tv.violation_month / 3)) = fe.time_period
GROUP BY tv.police_agency
ORDER BY TrafficViolations DESC, FareEvasion DESC;

SELECT tv.violation_month AS ViolationMonth,
    tv.police_agency AS EnforcementAgency,
    COUNT(*) AS ViolationCount
FROM traffic_violations tv
GROUP BY tv.violation_month, tv.police_agency
ORDER BY ViolationMonth, ViolationCount DESC;
