clear all; close all; clc;
font_size=12;

load('../data/lift_only_20170905_results_cpa.mat');
q_cpa=lift_only_20170905_results.q;

load('../data/lift_only_20170905_results_va.mat');
q_va=lift_only_20170905_results.q;

subplot(1,2,1);
histogram(q_cpa,15,'FaceColor','g');
pbaspect([1,1,1]);
xlabel('$q$ ','interpreter','latex','FontSize',font_size);
ylabel('number of grasps ','interpreter','latex','FontSize',font_size);
subplot(1,2,2);
histogram(q_va,15,'FaceColor','b');
pbaspect([1,1,1]);
xlabel('$q$ ','interpreter','latex','FontSize',font_size);
ylabel('number of grasps ','interpreter','latex','FontSize',font_size);

%%%%%%%%%%%%%%%%%%%%%% saving  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gcf,'PaperPositionMode','auto')
print(gcf,'quality','-dpdf','-r450');

