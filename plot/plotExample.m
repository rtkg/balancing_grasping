clear all; close all; clc;

addpath('../data');

load('lift_only_raw.mat');
load('plate.mat');
load('weiss_fingertip.mat');

ind=10;

C=processData(data{ind}.contact);
L=processData(data{ind}.lift);
P_l_=projectTactileData(C.P_l, C.P_l.tc, C.P_l.res, C.P_l.dmax);
P_r_=projectTactileData(C.P_r, C.P_r.tc, C.P_r.res, C.P_r.dmax);

plotPhalange(C.P_l);
plotPhalange(C.P_r);


options.EdgeColor='none';
options.FaceColor=[0.8 0.8 0.8];
options.FaceAlpha=0.1;
options.LineWidth=1;
plotObject(obj,eye(4),options);

T_obj=eye(4); T_obj(1:3,4)=[0; 0; 2.5];
drawFrame(T_obj,15);
drawFrame(P_l_.C,15);
drawFrame(P_r_.C,15);

% options.EdgeColor='k';
% options.FaceColor=[0.1 0.1 0.1];
% options.FaceAlpha=0.1;
% options.LineWidth=1;
% plotObject(weiss_fingertip,C.P_r.P_O_T,options);

axis equal; rotate3d on; axis off;
view(68,50); %above
set(gca,'box','off');
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
set(gcf,'PaperPositionMode','auto','PaperType','a0');
%print(gcf,'example','-dpdf', '-r0','-fillpage');
print(gcf,'example_1','-dpng', '-r900');

%plot the tactile data with the pressure center coordinate frame
figure(2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
set(gcf,'PaperPositionMode','auto','PaperType','a4');
plotPhalange(C.P_r);
drawFrame(P_r_.C,15);
view(0,90);
axis equal; axis off;
%print(gcf,'example_2','-dpng', '-r600');

%plot the tactile data withouth the pressure center coordinate frame
figure(3);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
set(gcf,'PaperPositionMode','auto','PaperType','a4');
plotPhalange(C.P_r);
view(0,90);
axis equal; axis off;
print(gcf,'example_3','-dpng', '-r600');
