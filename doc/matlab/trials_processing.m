clear all; clc; close all;
addpath('./src')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  TENDONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Tendons FlexExtension 5N

trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/step_response.bag';
r = data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/step_response2.bag';
r = data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/step_response3.bag';
r = data_analysis(trials_dir);

 trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/chirp_response.bag';
 data_analysis(trials_dir);
 trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/chirp_response2.bag';
 data_analysis(trials_dir);
 trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/chirp_response3.bag';
 data_analysis(trials_dir);

%%  Tendons FlexExtension 10N

data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/step_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/step_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/step_response3.bag';
data_analysis(trials_dir);

trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/chirp_response3.bag';
data_analysis(trials_dir);

%%  Tendons FlexExtension 20N

trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/step_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/step_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/step_response3.bag';
data_analysis(trials_dir);

trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/chirp_response3.bag';
data_analysis(trials_dir);

%%  Tendons Stiffness 5N

trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/step_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/step_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/step_response3.bag';
data_analysis(trials_dir);

trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/chirp_response3.bag';
data_analysis(trials_dir);

%%  Tendons Stiffness 10N

trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/step_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/step_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/step_response3.bag';
data_analysis(trials_dir);

trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/chirp_response3.bag';
data_analysis(trials_dir);

%%  Tendons Stiffness 20N

trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/step_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/step_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/step_response3.bag';
data_analysis(trials_dir);

trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/chirp_response3.bag';
data_analysis(trials_dir);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%  RIGID FILAMENTS AND TENDONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Rigid Filaments and Tendons FlexExtension 5N

trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/step_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/step_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/step_response3.bag';
data_analysis(trials_dir);

trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/chirp_response3.bag';
data_analysis(trials_dir);

%%  Rigid Filaments and Tendons FlexExtension 10N

trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/step_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/step_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/step_response3.bag';
data_analysis(trials_dir);

trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/chirp_response3.bag';
data_analysis(trials_dir);

%%  Rigid Filaments and Tendons FlexExtension 20N

trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/step_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/step_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/step_response3.bag';
data_analysis(trials_dir);

trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/chirp_response3.bag';
data_analysis(trials_dir);