Chicago Crime Analytics

Analysis of 2,695,865 reported crime incidents in Chicago from January 2016 to November 2026, using Python for cleaning, SQL for analysis and Power BI for the dashboard.

What this project does
Cleans a raw Chicago crime dataset in a Jupyter notebook
Answers nine questions about the data using SQL (MySQL)
Presents the main trends in a two-page Power BI dashboard
Summarises everything in a written report
Questions answered
How have yearly crime counts changed?
Which crime types are most common each year?
Which crime types have the highest arrest rates?
Which hours are busiest on weekdays and weekends?
Which months have the most crime?
Which districts have the highest share of domestic incidents?
Where do thefts happen, and how often do they end in arrest?
How did crime change before, during and after COVID?
What are the most common offense descriptions within each crime type?
Key findings
Theft is the most common crime type (607,339 incidents) and ranks first in every year.
Reported incidents fell 18.65% in 2020, recovered through 2023, and have declined since.
July has the most incidents and February the fewest.
Arrest rates vary widely: narcotics 98.94%, weapons violations 66.32%, deceptive practice 3.33%.
Most thefts happen on streets and in homes, where arrest rates are only 1 to 2%.
Motor vehicle theft is about 115% higher after COVID than before it, while most other major categories are lower.
Overall, 16.43% of incidents were marked as arrests and 522,774 were marked as domestic-related.
Tools
Python (Jupyter Notebook) for data cleaning
MySQL and SQL for analysis
Power BI for the dashboard

SQL techniques used: GROUP BY and aggregates, CASE expressions, date functions, CTEs, and the window functions LAG() and DENSE_RANK().

Repository contents
.
├── Chicago_Crime_Analytics_final_report.pdf   Final written report
├── cleaning notebooks/
│   └── data_cleaning.ipynb                    Data cleaning
├── SQL/
│   ├── crime_analysis.sql                     The nine SQL queries
│   └── Chicago Crime Analytics (.docx/.pdf)   Report versions
└── PowerBI/
    └── crimes.pdf                             Dashboard export
Data

The raw and cleaned CSV files and the Power BI file (.pbix) are not included because they are too large for GitHub. The data comes from the City of Chicago crime records. To reproduce the analysis:

Download the Chicago crime dataset (2016 onwards) from the City of Chicago Data Portal.
Run cleaning notebooks/data_cleaning.ipynb to produce the cleaned CSV.
Load the cleaned CSV into MySQL.
Run the queries in SQL/crime_analysis.sql.
Limitations
The data covers reported incidents, not all crime that occurred.
2026 is incomplete (data ends 8 November 2026), so full-year comparisons use 2016 to 2025.
An arrest flag does not mean a conviction.
Patterns by time, district and location are descriptive and do not show causes or individual risk.
