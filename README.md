
This project analyzes the **Bank Marketing Campaign Dataset** sourced from the UCI Machine Learning Repository.
The dataset contains approximately **41,000 records** and **26 features** related to multiple direct marketing campaigns carried out by a Portuguese banking institution.
The primary objective was to investigate key patterns that influence whether a client subscribes to a term deposit and to develop a fully functional, end-to-end **Business Intelligence (BI) pipeline**, simulating real-world analytics projects.

## 🚀 **Complete Project Workflow**


### 1️⃣ **Data Acquisition & Normalization**

* Downloaded the full dataset from UCI Machine Learning Repository.
* The dataset was quite extensive (\~41K rows & 26 columns) with mixed data types: categorical, numeric, and date-like fields.
* Instead of analyzing the flat file directly, we designed a **normalized relational schema** to better handle:

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

One of the most challenging & rewarding phases involved extensive **SQL feature engineering** inside PostgreSQL:

* **Employment Stability Classification:**

  * Created a complex engineered feature combining:
    
    * `nr_employed` (number of employees)
    * `emp_var_rate` (employment variation rate)
  * Initially attempted joint CASE WHEN conditions but faced floating-point precision challenges.
  * Solved floating-point tolerance issues using absolute difference logic (`abs()`), dynamic binning thresholds, and separate feature extraction.
* **Two new independent stability features engineered:**

  * `nr_employed_stability`
  * `emp_var_rate_stability`
* These features allowed for better visual interpretation and business relevance during Power BI visualization.
* This phase solidified practical experience handling **double precision vs integer errors**, which occur frequently when comparing floating-point fields directly in SQL.


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


