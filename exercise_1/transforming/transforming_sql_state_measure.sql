----- this is for answering question 2: which states have the high quality care

create table state_measure as 
select a.state, a.condition,
case when a.total_days >= b.avg_days then 1 else 0 end as above_avg_days,
case when a.avg_score_state >= c.avg_score then 1 else 0 end as above_avg_scores,
case when a.avg_score_state >= c.seventyfive_percentile_score then 1 else 0 end as above_seventyfive_score
from 
(select state, condition, avg(score)avg_score_state, sum(days)total_days
from 
(select distinct state, condition, score, 
cast(datediff(measure_end_date, measure_start_date) as bigint)days
from score_across_depat
where condition <> 'Pregnancy and Delivery Care'
and condition <> 'Heart Attack or Chest Pain' ) a
group by state, condition) a 
inner join 
(select percentile(cast(days as BIGINT),0.5)median_days, 
       avg(cast(days as BIGINT))avg_days,
       condition from 
(select distinct state, condition, 
       cast(datediff(measure_end_date,measure_start_date) as double)days
       from score_across_depat)a 
where condition <> 'Pregnancy and Delivery Care'
and condition <> 'Heart Attack or Chest Pain' 
group by condition) b
on a.condition = b.condition
inner join 
( select avg(score)avg_score,
percentile(cast(score as BIGINT),0.75)seventyfive_percentile_score, 
condition from score_across_depat 
where condition <> 'Pregnancy and Delivery Care'
and condition <> 'Heart Attack or Chest Pain' 
group by condition) c
on a.condition = c.condition

------- we are omitting pregnancy and delivery care  and heart attack or chest pain to to abnormal data points, which will likely skew the answer
