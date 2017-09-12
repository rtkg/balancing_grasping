function plotROCCurve(res)

font_size = 10;

addpath('../');

ev=0:0.01:10;
for i=1:numel(ev)
    [acc(i) tpr(i) fpr(i) tnr(i) fnr(i) sr(i)]=analyzeResults(res, ev(i));
end

[u v]=find(fpr<0.05); %find the 5% fpr success rate
tpr_5=tpr(v(1));
tpr_db_1=tpr(find(ev==1));
fpr_db_1=fpr(find(ev==1));
msg=['ROC AUC: ',num2str(trapz(fpr,-tpr)), ' | succes rate: ', num2str(tpr_db_1/(tpr_db_1+fpr_db_1)), ' | success rate 5%: ', num2str(tpr_5/(tpr_5+0.05)), ', at decision boundary: ',num2str(ev(v(1)))];
disp(msg);

%%%%%%%%%%%%%%%%%% plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(fpr*100,tpr*100,'LineWidth',3);
axis([0 100 0 100]);grid on; %axis equal;
ylabel('true positive rate [ \%]','interpreter','latex','FontSize',font_size);
h = get(gca,'ylabel');
set(h,'Position',get(h,'Position')+[0 -0.05 0]);
xlabel('false positive rate [ \%]','interpreter','latex','FontSize',font_size);
h = get(gca,'xlabel');
set(h,'Position',get(h,'Position')+[-0.05 0 0]);

set(gca,'XTickLabel',{' '});
set(gca,'YTickLabel',{' '});
labels={'  0'; ' 20'; ' 40'; ' 60'; ' 80'; '100'};
for i=1:length(labels)
    text(-6,(i-1)*20,0,labels(i),'Interpreter','Latex','fontsize',font_size);
    if i==1
        continue
    end
    text((i-1)*20-3,-3,0,labels(i),'Interpreter','Latex','fontsize',font_size);
end
pbaspect([1.5,1,1]);

%%%%%%%%%%%%%%%%%%%%%% saving  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gcf,'PaperPositionMode','auto')
print(gcf,'roc_curve','-dpdf','-r450');
