select state
       from state_measure
       where above_avg_days = 1
       and above_seventyfive_score = 1
       limit 10 ;

