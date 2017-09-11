clear all; close all; clc;
%USE CENTERPOINT AUGMENTATION ONLY

load('data/lift_only_raw.mat');
load('data/plate.mat');

%results for centerpoint augmentation only
%acc = 0.7400; tpr = 0.5769; fpr = 0.0833; tnr = 0.9167; fnr = 0.4231; mean(t) = 0.002

%results for vertex augmentation
%acc = 0.8400; tpr =0.8462; fpr = 0.1667; tnr = 0.8333; fnr = 0.1538; mean(t)=0.0023

%====== OPTIONS =============
options.disc=12;
options.torque_scale=1;
options.augment_WC='hf';

%====== TASK =============
props.task.type='gravity';
props.task.uncertainty.r=0;
props.task.uncertainty.n=0;

n=size(data,2);

for i=1:n
  [q(i) s(i) t(i)]=evaluateLiftOnlyGrasp(data{i}, obj, props,options);
end    
lift_only_20170905_results.q=q;
lift_only_20170905_results.s=s;
lift_only_20170905_results.t=t;
lift_only_20170905_results.options=options;
lift_only_20170905_results.props=props;
lift_only_20170905_results.obj=obj;

save('data/lift_only_20170905_results_cpa.mat','lift_only_20170905_results');




 


