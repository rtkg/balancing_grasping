clear all; close all; clc;
font_size=12;

addpath('../');

load('../data/lift_only_20170905_results_cpa.mat');
res_cpa=lift_only_20170905_results;

load('../data/lift_only_20170905_results_va.mat');
res_va=lift_only_20170905_results;

[acc tpr fpr tnr fnr sr]=analyzeResults(res_cpa, 1.0);
y=[acc*100 sr*100 tpr*100 tnr*100 ];
[acc tpr fpr tnr fnr sr]=analyzeResults(res_va, 1.0);
y=[y; acc*100 sr*100 tpr*100 tnr*100 ]-50;

%%%%%%%%%%%%%%%%%%%%%% Accuracy bars  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b=bar(y); grid on;

set(b(1),'FaceColor','b');
set(b(2),'FaceColor','m');
set(b(3),'FaceColor','g');
set(b(4),'FaceColor','r');

ylabels={' 50'; ' 60'; ' 70'; ' 80'; ' 90'; '100'};
xlabels={'CPA'; 'VA'};
set(gca,'XTickLabel',xlabels);

h=legend('ACC','SR','TPR','TNR','Location','NorthEast');
set(h,'Interpreter','latex','FontSize',font_size);
ylabel('prediction rate [ \%]','interpreter','latex','FontSize',font_size);
h = get(gca,'ylabel');
set(h,'Position',get(h,'Position')+[-0.05 0 0]);
set(gca,'XTickLabel',{' '});
set(gca,'YTickLabel',{' '});
pos=[0.94 1.95];
for i=1:length(xlabels)
    text(pos(i),-3.5,0,xlabels(i),'Interpreter','Latex','fontsize',font_size);
end   
for i=1:length(ylabels)
    text(0.5,(i-1)*10,0,ylabels(i),'Interpreter','Latex','fontsize',font_size);
end
% disp(['Overall accuracy: ' num2str(mean(rqsqus)) ', true positives: ' num2str(mean(rqs)) [', true negatives: '] num2str(mean(rqus))]);
 ylim([0 50]); pbaspect([1.35,1,1]);

% %%%%%%%%%%%%%%%%%%%%%% saving  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gcf,'PaperPositionMode','auto')
print(gcf,'success_rates','-dpdf','-r450');

