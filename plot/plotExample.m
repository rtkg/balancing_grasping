clear all; close all; clc;

load('data/lift_only_raw.mat');
load('data/plate.mat');

ind=6;


C=processData(data{ind}.contact);
L=processData(data{ind}.lift);
P_l_=projectTactileData(C.P_l, C.P_l.tc, C.P_l.res, C.P_l.dmax);
P_r_=projectTactileData(C.P_r, C.P_r.tc, C.P_r.res, C.P_r.dmax);

plotPhalange(C.P_l);
plotPhalange(C.P_r);
drawFrame(eye(4),15);
drawFrame(P_l_.C,15);
drawFrame(P_r_.C,15);
plotObject(obj,eye(4));

view(78, 55);axis equal; rotate3d on; axis off;
set(gca,'box','off');
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
set(gcf,'PaperPositionMode','auto','PaperType','a0');
print(gcf,'example','-dpdf', '-r0','-fillpage');