clear all; close all; clc;
%VARY OBJECT MASS

load('data/lift_only_raw.mat');
load('data/plate.mat');
%evaluate experiments while varying mass

%====== OPTIONS =============
options.disc=12;
options.torque_scale=1;
options.augment_WC='hf_vertex';

%====== TASK =============
props.task.type='gravity';
props.task.uncertainty.r=0;
props.task.uncertainty.n=0;

n=size(data,2);
m=obj.m; %the actual mass of the object
disc=0.1:0.05:3; %factor to vary the actual mass

for k=1:length(disc)
    obj.m=m*disc(k);
    for i=1:n
        [q(i) s(i) t(i)]=evaluateLiftOnlyGrasp(data{i}, obj, props,options);
    end
    lift_only_20170905_results(k).q=q;
    lift_only_20170905_results(k).s=s;
    lift_only_20170905_results(k).t=t;
    lift_only_20170905_results(k).options=options;
    lift_only_20170905_results(k).props=props;
    lift_only_20170905_results(k).obj=obj;
    
end
save('data/lift_only_20170905_results_mx.mat','lift_only_20170905_results');




 


