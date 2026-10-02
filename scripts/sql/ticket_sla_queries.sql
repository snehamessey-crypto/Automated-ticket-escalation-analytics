-- Database Schema
CREATE DATABASE IF NOT EXISTS support_ops_db;
USE support_ops_db;

CREATE TABLE IF NOT EXISTS support_tickets (
    ticket_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(150),
    ticket_status VARCHAR(50),
    resolution_time DECIMAL(8,2),
    complaint_category VARCHAR(100),
    urgency_level VARCHAR(50)
);

-- Query 1: Operational Turnaround & SLA Breach Rate (>24 Hours)
SELECT 
    complaint_category,
    COUNT(ticket_id) AS total_tickets,
    ROUND(AVG(resolution_time), 2) AS avg_resolution_hours,
    SUM(CASE WHEN resolution_time > 24 THEN 1 ELSE 0 END) AS sla_breached_count,
    ROUND(100.0 * SUM(CASE WHEN resolution_time > 24 THEN 1 ELSE 0 END) / COUNT(ticket_id), 2) AS breach_rate_pct
FROM support_tickets
GROUP BY complaint_category
ORDER BY avg_resolution_hours DESC;

-- Query 2: Open High-Priority Escalations
SELECT 
    complaint_category,
    urgency_level,
    COUNT(ticket_id) AS ticket_volume,
    ROUND(AVG(resolution_time), 2) AS avg_hours
FROM support_tickets
WHERE ticket_status IN ('Open', 'Pending')
GROUP BY complaint_category, urgency_level
ORDER BY complaint_category, FIELD(urgency_level, 'Critical', 'High', 'Medium');
