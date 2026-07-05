-- create database churn_project
---- Table inserted from ANALYSISSI directly through sqalchemy 






select * from features_table limit 100;
select customerid , 
case 
when churn = 'No' then  '0' 
else  '1' 
end 
As churn_data
from churn_data
limit 50;

--feature table
Create table features_table AS 
select customerid , tenure , 
		Case when tenure <=12 then '0-12'
		 	 when tenure between 13 And 24 then '12-24'
			 else '25+'
			 end As tenure_span,
		(Case when phoneservice = 'Yes' then 1 else 0 end +
		  Case when multiplelines = 'Yes' then 1 else 0 end +
		   Case when internetservice = 'Yes' then 1 else 0 end +
		    Case when onlinesecurity = 'Yes' then 1 else 0 end +
			 Case when onlinebackup = 'Yes' then 1 else 0 end +
			  Case when deviceprotection = 'Yes' then 1 else 0 end +
			   Case when techsupport = 'Yes' then 1 else 0 end +
			    Case when streamingtv = 'Yes' then 1 else 0 end +
				 Case when streamingmovies = 'Yes' then 1 else 0 end ) AS total_services_subscribed,
	monthlycharges As averageMonthlyspend ,
	  contract AS contract_type,
  paymentmethod,

  CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END AS churn
  from churn_data  ;

--over all churn rate
  select Round(( count(*) filter (where churn='1') *100.0 / count(*) )  ,5) As overall_churn
  from features_table ;


---churn rate based on contract_type
  select contract_type ,
  count(*) As total_customers ,
  count(*) FILTER (where churn='1') As total_Churned_Cusotmers ,
  round(count(*) FILTER (where churn='1')*100.0/count(*),4) AS churnrate_percontTyp
  from features_table
  group by contract_type
  order by churnrate_percontTyp;

 ---churn rate by tenure span
  select tenure_span , 
  count(*) AS total_number ,
  count(*) FILTER (where churn='1') As total_Churned_Cusotmers ,
  round(count(*) FILTER (where churn='1')*100.0/count(*),4) AS churnrate_perTenure
  from features_table
  group by tenure_span
  order by churnrate_perTenure ;

----churn rate by payment method
  select paymentmethod , 
  count(*) AS total_number ,
  count(*) FILTER (where churn='1') As total_Churned_Cusotmers ,
  ROUND(count(*) FILTER (where churn='1')*100.0/count(*),4) AS churnrate_perPAymenthod
  from features_table
  group by paymentmethod
  order by churnrate_perPAymenthod ;

----revenue churn
  select sum(averagemonthlyspend) filter (where churn='1') AS monthly_loss,
  sum(averagemonthlyspend) filter (where churn='1')*12 AS annual_loss
  from features_table ;

----service count vs churn 
  select total_services_subscribed,
       round(AVG(churn) * 100, 2) AS churn_rate_pct,
       COUNT(*) AS total_customers
FROM features_table
GROUP BY total_services_subscribed
ORDER BY total_services_subscribed;

 ----- top 1000 most valueable monthly customers who spend more than avg customer and are 
 ---- at high risk of churning
 select customerid,tenure, averagemonthlyspend ,contract_type , churn
 from features_table
 where churn='0' and contract_type='Month-To-Month' and averagemonthlyspend>(select avg(averagemonthlyspend)from features_table)
 order by averagemonthlyspend DESC  ;