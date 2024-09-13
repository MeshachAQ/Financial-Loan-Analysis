# Financial-Loan-Analysis
This is a Financial Loan Analysis and report where I showcased my technical skills in SQL and Tableau to derive insights.

### In this page,you will find my SQL Queries as well as the dataset. You can also find the project questions for this project. 



## kindly find a couple of SQL Queries used in this project with sample questions


### Manager wants to know the percentage of good loans and is asking if we can assist

select (COUNT(CASE
WHEN loan_status = 'Fully Paid' or loan_status = 'Current' THEN id END) * 100) / 
count(id)
as Percentage_good_Loan from financial_loan$

### Manager wants to know the good_loan funded amount
select sum(loan_amount) as Good_Loan_funded_amt from financial_loan$ WHERE Good_Loans = 1

### Manager wants to know the percentage of bad loans and is asking if we can assist
SELECT(COUNT(CASE
WHEN loan_status = 'Charged Off' THEN id END) * 100) / COUNT(id) as Bad_loan_percentage from financial_loan$


### Find the Bad Loans funded amount
select sum(loan_amount) as Bad_Loans_Funded_Amt from financial_loan$ WHERE loan_status = 'Charged Off'



### Manager is now requesting for the good loan and bad loan amount received
---Good loan amount received
select sum(total_payment) as Good_loan_amt_received from financial_loan$ WHERE Good_Loans = 1

### Bad Loan amount received
select sum(total_payment) as Bad_loan_amt_received from financial_loan$ WHERE loan_status = 'Charged Off'

### Management now will like to get some some insights into their loan status so yh
select loan_status, sum(loan_amount) as loanAmt, sum(total_payment) as LoanReceivedAmt, avg(int_rate) * 100 as AvgIntRate, avg(dti) * 100 as AvgDti from financial_loan$
group by loan_status

### Management also wants to know the MTD Amounts
select loan_status, sum(loan_amount) as MTD_LoanAmt, sum(total_payment) AS MTD_TotalRec from financial_loan$ WHERE MONTH(issueDate) = 12
group by loan_status
