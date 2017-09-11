clear all; close all; clc;

load('data/lift_only_raw.mat');
load('data/plate.mat');

ind=7;

obj.mu=0.84;
options.disc=12;
options.torque_scale=1;
options.augment_WC='hf';
props.task.type='gravity';
props.task.uncertainty.r=0;
props.task.uncertainty.n=0;

 [q s t]=evaluateLiftOnlyGrasp(data{ind}, obj, props,options);

