# SMART HR ANALYTICS SYSTEM (PL/SQL)

## 📌 Project Overview

This project is a **Smart HR Analytics System** developed using **Oracle PL/SQL**. It demonstrates advanced database concepts and HR-related analytics such as salary analysis, employee hierarchy, and department-level insights. All database objects and PL/SQL logic are combined into a **single executable SQL file** for simplicity and ease of execution.

---

## 🎯 Project Objectives

* Apply advanced PL/SQL programming concepts
* Perform employee salary and department analytics
* Simulate real-world HR database systems
* Practice Oracle database features used in enterprise environments

---

## 🚀 Key Features

* Salary classification using `CASE` statements
* Department average salary analysis using **window functions**
* Employee ranking within each department
* Recursive employee hierarchy using `CONNECT BY`
* Analytical and correlated views
* Performance optimization using **indexes**
* **Partitioned tables** for audit logging
* Stored procedures and functions
* Data protection using triggers
* PL/SQL control flow (`IF`, `LOOP`)
* Cursors and iteration
* User-defined exceptions
* Collections, `BULK COLLECT`, and `VARRAY`

---

## 🛠️ Technologies Used

* **Language:** PL/SQL
* **Database:** Oracle Database
* **Schema:** HR Schema
* **Tools:** Oracle SQL Developer / SQL*Plus

---

## 📂 Project Structure

```
SmartHRAnalyticsSystem/
├── smart_hr_analytics.sql
└── README.md
```

> **Note:** All views, tables, procedures, functions, triggers, and PL/SQL logic are merged into one file:
> `smart_hr_analytics.sql`

---

## ▶️ How to Run the Project

1. Ensure **Oracle Database** is installed and the **HR schema** is available.
2. Open **Oracle SQL Developer** or any Oracle-compatible client.
3. Enable output:

   ```sql
   SET SERVEROUTPUT ON;
   ```
4. Execute the full script:

   ```sql
   @smart_hr_analytics.sql
   ```
5. Query the created views or observe outputs via `DBMS_OUTPUT`.

---

## 🧠 Concepts Demonstrated

* Views (Analytical & Correlated)
* Window Functions (`AVG`, `RANK`)
* Recursive Queries
* Indexing
* Partitioned Tables
* Procedures & Functions
* Triggers
* Cursors & Loops
* Exception Handling
* Collections & Bulk Operations
* VARRAYs

---

## 🚀 Future Enhancements

* Add analytical dashboards
* Integrate with a frontend application
* Extend analytics to employee performance metrics
* Implement logging and monitoring features

---

## 👤 Author

Ahmed Ali Kamal
Computer Science Student | Backend & Database Enthusiast

---

## 📄 License

This project is licensed for educational use only.

All rights reserved © 2025 Ahmed Ali Kamal
