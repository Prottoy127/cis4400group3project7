# cis4400group3project7
Analysis of the OTC Market Transaction

## Business Requirements:
Our goals and objectives for this project are as follows:
- Be able to perform in-depth analysis of OTC market transactions
- Give insights into OTC market trends and behavior

## Functional Requirements:
Perform Technical Analysis on OTC market transactions.
- Moving Average Convergence Divergence (MACD)
- Relative Strength Index
- Moving Average 50 Day
- Moving Average 100 Day
- Yearly Return

## Data Requirements:
- Main Dataset:
  - OTC Market Data (Structured) - Record of OTC market transactions
- Reference Datasets:
  - Company Information (Structured) - List and details (e.g. price, security type, etc.) of companies in the OTC market.
  - OTC GICS Data (Structured) - Global Industry Classification Standard for OTC companies.
  - OTC Securities Data (Structured) - List of company security symbols, names, issue types, etc.
  - OTC Data Dictionary (Structured) - A primary reference to identify and understand values.
- End-of-Day Pricing Specifications PDF (Unstructured) - explanation of fields found in our data and data types
- Technical analysis tools and algorithm

## Business Impact

Implementing this OTC market analysis platform offers important value to financial firms, traders, and investment analysts. By leveraging technical indicators like Moving Average Convergence Divergence (MACD), Relative Strength Index (RSI), and moving averages, the system assists in informed decision-making in the realm of illiquid and opaque OTC securities—a market segment often overlooked due to its limited transparency.
Benefits:
*	Traders and analysts can make informed investment decisions by better timing trades and identifying underpriced or overhyped OTC securities.
*	Trend Detection assists in identifying industry patterns and sector rotations using the GICS classification system.
*	Users can assess the long-term viability of their investments by analyzing yearly returns and moving averages.
*	Firms can gain a competitive edge by proactively identifying and capitalizing on emerging trends or momentum shifts, thereby positioning themselves strategically.
Risks:
*	Data Integrity: OTC markets are less regulated, and inconsistent data could lead to inaccurate insights.
*	Overreliance on Technicals: Pure technical analysis, lacking sufficient fundamental context, can lead to poor decisions.
*	Cost of Implementation: Preparing data pipelines, integrating analysis tools, and training personnel can be resource intensive.
Estimated Impact:
*	Target Outcome: The OTC market segment experiences a 10–15% improvement in trade execution timing and a corresponding increase in return on investment.
*	Moonshot Outcome (goes better than planned): The company achieves a 25–30% boost in portfolio performance due to its successful OTC investments. This outcome also positions the company as a market leader in OTC analytics.


## Business Persona

Primary Users:
* Financial Analysts: They would use the system for in-depth technical analysis and reporting on OTC securities.
*	Traders / Portfolio Managers: Rely on signals such as MACD and RSI to determine the appropriate entry and exit points.
*	Market Researchers: Analyze long-term trends across sectors using the Global Industry Classification System (GICS).
*	Data Scientists: Develop and refine technical analysis models and algorithms to enhance trading strategies.
*	Business Executives / Stakeholders: Use insights to develop high-level strategic plans and assess market opportunities.

Secondary Users:
*	Compliance Teams: They may use the reference data and transaction records for regulatory reporting and risk oversight.
*	Product Managers: Identify the analytics features that are driving engagement and guide further development in that area.

## Data

This section explains what data sources were used alongside the strengths and weaknesses of the data stack.

### Data Sources:

The main data source used was "otc_raw_data.csv". Metadata files are: "companyInfo.csv", "otc_data_dictionary.csv", "otc_data_dictionary.csv", "otc_gics.csv", "otc_securities.csv". 

The dataset is approximately 6.2 GB mainly due to the raw data being 6.1 GB. 

All data sources were provided by Professor Jefferson Bien-Aime

#### Strengths

Comprehensive Metadata Coverage<br>
The presence of multiple metadata files is a great way to document the dataset. These files provide essential context such as company attributes, variable definitions, sector classifications, and security details, which are critical for proper data interpretation and analysis.

Potential for Rich Analysis<br>
"otc_raw_data.csv" contains granular trading and company data, and the metadata files are well-structured, enabling in-depth analysis of OTC market dynamics, company performance, and sector trends. This is particularly valuable given the opaque nature of OTC markets.

#### Weaknesses

CSV Format Limitations<br>
While CSV is widely used, it lacks formal specification for metadata and can be prone to interpretation errors, especially with complex data types or nested structures. Without strict adherence to standards like CSV on the Web (CSVW), there is a risk of misinterpretation or data loss during processing.

Risk of Data Gaps and Ambiguity<br>
OTC datasets may have gaps due to voluntary reporting, delistings, or changes in company status. If the metadata does not explicitly document such cases (e.g., using standardized codes for missing or unknown values), users may misinterpret the data.

Complexity for Non-Expert Users<br>
Even with metadata, OTC datasets can be complex, especially for users unfamiliar with financial markets or specific OTC conventions. Detailed documentation and clear examples are necessary to lower the barrier to entry.

## Methods

This section highlights all the architectures used alongside dimensional modeling. All acted as pipeline in completion of the project. Software used to complete this project will be spoken about, especially their importance to make this project possible.

### Information Architecture

Reference and raw data were used to import finalized data in the data warehouse. This was done to provide more information on a transaction when the user interacts with the project. Achieving this is done through data consolidation before it is loaded to the data warehouse.

Data was gathered, put in temporary storage, extracted, cleaned, reformatted, and transformed during this process.

### Data Architecture

Reference and raw data were used to import finalized data in the data warehouse. After gathering data and putting it in temporary storage, our data integration process explained later was used to inject finalized data into the data warehouse. Since the data is in a final state, the Business Persona will use Tableau to analyze the transactions.

### Dimensional Modeling

Given our dataset is full of transactions, many facts are present. Note that each dimension required an id column to be made from the facts table to achieve the one-to-many relationship. All dimensions made are to verify the integrity of each transaction and how well those transactions went. The date is also a dimension as we want to extract as much information regarding the time of trade, providing even more insight into analysis.

DbSchema was used to create the dimensional model with a visual representation of the data warehouse at this stage of the project.

## Technical Architecture

Note that an ELT was used, and why pythonscripts is near empty. Python integration is nonexistant due to how the data was given.

All data sources provided were integrated into a Python script to then be stored into a container in Azure. Each data source began in Azure as blobs untouched. The Python script made the connection to Azure and stored them in a new container as SQL files. Those SQL files were then loaded into Snowflake to start the schema. Snowflake sent the files to dbt to transform the data and ensure it is validated. dbt then sends the new files back to Snowflake to create a proper data warehouse. Tableau is used to visualize and interact with the data warehouse.


## Data Storage Tools

Data Storage: Microsoft Azure containers, Snowflake
 
Data Processing: Python processes the data first, dbt processes the data a second time. Snowflake ingests the data from the Azure container once and from dbt a second time.
 
Data Orchestration: Snowflake is used to automate the data warehouse, dbt is used to automate the data integration.

## Interface

The user is able to perform their own analysis using Tableau given our created data warehouse. The user connects to Tableau live to interact with our project. Some examples are seen in the data/Visualizations directory.
