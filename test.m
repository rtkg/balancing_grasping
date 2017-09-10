clear all; close all; clc;

load('data/lift_only_raw.mat');
load('data/plate.mat');

ind=8;
C=processData(data{ind}.contact);
L=processData(data{ind}.lift);

P_l_=projectTactileData(C.P_l, C.P_l.tc, C.P_l.res, C.P_l.dmax);
P_r_=projectTactileData(C.P_r, C.P_r.tc, C.P_r.res, C.P_r.dmax);

N0=3;
obj.mu=0.84;
options.disc=12;
options.torque_scale=1;
options.augment_WC='hf';
props.task.type='gravity';
props.task.uncertainty.r=0;
props.task.uncertainty.n=0;

GW(1).W=getContactWrenches(P_l_,N0,obj,options); 
GW(2).W=getContactWrenches(P_r_,N0,obj,options); 

T=gravityTask(C.O_W_T,obj,options,props);
[q t]=graspQuality(GW,T);

if(sum(L.P_l.d(end,:)) > 1e3 &&   sum(L.P_r.d(end,:)) > 1e3)
    'success'
else
    'failure'
end
q

plotPhalange(C.P_l);
plotPhalange(C.P_r);
drawFrame(eye(4),10,'O');
drawFrame(P_l_.C,10,'C');
drawFrame(P_r_.C,10,'C');

v1=P_l_.C(1:3,4);
v2=P_r_.C(1:3,4);
plot3([v1(1) v2(1)],[v1(2) v2(2)], [v1(3) v2(3)]);

%FOR IND == 8 FALSE NEGATIVE ==================
 v2=[  17.6335  150.0891   -0.0191];
 v1=[ -16.1660 -138.5967   -0.0292];
 plot3([v1(1) v2(1)],[v1(2) v2(2)], [v1(3) v2(3)]);
 %FOR IND == 8 FALSE NEGATIVE END ==============
 
%plotSTL('data/box.STL',eye(4));
 axis equal; rotate3d on;

% subplot(2,2,1);
% plot(data{ind}.contact.ts_l); hold on;
% plot(ts_l);
% 
% subplot(2,2,2);
% plot(data{ind}.contact.ts_r); hold on;
% plot(ts_r);
% 
% ts_l=filterTactileReadings(data{ind}.lift.ts_l);
% ts_r=filterTactileReadings(data{ind}.lift.ts_r);
% 
% subplot(2,2,3);
% plot(data{ind}.lift.ts_l); hold on;
% plot(ts_l);
% 
% subplot(2,2,4);
% plot(data{ind}.lift.ts_r); hold on;
% plot(ts_r);
% 
%  
% if(sum(ts_l(end,:)) > 1e3 &&   sum(ts_r(end,:)) > 1e3)
%     'success'
% else
%     'failure'
% end