select count(distinct condition)condition_count, hospital_name
       from condition_hospital_measure
       where above_seventyfive_score = 1
       and above_avg_days = 1
       group by hospital_name
       order by condition_count desc
       limit 10 ; 
