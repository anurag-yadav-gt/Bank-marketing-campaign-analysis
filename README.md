
This project analyzes the **Bank Marketing Campaign Dataset** sourced from the UCI Machine Learning Repository.
The dataset contains approximately **41,000 records** and **26 features** related to multiple direct marketing campaigns carried out by a Portuguese banking institution.
The primary objective was to investigate key patterns that influence whether a client subscribes to a term deposit and to develop a fully functional, end-to-end **Business Intelligence (BI) pipeline**, simulating real-world analytics projects.

## 🚀 **Complete Project Workflow**


### 1️⃣ **Data Acquisition & Normalization**

* Downloaded the full dataset from UCI Machine Learning Repository.
* The dataset was quite extensive (\~41K+ rows & 26 columns) with mixed data types: categorical, numeric, and date-like fields.
* Instead of analyzing the flat file directly, I designed a **normalized relational schema** to better handle:

  * Redundancies
  * Dependencies between entities
  * Multi-table join capabilities for richer queries
* The dataset was broken into logical entities:

  * `clients` (personal client data)
  * `subscription` (final campaign result)
  * `contacts` (call attempt records)
  * `campaign` (current campaign metadata)
  * `economics` (macro-economic environment features)
* Loaded each fragmented dataset into **PostgreSQL**, creating an explicit **database schema (`bank_marketing`)** with proper:

  * Primary keys
  * Foreign keys
  * Referential integrity


### 2️⃣ **Data Wrangling (Advanced Cleaning & Imputation)**

This phase involved **real-world data issues**:

* Multiple columns contained ambiguous values such as `'unknown'` across important client characteristics (`job`, `marital`, `education`, `default`, `housing`, `loan`).
* Initially:

  * Replaced `'unknown'` with temporary placeholders to preserve referential integrity across tables.
* Then applied **contextual imputation techniques**:

  * Imputed missing values based on logical relationships with other columns.
  * For example:

    * Imputing missing education levels based on job titles.
    * Imputing missing default status based on housing loan behavior.
  * This method helped maintain **data integrity** without creating artificial bias.
* Avoided using blanket deletion or mean/mode filling to ensure maximum data retention.

**Outcome:**
A **fully wrangled dataset** with minimal missingness, maximum information retention, and business logic preserved.



### 3️⃣ **Exploratory Data Analysis (EDA)**

Performed deep **univariate, bivariate, and multivariate exploration** using:

* **Python libraries:**

  * `pandas`, `numpy`, `seaborn`, `matplotlib`
* EDA tasks included:

  * Descriptive statistics
  * Distribution analysis
  * Correlation matrix building
  * Cross-feature interactions

**Key Findings Discovered:**

* Longer call durations strongly correlated with higher subscription rates.
* Prior campaign outcomes (`poutcome`) had significant predictive power.
* Subscription rates dropped when clients were contacted too many times.
* Macroeconomic indicators (`emp_var_rate`, `nr_employed`) revealed interesting employment stability patterns.



### 4️⃣ **Outlier Detection & Treatment**

* Identified extreme outliers in features such as `duration` (call duration).
* Instead of simply removing these, we applied **intelligent capping**:

  * Capped values beyond logical thresholds while retaining essential patterns.
* Ensured that outlier handling did not distort true business insights, especially for subscription success rates.
* Visualized call duration distributions both pre- and post-treatment to verify integrity.



### 5️⃣ **SQL Feature Engineering (Advanced)**

Throughout the project, multiple new features were created across different tables to better capture the underlying patterns in the bank marketing campaign data. These engineered features helped in producing meaningful insights and effective visualizations.

🔶 1. Clients Table
age_group
Categorized clients into age segments for demographic analysis:

Young_adults: 17–28

Adults: 29–46

Senior_adults: 47–60

Elderly: 61+

financial_risk
Classified clients based on their loan, housing, and default status to assess financial risk profile:

low_risk: No loan, housing, or default.

moderate_risk: Having either loan, housing loan, or default.

unknown_risk: Others.

🔶 2. Contacts Table
call_duration_band
Discretized call durations into meaningful intervals to observe conversion likelihood across durations:

<1min, 1-3min, 3-5min, 5-10min, 10+min, outlier.

🔶 3. Campaigns Table
repeated_contacts
Binned the number of contacts made during a campaign into repetition buckets:

1, 2-3, 4-5, 6-10, 10+

contacted_before
Created a binary flag to indicate whether a client was contacted previously:

contacted_before (pdays != 999)

not_contacted_recently (pdays = 999)

🔶 4. Economics Table
economic_sentiment
Classified consumer confidence index (cons_conf_idx) into sentiment buckets:

Very Low, Low, Moderate, Neutral to High

euirbor_band
Bucketed Euribor 3-month rate (euribor3m) into interest rate bands:

low, moderate, high

nr_employed_stability
Grouped number of employees (nr_employed) into employment stability levels:

very_stable, stable, slightly_unstable, unstable, very_unstable

emp_var_rate_stability
Categorized employment variation rate (emp_var_rate) into stability buckets:

very_stable, stable, slightly_unstable, unstable, very_unstable

👉 These engineered features were critical for:

Improving segmentation

Simplifying complex numerical variables into interpretable categories

Enabling stronger correlations and patterns during analysis and Power BI visualizations



### 6️⃣ **Data Modeling & Visualization (Power BI)**

* Connected Power BI directly to the PostgreSQL relational schema.
* Designed and built a full **interactive dashboard** containing:

  * Subscription rate visualizations.
  * Campaign success rates across time.
  * Call duration impact.
  * Economic stability segmentation.
  * Employment stability categorization.
* Developed advanced **UX/UI elements**:

  * Built a fully functional **Side Navigation Bar** to emulate professional Power BI report designs.
  * Included multiple slicers, drill-down filters, cross-filtering interactivity.
* This dashboard could easily serve real business stakeholders and support operational decision-making.



## ⚙️ **Technical Stack Used**

| Technology                                      | Purpose                                                                 |
| ----------------------------------------------- | ----------------------------------------------------------------------- |
| **Python (pandas, numpy, seaborn, matplotlib)** | Data ingestion, cleaning, wrangling, EDA                                |
| **PostgreSQL (SQL)**                            | Database schema design, relational modeling, feature engineering        |
| **Power BI**                                    | Data modeling, business reporting, dashboarding, advanced visualization |
| **GitHub**                          | Project version control, repository hosting, full documentation         |



## 📈 **Key Learning Milestones**

* Hands-on experience with:

  * **Real-world data wrangling techniques (contextual imputation).**
  * **SQL feature engineering with numeric precision challenges.**
  * **Relational data modeling and schema normalization.**
  * **EDA across multiple tools (Python + SQL).**
  * **Advanced BI design using Power BI interactive elements.**
* Mastered the ability to **design end-to-end data pipelines** from raw data to fully functional BI dashboards.


