clear all; close all; clc;

load('../data/lift_only_20170905_results_mx.mat');
res_mx=lift_only_20170905_results;

load('../data/lift_only_20170905_results_mux.mat');
res_mux=lift_only_20170905_results;

font_size = 10;


for i=1:size(res_mx,2)
    [acc(i) tpr(i) fpr(i) tnr(i) fnr(i) sr(i)]=analyzeResults(res_mx(i), 1.0);
    m(i)=res_mx(i).obj.m;
end

plot(m,acc,'b-','LineWidth',1.5); hold on;
plot(m,tpr,'g-','LineWidth',1.5);
plot(m,tnr,'r-','LineWidth',1.5);

return;

%subsampling for markers
% ind=linspace(1,100,10);
% 
% plot(r(ind(2:end-1)),rqsqus(ind(2:end-1)),'b-*','LineWidth',1.5,'MarkerSize',6,'MarkerFaceColor','b');
% plot(r(ind(2:end-1)),rqs(ind(2:end-1)),'g-d','LineWidth',1.5,'MarkerSize',6,'MarkerFaceColor','g');
% plot(r(ind(2:end-1)),rqus(ind(2:end-1)),'r-v','LineWidth',1.5,'MarkerSize',6,'MarkerFaceColor','r');
% 
% 
% 
% h=legend(' classification accuracy ',' true positive rate',' true negative rate','Location','SouthWest');
% set(h,'Interpreter','latex','FontSize',font_size);
% plot(r(ind),rqsqus(ind),'b-','LineWidth',1.5);
% plot(r(ind),rqs(ind),'g-','LineWidth',1.5);
% plot(r(ind),rqus(ind),'r-','LineWidth',1.5);
% 
% ylabel('prediction rate [ \%]','interpreter','latex','FontSize',font_size);
% h = get(gca,'ylabel');
% set(h,'Position',get(h,'Position')+[-0.75 0 0]);
% xlabel('$\sigma$ [mm]','interpreter','latex','FontSize',font_size);
% h = get(gca,'xlabel');
% set(h,'Position',get(h,'Position')+[-0.05 -8 0]);
% 
% set(gca,'XTickLabel',{' '});
% set(gca,'YTickLabel',{' '});
% xlabels={' 0'; ' 5'; '10'; '15'; '20'; '25'; '30'};
% ylabels={'  45'; ' 50'; ' 55'; ' 60'; ' 65'; ' 70'; ' 75'; ' 80'; ' 85'; ' 90'; ' 95'};
% 
% for i=1:length(xlabels)
%     text(str2num(xlabels{i})-0.45,str2num(ylabels{1})-2.5,0,xlabels{i},'Interpreter','Latex','fontsize',font_size);
% end    
% for i=1:length(ylabels)
%     text(-1.65,str2num(ylabels{i}),0,ylabels{i},'Interpreter','Latex','fontsize',font_size);
% end    
% ylim([45 95]); pbaspect([1.8,1,1])
% 
% 
% %%%%%%%%%%%%%%%%%%%%%% saving  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set(gcf,'PaperPositionMode','auto')
% print(gcf,'sensitivity','-dpdf','-r450');
