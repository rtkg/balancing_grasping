function [q s t]=evaluateLiftOnlyGrasp(G, obj, props,options)

C=processData(G.contact);
L=processData(G.lift);
P_l_=projectTactileData(C.P_l, C.P_l.tc, C.P_l.res, C.P_l.dmax);
P_r_=projectTactileData(C.P_r, C.P_r.tc, C.P_r.res, C.P_r.dmax);

T=gravityTask(C.O_W_T,obj,options,props);

GW(1).W=getContactWrenches(P_l_, C.P_l.N0,obj,options); 
GW(2).W=getContactWrenches(P_r_, C.P_r.N0,obj,options); 

tic;
[q t]=graspQuality(GW,T);
t=toc;

if(sum(L.P_l.d(end,:)) > 1e3 &&   sum(L.P_r.d(end,:)) > 1e3)
    s=true;
else
    s=false;
end

% plotPhalange(C.P_l);
% plotPhalange(C.P_r);
% drawFrame(eye(4),10,'O');
% drawFrame(P_l_.C,10,'C');
% drawFrame(P_r_.C,10,'C');
% 
% v1=P_l_.C(1:3,4);
% v2=P_r_.C(1:3,4);
% plot3([v1(1) v2(1)],[v1(2) v2(2)], [v1(3) v2(3)]);

%FOR IND == 8 FALSE NEGATIVE ==================
%  v2=[  17.6335  150.0891   -0.0191];
%  v1=[ -16.1660 -138.5967   -0.0292];
%  plot3([v1(1) v2(1)],[v1(2) v2(2)], [v1(3) v2(3)]);
 %FOR IND == 8 FALSE NEGATIVE END ==============
 
%plotSTL('data/box.STL',eye(4));
 %axis equal; rotate3d on;