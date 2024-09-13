---Hola, Meshach here again to take us through this wonderful project. This is a financial loan project for a financial company
--- and manager is asking us to do some magic and derive insights to help them in their decision making. We shall then proceed to export all this to Tableau for some amazing visuals
--- to buttress our work done here. so yhh let's go.

---First off, I will like to do the relevant standardizations before starting work and deriving insights.
select * from financial_loan$ 

select issue_date, CONVERT(date, issue_date) as issueDate from financial_loan$

select last_credit_pull_date, convert(date, last_credit_pull_date) as lastcredit_pullDate from financial_loan$

select next_payment_date, convert(date, next_payment_date) as NextPayment_Date from financial_loan$

select

---Okay now we have just our dates so lets Add these new columns and drop the converted columns first

ALTER TABLE financial_loan$
ADD issueDate DATE

UPDATE financial_loan$
SET issueDate = CONVERT(date, issue_date)

ALTER TABLE financial_loan$
ADD lastcredit_pullDate DATE

UPDATE financial_loan$
SET lastcredit_pullDate = convert(date, last_credit_pull_date)

ALTER TABLE financial_loan$
ADD NextPayment_Date DATE

UPDATE financial_loan$
SET NextPayment_Date = convert(date, next_payment_date)


select * from financial_loan$

---Okay now we can drop the converted columns
ALTER table financial_loan$
DROP COLUMN issue_date, last_credit_pull_date, last_payment_date

ALTER TABLE financial_loan$
DROP COLUMN next_payment_date

--- Okay now we can start looking at some interesting things about this data

--- First, management would like to know the total loan application
select count(distinct(id)) as total_loan_application from financial_loan$

---Secondly, management wants to know the MTD loan applications
select count(id) as MTD_loan_application from financial_loan$ where MONTH(issueDate) = 12

---Now management is asking if we can find the Previous Month To Day(PMTD) loan application
SELECT COUNT(ID) as PMTD_loan_application FROM financial_loan$ where month(issueDate) = 11

---Now management wants to know what the total funded amount is
select sum(loan_amount) as total_loan_amount from financial_loan$

---Management now wants to know the MTD total amount funded
select sum(loan_amount) as MTD_total_amt_funded from financial_loan$ where month(issueDate) = 12

---Management again wants to know the previous month to day total amount funded(PMTD)
Select sum(loan_amount) as PMTD_total_amt_funded from financial_loan$ where month(issueDate) = 11




select * from financial_loan$

--- Management now wants to know the total Loan amount received so far.
select sum(total_payment) as total_loan_amount_received from financial_loan$

---Can we calculate the MTD loan amount received so far?
select sum(total_payment) as MTD_loan_received from financial_loan$ where month(issueDate) = 12

---Again, we wanna find the PMTD loan amount received so far
select sum(total_payment) as PMTD_total_amout_received from financial_loan$ WHERE MONTH(issueDate) = 11

---Manager is now asking us to find the average interest rate
select AVG(int_rate)as Avginterest_rate from financial_loan$

--- To get the real Average interest rate, since the column is divided by 100, we can do this...
select AVG(int_rate) * 100 as Avg_interest_rate from financial_loan$

---Manager now wants us to calculate the MTD Average rate
select AVG(int_rate) * 100 as MTD_Avg_interest_rate from financial_loan$ WHERE MONTH(issueDate) = 12

---Now to calculate for the PMTD Average interest rate
select AVG(int_rate) * 100 as PMTD_Avg_interest_rate from financial_loan$ WHERE MONTH(issueDate) = 11


select * from financial_loan$

---Find the average Dti
select AVG(dti) * 100 as Avg_dti from financial_loan$

---Find the Average MTD DTI
select Avg(dti) * 100 as MTD_Avg_dti from financial_loan$ WHERE MONTH(issueDate) = 12

---Manager now wants us to find the PMTD Avg dti
select Avg(dti) * 100 as PMTD_Avg_dti from financial_loan$ WHERE MONTH(issueDate) = 11

---Now management wants to find out the good loans from the bad loans. Keep in mind that good loans are loans that havnt been written off or charged off so...
select distinct loan_status from financial_loan$

---Alright so the above shows that loan status has three possibilities and so we can categorise good loans from here as if it's fully paid or current right and bad loans as charged off. okay

---Total of good loans
select *,
CASE 
WHEN loan_status = 'Fully Paid' THEN 1
WHEN loan_status = 'Current' THEN  1
ELSE 0
END as Good_Loans from financial_loan$

---Total of Bad Loans
select *,
CASE
WHEN loan_status = 'Charged Off' THEN 1
ELSE 0
END as bad_loans from financial_loan$

---Let's update these two columns first to know the totals for both good and bad loans we can drop them later
ALTER TABLE financial_loan$
ADD Good_Loans int

UPDATE financial_loan$
SET Good_Loans = CASE 
WHEN loan_status = 'Fully Paid' THEN 1
WHEN loan_status = 'Current' THEN  1
ELSE 0
END

ALTER TABLE financial_loan$
ADD bad_loans int

UPDATE financial_loan$
SET bad_loans = CASE
WHEN loan_status = 'Charged Off' THEN 1
ELSE 0
END



SELECT * FROM financial_loan$


---So now I can get my good loans as
select sum(Good_Loans) as GoodLoans from financial_loan$

---And to find the bad loans
select sum(bad_loans) as BadLoans from financial_loan$


---Manager now wants to know the percentage of good loans and is asking if we can assist

select (COUNT(CASE
WHEN loan_status = 'Fully Paid' or loan_status = 'Current' THEN id END) * 100) / 
count(id)
as Percentage_good_Loan from financial_loan$

---Manager now wants to know the good_loan funded amount
select sum(loan_amount) as Good_Loan_funded_amt from financial_loan$ WHERE Good_Loans = 1

---Manager now wants to know the percentage of bad loans and is asking if we can assist
SELECT(COUNT(CASE
WHEN loan_status = 'Charged Off' THEN id END) * 100) / COUNT(id) as Bad_loan_percentage from financial_loan$


---Find the Bad Loans funded amount
select sum(loan_amount) as Bad_Loans_Funded_Amt from financial_loan$ WHERE loan_status = 'Charged Off'



---Manager is now requesting for the good loan and bad loan amount received
---Good loan amount received
select sum(total_payment) as Good_loan_amt_received from financial_loan$ WHERE Good_Loans = 1

---Bad Loan amount received
select sum(total_payment) as Bad_loan_amt_received from financial_loan$ WHERE loan_status = 'Charged Off'

---Management now will like to get some some insights into their loan status so yh
select loan_status, sum(loan_amount) as loanAmt, sum(total_payment) as LoanReceivedAmt, avg(int_rate) * 100 as AvgIntRate, avg(dti) * 100 as AvgDti from financial_loan$
group by loan_status

---Management also wants to know the MTD Amounts
select loan_status, sum(loan_amount) as MTD_LoanAmt, sum(total_payment) AS MTD_TotalRec from financial_loan$ WHERE MONTH(issueDate) = 12
group by loan_status



SELECT * FROM financial_loan$


---Manager will again like to have a bank report overview based on the month
select DATENAME(MONTH, issueDate) as Month_Name, count(id) as Total_loans, sum(loan_amount) as Total_Loan_Distr, sum(total_payment) as Loan_Payments from financial_loan$
GROUP BY DATENAME(MONTH, issueDate)
ORDER BY count(id) DESC

---Management now wants to get insights into their data by address_states
select address_state, count(id) as ID_by_state, sum(loan_amount) as Loan_by_State, sum(total_payment) as Rec_by_State from financial_loan$
GROUP BY address_state
ORDER BY sum(loan_amount) DESC

---Management wants to now gain some insights based on the terms of their contract(36 months and 60 months)
select term, count(id) as terms_ID, SUM(loan_amount) as Loans_by_Terms, sum(total_payment) as Payments_by_terms from financial_loan$
GROUP BY term
ORDER BY count(id)

---Now we also wants to look at some insights based on employee length
select emp_length, count(id) as emp_length_count, sum(loan_amount) as loan_amt, sum(total_payment) as loan_paid_emp_length from financial_loan$
GROUP BY emp_length
ORDER BY count(id)

---Now we also wants to look at some insights based on Purpose
select purpose, count(id) as purpose_id, sum(loan_amount) as purpose_loan_amt, sum(total_payment) as purpose_total_payment from financial_loan$
GROUP BY purpose
ORDER BY count(id)



SELECT * FROM financial_loan$

---And finally, Now we also wants to look at some insights based on home ownership
select home_ownership, count(id) as Hocount, sum(loan_amount) as lamt, sum(total_payment) as Lpay from financial_loan$
GROUP BY home_ownership
ORDER BY count(id)



---Okay so this is our work and we are going to export this into tableau to create some outstanding visuals but first lets check for duplicates right
with banking as (select *, ROW_NUMBER() over(PARTITION BY id, issueDate, loan_amount ORDER BY id) row_num from financial_loan$)
select * from banking
where row_num > 1

---okay so there are no duplicated values in this data set

select * from financial_loan$