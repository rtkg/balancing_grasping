function plotObject(obj,T,options)
%obj ... object to plot
%T ... transform to be applied befor visualizing


fv.vertices=[T(1:3,1:3)*obj.pts'+repmat(T(1:3,4),1,size(obj.pts,1))]';
fv.faces=obj.faces;

patch(fv,'EdgeColor',options.EdgeColor,'FaceColor', options.FaceColor,'FaceAlpha',options.FaceAlpha','LineWidth',options.LineWidth,'DiffuseStrength',1,...
    'AmbientStrength',1,'BackFaceLighting','lit','FaceLighting','gouraud'); axis equal; rotate3d on;

% fv=stlread(file);   
% fv.vertices=[T(1:3,1:3)*fv.vertices'+repmat(T(1:3,4),1,size(fv.vertices,1))]';
% patch(fv,'EdgeColor','k','FaceColor', [0.8 0.8 1.0],'FaceAlpha',0.1','LineWidth',0.1,'DiffuseStrength',1,...
%     'AmbientStrength',1,'BackFaceLighting','lit','FaceLighting','gouraud'); axis equal; rotate3d on;
% 
