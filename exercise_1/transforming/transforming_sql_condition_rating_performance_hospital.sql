------- this is for ansering question 4: is there correlation between rating and survey ?

create table rating_and_performance_hospital as
select a.provider_id, a.avg_score, b.overall_rating
from
(select  provider_id, sum(score)/count(condition) avg_score from 
(select distinct provider_id, score, condition
from score_across_depat
where condition <> 'Pregnancy and Delivery Care'
and condition <> 'Heart Attack or Chest Pain' ) a
group by provider_id) a 
inner join 
(select distinct Provider_Number, cast(overall_rating_of_hospital_performance_rate as double) overall_rating
from surveys_responses
where overall_rating_of_hospital_performance_rate <> 'Not Available') b
on a.provider_id = b.provider_number;


