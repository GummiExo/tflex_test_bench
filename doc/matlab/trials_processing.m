clear all; clc; close all;
addpath('./src')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  TENDONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Tendons FlexExtension 5N

cd data/step_response/
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/step_response.bag';
data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/step_response2.bag';
% data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/step_response3.bag';
% data_analysis(trials_dir);
cd ../../

cd data/chirp_response/
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/chirp_response3.bag';
data_analysis(trials_dir);
cd ../../

cd data/model/
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/model_response.bag';
data_analysis(trials_dir);
cd ../../

%%  Tendons FlexExtension 10N

cd data/step_response/
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/step_response.bag';
data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/step_response2.bag';
% data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/step_response3.bag';
% data_analysis(trials_dir);
cd ../../

cd data/chirp_response/
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/chirp_response3.bag';
data_analysis(trials_dir);
cd ../../

cd data/model/
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/10N/model_response.bag';
data_analysis(trials_dir);
cd ../../
%%  Tendons FlexExtension 20N

cd data/step_response/
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/step_response.bag';
data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/step_response2.bag';
% data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/step_response3.bag';
% data_analysis(trials_dir);
cd ../../

cd data/chirp_response/
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/chirp_response3.bag';
data_analysis(trials_dir);
cd ../../

cd data/model/
trials_dir = '../../../tflex_trials/Tendons/FlexExte/Equal_Pretension/20N/model_response.bag';
data_analysis(trials_dir);
cd ../../

%%  Tendons Stiffness 5N

cd data/step_response/
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/step_response.bag';
data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/step_response2.bag';
% data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/step_response3.bag';
% data_analysis(trials_dir);
cd ../../

cd data/chirp_response/
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/5N/chirp_response3.bag';
data_analysis(trials_dir);
cd ../../

%%  Tendons Stiffness 10N

cd data/step_response/
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/step_response.bag';
data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/step_response2.bag';
% data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/step_response3.bag';
% data_analysis(trials_dir);
cd ../../

cd data/chirp_response/
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/10N/chirp_response3.bag';
data_analysis(trials_dir);
cd ../../

%%  Tendons Stiffness 20N

cd data/step_response/
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/step_response.bag';
data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/step_response2.bag';
% data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/step_response3.bag';
% data_analysis(trials_dir);
cd ../../

cd data/chirp_response/
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Tendons/Stiffness/Equal_Pretension/20N/chirp_response3.bag';
data_analysis(trials_dir);
cd ../../

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%  RIGID FILAMENTS AND TENDONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Rigid Filaments and Tendons FlexExtension 5N

cd data/step_response/
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/step_response.bag';
data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/step_response2.bag';
% data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/step_response3.bag';
% data_analysis(trials_dir);
cd ../../

cd data/chirp_response/
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/chirp_response3.bag';
data_analysis(trials_dir);
cd ../../

cd data/model/
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/5N/model_response.bag';
data_analysis(trials_dir);
cd ../../

%%  Rigid Filaments and Tendons FlexExtension 10N

cd data/step_response/
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/step_response.bag';
data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/step_response2.bag';
% data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/step_response3.bag';
% data_analysis(trials_dir);
cd ../../

cd data/chirp_response/
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/chirp_response3.bag';
data_analysis(trials_dir);
cd ../../

cd data/model/
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/10N/model_response.bag';
data_analysis(trials_dir);
cd ../../

%%  Rigid Filaments and Tendons FlexExtension 20N

cd data/step_response/
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/step_response.bag';
data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/step_response2.bag';
% data_analysis(trials_dir);
% trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/step_response3.bag';
% data_analysis(trials_dir);
cd ../../

cd data/chirp_response/
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/chirp_response.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/chirp_response2.bag';
data_analysis(trials_dir);
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/chirp_response3.bag';
data_analysis(trials_dir);
cd ../../

cd data/model/
trials_dir = '../../../tflex_trials/Rigid_and_Tendons/FlexExte/Equal_Pretension/20N/model_response.bag';
data_analysis(trials_dir);
cd ../../