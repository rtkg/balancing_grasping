clear all; close all; clc;

data_path='/home/rkg/ros/amici_ws/src/yumi_demos/balancing_grasping/log/';

exp_path='/exp_1504258725';

tic
contact=parseBagfile(fullfile(data_path,exp_path,'contact.bag'));
lift=parseBagfile(fullfile(data_path,exp_path,'lift.bag'));
balancing=parseBagfile(fullfile(data_path,exp_path,'balancing.bag'));
toc