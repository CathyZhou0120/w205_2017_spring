------ this is for answering question 3, which procedure has the greatest variability between hospitals?

create table condition_variability_measure as 
select a.condition, a.variance, b.range, c.stdv_score
from (
select condition, variance(score)variance
from 
(select distinct hospital_name, score, condition
from score_across_depat
) a
group by condition) a
inner join 
(select condition, (max(score) - min(score)) as range
from 
(select distinct hospital_name, score, condition
from score_across_depat
) a
group by condition) b
on a.condition = b.condition
inner join 
(select condition, stddev_samp(score)stdv_score
from 
(select distinct hospital_name, score, condition
from score_across_depat
) a
group by condition) c
on a.condition = c.condition 
;
