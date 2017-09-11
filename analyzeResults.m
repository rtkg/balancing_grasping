function [acc tpr fpr tnr fnr]=analyzeResults(res, db)
%res ... n results 
%db ... scalar decision boundary on res.q
%--------------------------------
%acc ... prediction accuracy (see https://en.wikipedia.org/wiki/Sensitivity_and_specificity)
%tpr ... true positive rate
%fpr ... false positive rate
%tnr ... true negative rate
%fnr ... false negative rate

n=numel(res.q);

[dummy ind_p]=find(res.s); %indices of positive grasps
[dummy ind_n]=find(res.s == 0); %indices of negative grasps

%find true indices of the true positive samples under the given decision boundary
ind_tp=[];
ind_tn=[];
ind_fp=[];
ind_fn=[];
for i=1:n
   if(res.s(i) == true) 
       %successful grasp
       if(res.q(i) >= db)
           %true positive
           ind_tp(end+1)=i;
       else
           %false negative
           ind_fn(end+1)=i;
       end
   else
      %failed grasp
      if(res.q(i) < db)
          %true negative
          ind_tn(end+1)=i;
      else
          %false positive
          ind_fp(end+1)=i;
      end
      
   end
end

tpr=numel(ind_tp)/numel(ind_p);
tnr=numel(ind_tn)/numel(ind_n);
fpr=1-tnr;
fnr=1-tpr;
acc=(numel(ind_tp)+numel(ind_tn))/(numel(ind_tp)+numel(ind_fp)+numel(ind_fn)+numel(ind_tn));
