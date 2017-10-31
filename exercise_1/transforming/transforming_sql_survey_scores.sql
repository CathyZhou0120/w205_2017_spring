


--- this is for creating the table survey, which contains each hospital's overall survey scores 
 
create  table survey_scores as
         select provider_number,
         hospital_name,
         state,
         cast(overall_rating_of_hospital_performance_rate as decimal(10,2))performance_rating,
         overall_rating_of_hospital_achievement_points ,
         overall_rating_of_hospital_improvement_points,
         cast(HCAHPS_consistency_score as int)HCAHPS_consistency_score
         from surveys_responses
         where overall_rating_of_hospital_performance_rate not like 'Not%'
         and overall_rating_of_hospital_achievement_points not like 'Not%'
         and overall_rating_of_hospital_improvement_points not like 'Not%'
         and HCAHPS_base_score not like 'Not%'
         and HCAHPS_consistency_score not like 'Not%'
         ;



