clear all; close all; clc;
%VARY FRICTION COEFFICIENT

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
m=[obj.m-0.3 obj.m obj.m+0.3];
mu=[obj.mu-0.5 obj.mu obj.mu+0.5];

count=1;
for k=1:length(m)
    for j=1:length(mu)
        obj.mu=mu(j);
        obj.m=m(k);
        for i=1:n
            [q(i) s(i) t(i)]=evaluateLiftOnlyGrasp(data{i}, obj, props,options);
        end
        lift_only_20170905_results(count).q=q;
        lift_only_20170905_results(count).s=s;
        lift_only_20170905_results(count).t=t;
        lift_only_20170905_results(count).options=options;
        lift_only_20170905_results(count).props=props;
        lift_only_20170905_results(count).obj=obj;
        
        count=count+1;
    end
end
save('data/lift_only_20170905_results_mxmux.mat','lift_only_20170905_results');




 


