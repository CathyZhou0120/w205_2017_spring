
--- condition that is emergency related are omitted since they have none numerical score results 

create table score_across_depat as 
select provider_id,
       hospital_name,
       state,
       condition,
       measure_id,
       measure_name,
       cast(score as float)score,
       cast(concat(substr(measure_start_date,7,4),
       '-',
       substr(measure_start_date,1,2),
       '-',
       substr(measure_start_date,4,2)
       )
as date) as measure_start_date,
       cast(concat(substr(measure_end_date,7,4),
       '-',
       substr(measure_end_date,1,2),
       '-',
       substr(measure_end_date,4,2)
       )
as date) as measure_end_date
from effective_care
where condition not like 'Emergency%'
and score not like 'Not%' 
;


