------- this is for answering question 1: which hospitals have the highest quality care with consistency?

create table condition_hospital_measure as 
select a.hospital_name, a.condition,
case when a.total_days >= b.avg_days then 1 else 0 end as above_avg_days,
case when a.avg_score_hospital_name >= c.avg_score then 1 else 0 end as above_avg_scores,
case when a.avg_score_hospital_name >= c.seventyfive_percentile_score then 1 else 0 end as above_seventyfive_score
from 
(select hospital_name, condition, avg(score)avg_score_hospital_name, sum(days)total_days
from 
(select distinct hospital_name, condition, score, 
cast(datediff(measure_end_date, measure_start_date) as bigint)days
from score_across_depat ) a
group by hospital_name, condition) a 
inner join 
(select percentile(cast(days as BIGINT),0.5)median_days, 
       avg(cast(days as BIGINT))avg_days,
       condition from 
(select distinct hospital_name, condition, 
       cast(datediff(measure_end_date,measure_start_date) as double)days
       from score_across_depat)a 
group by condition) b
on a.condition = b.condition
inner join 
( select avg(score)avg_score,
percentile(cast(score as BIGINT),0.75)seventyfive_percentile_score, 
condition from score_across_depat 
group by condition) c
on a.condition = c.condition
