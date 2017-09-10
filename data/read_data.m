clear all; close all; clc;

data_path='/home/rkg/ros/kinetic_ws/src/yumi_demos/balancing_grasping/log/lift_only';
data_path_dir=dir(data_path);

isub=[data_path_dir(:).isdir];
folder_names={data_path_dir(isub).name}';
folder_names(ismember(folder_names,{'.','..'}))=[];

for i=1:size(folder_names,1)
    i
    data{i}.path=strcat(data_path,'/',folder_names{i});
    data{i}.contact=parseBagfile(fullfile(data_path, folder_names{i},'contact.bag'));
    data{i}.lift=parseBagfile(fullfile(data_path, folder_names{i},'lift.bag'));
    %balancing=parseBagfile(fullfile(data_path,exp_path,'balancing.bag'));
end
save('lift_only_raw.mat','data');


%load('data.mat');

% 
% m=weissFingerTip();
% 
% p=m.p;
% n=m.n;
% v=m.v;
% plot3(p(1,:),p(2,:),p(3,:),'ro','MarkerSize',4,'MarkerFaceColor','r'); hold on;
% 
% for i=1:32
%    plot3([p(1,i) p(1,i)-n(1,i)], [p(2,i) p(2,i)-n(2,i)], [p(3,i) p(3,i)-n(3,i)],'b','LineWidth',2 ); 
% end
% patch('Faces',m.f','Vertices',m.v','FaceAlpha',0.2);
% 
% xlabel('x'); ylabel('y'); zlabel('z');
% grid on; rotate3d on; axis equal;
