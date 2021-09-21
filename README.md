# mbl_edbi_manuscript_v2
 Code for the manuscript - "The effect of body image dissatisfaction on goal-directed decision making in a population marked by negative appearance beliefs and disordered eating"
 
 ## process_raw_data
 Contains code for preprocessing raw behavioural and questionnaire data - raw data is read from a local encrypted USB drive. Processed data can be found in the 'processed' folder.

- 'process_task.m' is used to do initial behavioural data pre-processing and to exclude participants as per exclusion criteria in the paper 
- 'process_qs.m' processes the questionnaire data from Qualtrics
- 'combine_qs_task.m' - combines the task and qs data together
 
 ## report_analysis
- 'report_analysis.m' is used to run simple two t-tests on behavioural and qs data, as well as plot all the figures from the paper - (estimated parameters, stay probabilities, MB scores, correlation plots)
 
 ## R_stan_fit
- used to fit parameters to the data; 'foerde_alter_model.stan' contain the Rstan RL model, while the 'fit_data.R' operates the Stan files to fill all groups and conditions separately
- there is also code to simulate behavioural data in the 'simulate_data' folder
- parameter recovery analysis files are 'parameter_recovery.R' that is based on the .Stan file and 'simulate_data_foerde_alter_model.R that generates data based on a set of parameters
 
 ## task_online
- contains online behavioural task from PsychoPy in JavaScript 

 ## R_results_analysis
- contains code for logistic regression analysis of collected and simulated raw choice data and linear regression of estimated parameters
  
