# Financial Loan Analysis

This is a Financial Loan Analysis and report where I showcased my technical skills in SQL and Tableau to derive insights. In this dataset, we mainly focused on leveraging Tableau desktop to gain insight into this particular dataset. This is my first ever tableau project and you can't fathom the kind of excitement I got when I finally finished this project. it's being an all time favorite of mine and I'm here today to share it. Now, this dataset focused on credit loans by this institution to it's customers and they really need me to find out how this business is fairing from total loans to bad debts, good debts etc so I dived in and got them what they requested for. lol let's check it out;

# DATA CLEANING

Frankly, there weren't alot of data cleaning to do here. I just changed some datatypes and went on with my analysis. But before then, I levereged on tableau's calculated column to perform some calculations and analysis which is found below in the analysis portion

# DATA ANALYSIS
Here, we leveraged tableau's calculated tables to tackle these concerns by management;

#### Manager wants to know the percentage of good loans and is asking if we can assist

select (COUNT(CASE WHEN loan_status = 'Fully Paid' or loan_status = 'Current' THEN id END) * 100) / count(id) as Percentage_good_Loan from financial_loan$

#### Manager wants to know the good_loan funded amount

select sum(loan_amount) as Good_Loan_funded_amt from financial_loan$ WHERE Good_Loans = 1

#### Manager wants to know the percentage of bad loans and is asking if we can assist

SELECT(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100) / COUNT(id) as Bad_loan_percentage from financial_loan$

#### Find the Bad Loans funded amount

select sum(loan_amount) as Bad_Loans_Funded_Amt from financial_loan$ WHERE loan_status = 'Charged Off'

#### Manager is now requesting for the good loan and bad loan amount received

#### Good loan amount received 
select 
sum(total_payment) as Good_loan_amt_received from financial_loan$ WHERE Good_Loans = 1

#### Bad Loan amount received

select sum(total_payment) as Bad_loan_amt_received from financial_loan$ WHERE loan_status = 'Charged Off'

#### Management now will like to get some some insights into their loan status so yh

select loan_status, sum(loan_amount) as loanAmt, sum(total_payment) as LoanReceivedAmt, avg(int_rate) * 100 as AvgIntRate, avg(dti) * 100 as AvgDti from financial_loan$ group by loan_status

#### Management also wants to know the MTD Amounts

select loan_status, sum(loan_amount) as MTD_LoanAmt, sum(total_payment) AS MTD_TotalRec from financial_loan$ WHERE MONTH(issueDate) = 12 group by loan_status


# DATA VISUALIZATION

Now, to my favorite part of visualising what we have, I must say, this was done in three folds

# Summary
![FINANCIAL LOAN 1 PIC](https://github.com/user-attachments/assets/cef2a216-d70c-4273-9d43-0acb869d5c51)


# Overview
![FINANCIAL LOAN 2 PIC](https://github.com/user-attachments/assets/e90d764b-f36c-4c65-a936-bcb2397b0866)


# REPORT STAGE
![FINANCIAL LOAN 3 PIC](https://github.com/user-attachments/assets/4d11ef74-8061-4000-a0dd-c6f1d017c792)

Kindly find the tableau vid to this project here: https://vimeo.com/1058961716/79b5f60678

So this was the stages I took in performing this dashboard. We have filters and Navigations. To navigate to the next page,

hold down on alter key + left click on the navigation of your choice




# CONCLUSION

For my very first Tableau project, this forever remains an exciting project of challenges and me rising above what I beleived I was only capable of at the time.
