function plotSTL(file,T)
%file ... string containing the stl file path
%T ... transform to be applied befor visualizing

fv=stlread(file);   
fv.vertices=[T(1:3,1:3)*fv.vertices'+repmat(T(1:3,4),1,size(fv.vertices,1))]';
patch(fv,'EdgeColor','k','FaceColor', [0.8 0.8 1.0],'FaceAlpha',0.1','LineWidth',0.1,'DiffuseStrength',1,...
    'AmbientStrength',1,'BackFaceLighting','lit','FaceLighting','gouraud'); axis equal; rotate3d on;


