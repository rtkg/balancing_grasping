function plotPhalange(P)

p=P.p;
n=P.n;
v=P.v;
f=P.f;

%plot center points
plot3(p(1,:),p(2,:),p(3,:),'ko','MarkerSize',1,'MarkerFaceColor','k'); hold on;

%plot normals
% for i=1:size(p,2)
%    plot3([p(1,i) p(1,i)-n(1,i)], [p(2,i) p(2,i)-n(2,i)], [p(3,i) p(3,i)-n(3,i)],'b','LineWidth',2 ); 
% end

%patch taxels
cmap=mycolor(0);
for i=1:size(f,2)
    col=getcolor(cmap,P.d(i),P.res);
    patch('Faces',f(:,i)','Vertices',v','FaceAlpha',1.0,'FaceColor',col);
end



drawFrame(P.P_O_T,10,'P');

