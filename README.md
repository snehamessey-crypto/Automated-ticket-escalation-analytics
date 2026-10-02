# Automated Customer Ticket Categorization & Escalation System

![Dashboard Preview] 

## Executive Summary 
Customer operations team frequently spend significant manual reading and routing incoming support queries. This latency results in SLA breaches for urgent issues like billing errors and equipment breakdown.

This project delivers an automated, rule-based text processing and escalations engine. Using Python for text classification, MySQL Workbench for SLA analytics and Power BI for executive monitoring, it reduces classification latency and highlights key operational bottlenecks.

---

## Tech Stacks & Methodology 
* **Python (Pandas, Regex): ** Ingests raw feedback text, applies keyword pattern matching and creates automated `complaint_category` and `urgency_level` tags.
* **MySQL Workbench: ** Aggregates SLA violation rates, measures resolution hours and segments open high-priority backlog.
* **Power BI Desktop: ** Executive KPI ribbons, turnaround distribution visuals and dynamic exception-routing tables.
* **Excel Auditing: **Backward-compatible nested `IF` and `search` formula logic for manual verification.

---

## Data Architecture & Pipeline 
1. **Raw Ingestion:** Ingested customer support logs from Kaggle (`customer_support_tickets.csv`).
2. **Text Processing:** Python extracts domain keywords to tag categories (`Billing & Refund`, `Equipment & Maintenance`, `Staff & Scheduling`, `general Query`).
3. **Urgency Detection:** Flags tickets containing critical impact words (`immediately`, `refund`, `broken`, `urgent`) as `Critical` or `high`.
4. **Relational Analysis:** Queries metrics in MySQL to compute breach percentage (>24 hours resolution target).
5. **Dashboard Delivery:** Modeled in Power BI with custom DAX measures for executive drill-down.

---

## Key Business Insights
* **Operational Bottlenecks:** **Equipment & Maintenance** queries exhibited the longest turnaround, averaging **31.2 hours** (30% above the 24-hour target).
* **High-Risk Categories:** Over **50%** of all `Critical` urgency flags originated from billing disputes.
* **Efficiency Gains:** Automating category assignment eliminated manual triage queues, enabling immediate routing to Tier-2 support.

---

## SQL Query Reference 
Key business queries are documented in [`sql/ticket_sla_queries.sql`](sql/ticket_sla_queries.sql).

Sample SLA breach query:
```sql
SELECT 
    complaint_category,
    COUNT(ticket_id) AS total_tickets,
    ROUND(AVG(resolution_time), 2) AS avg_resolution_hours,
    ROUND(100.0 * SUM(CASE WHEN resolution_time > 24 THEN 1 ELSE 0 END) / COUNT(ticket_id), 2) AS breach_rate_pct
FROM support_tickets
GROUP BY complaint_category
ORDER BY avg_resolution_hours DESC;
