elect state, 
       above_avg_score + above_seventyfive_score as overall_score_measure
       from state_measure
       where above_avg_days = 1
       order by overall_score_measure desc
       limit 10 ;
