
# Election Results Data Analysis (SQL Project)

##  Project Overview

This project analyzes Indian general election results using structured SQL queries on cleaned and normalized datasets. It includes insights into vote distribution, party alliances, winning margins, and constituency-level details.

---

##  Database Schema

### Tables Created:

1. **`constituencywise_details`**
   Stores vote-level information per candidate and constituency.

2. **`constituencywise_results`**
   Records winning candidates and vote margins per constituency.

3. **`statewise_results`**
   Contains leading/trailing candidates and status per constituency within each state.

4. **`partywise_results`**
   Maintains party-wise win counts and alliance groupings (NDA, INDIA, OTHERS).

5. **`state`**
   Maps state IDs to their respective state names.

---

##  Data Cleaning & Validation

* Checked for `NULL` values in all tables.
* Identified and reviewed duplicates in `constituencywise_details`.
* Deleted inconsistent or incorrect entries (`example: constno = 24`).
* Added a new column `PARTYALLIANCE` in `partywise_results` and updated it accordingly.

---

##  Key Analysis Queries

### 1. **Seats Available per State**

```sql
SELECT s.state, COUNT(cr.parliamentconstituency) AS seats 
FROM constituencywise_results cr
JOIN statewise_results sr ON cr.parliamentconstituency = sr.parliamentconstituency
JOIN state s ON sr.stateid = s.stateid
GROUP BY s.state
ORDER BY seats DESC;
```

### 2. **Total Seats Won by NDA & INDIA Alliance**

* Aggregated party-wise wins into alliances.
* Used conditional aggregation and mapping with `PARTYALLIANCE`.

### 3. **Distribution of EVM vs Postal Votes**

* Analyzed `EVMVotes` and `PostalVotes` for specific constituencies.

### 4. **State-wise Seat Wins by Alliance**

```sql
SELECT
    s.state,
    SUM(CASE WHEN pr.PARTYALLIANCE = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats,
    SUM(CASE WHEN pr.PARTYALLIANCE = 'INDIA' THEN 1 ELSE 0 END) AS INDIA_Seats,
    SUM(CASE WHEN pr.PARTYALLIANCE = 'OTHERS' THEN 1 ELSE 0 END) AS OTHERS_Seats
FROM constituencywise_results cr
JOIN partywise_results pr ON cr.partyid = pr.partyid
JOIN statewise_results sr ON cr.parliamentconstituency = sr.parliamentconstituency
JOIN state s ON sr.stateid = s.stateid
GROUP BY s.state
ORDER BY s.state;
```

### 5. **Top Parties per State**

Used `DENSE_RANK()` to find parties with most seats in each state.

---

##  Insights Extracted

* Total seats won by each alliance across the country.
* Top winning candidates and vote margins in selected constituencies.
* State-wise and constituency-wise performance breakdown.
* Vote type distribution (EVM vs Postal).

---

##  Tools & Technologies

* **Database**: PostgreSQL / MySQL
* **Language**: SQL
* **Analysis Techniques**: Joins, Window Functions, Aggregation, Conditional Logic

---

##  Future Scope

* Integration with Power BI/Tableau for interactive dashboards.
* Extend to include turnout % and demographic analysis.
* Predictive analytics based on historical voting patterns.

---

