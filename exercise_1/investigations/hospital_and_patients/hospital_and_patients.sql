
------ this is for the correlation between hopistal score and its rating ----
select covar_pop(avg_score,overall_rating) / (stddev_samp(avg_score)*stddev_samp(overall_rating)),
corr(avg_score,overall_rating)
from rating_and_performance_hospital;


------ this is for the correlation between hospital condition variability and its rating -----
select corr(procedure_count,overall_rating)
from
(select count(distinct condition)procedure_count , provider_id
from score_across_depat
group by provider_id) a 
inner join 
rating_and_performance_hospital b
on a.provider_id = b.provider_id
