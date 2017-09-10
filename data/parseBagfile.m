function data=parseBagfile(path)

data = [];

bag = rosbag(path);

ts_r = readMessages(select(bag,'Topic','/ts_r'));
ts_l = readMessages(select(bag,'Topic','/ts_l'));
tf = readMessages(select(bag,'Topic','/tf'));
js = readMessages(select(bag,'Topic','/joint_states'));


n=size(ts_r,1);
data.ts_r=zeros(n,32);
for i=1:n
   data.ts_r(i,:)=ts_r{i}.Data'; 
end

n=size(ts_l,1);
data.ts_l=zeros(n,32);
for i=1:n
   data.ts_l(i,:)=ts_l{i}.Data'; 
end

n=size(js,1);
data.js.p=zeros(n,18);
data.js.v=zeros(n,18);
data.js.e=zeros(n,18);
data.js.names=js{1}.Name;

for i=1:n
   data.js.p(i,:)=js{i}.Position';
   data.js.v(i,:)=js{i}.Velocity';
   data.js.e(i,:)=js{i}.Effort';
end

n=size(tf,1);
for i=1:n
    m=size(tf{i}.Transforms);
    for j=1:m
       data.tf(i).transforms(j).parent_frame_id=tf{i}.Transforms(j).Header.FrameId;
       data.tf(i).transforms(j).frame_id=tf{i}.Transforms(j).ChildFrameId;
       data.tf(i).transforms(j).translation = [tf{i}.Transforms(j).Transform.Translation.X; tf{i}.Transforms(j).Transform.Translation.Y; tf{i}.Transforms(j).Transform.Translation.Z]*1000; %length units are mm to keep in line with previous implementations
       data.tf(i).transforms(j).rotation =[tf{i}.Transforms(j).Transform.Rotation.W; tf{i}.Transforms(j).Transform.Rotation.X; tf{i}.Transforms(j).Transform.Rotation.Y; tf{i}.Transforms(j).Transform.Rotation.Z];
    end
end