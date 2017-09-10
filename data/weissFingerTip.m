function m=weissFingerTip()

%representation in the YuMi base frame for a closed gripper the texels are
%in the x/y plane, the normals along negative z.


m.p=zeros(3,32);
m.n=zeros(3,32);

l=19.6;
R=19.5;
b=3.8;
k=14.7;

phi1=b/R;
phi2=2*b/R;
phi3=3*b/R;

p1x=l+R*sin(phi1);
p2x=l+R*sin(phi2);
p3x=l+R*sin(phi3);
p1z=-R*(1-cos(phi1));
p2z=-R*(1-cos(phi2));
p3z=-R*(1-cos(phi3));

%taxel mid-points
ycord=[5.7 1.9 -1.9 -5.7];
m.p(:,1:4)=[repmat(p3x,1,4); ycord; repmat(p3z,1,4)];
m.p(:,5:8)=[repmat(p2x,1,4); ycord; repmat(p2z,1,4)];
m.p(:,9:12)=[repmat(p1x,1,4); ycord; repmat(p1z,1,4)];
xcord=repmat(l,1,4);
for i=4:8
m.p(:,4*i-3:4*i)=[xcord ;ycord ;zeros(1,4)];    
xcord=xcord-repmat(b,1,4);
end

%normals
m.n(:,1:4)=[repmat(sin(phi3),1,4); zeros(1,4); repmat(cos(phi3),1,4)];
m.n(:,5:8)=[repmat(sin(phi2),1,4); zeros(1,4); repmat(cos(phi2),1,4)];
m.n(:,9:12)=[repmat(sin(phi1),1,4); zeros(1,4); repmat(cos(phi1),1,4)];
m.n(:,13:32)=repmat([0; 0; 1],1,20);

%vertices
m.v=[];
for i=1:32
    m.v(:,end+1)=m.p(:,i)+[m.n(3,i);-1; -m.n(1,i)]*b/2;
    m.v(:,end+1)=m.p(:,i)+[m.n(3,i); 1; -m.n(1,i)]*b/2;
    m.v(:,end+1)=m.p(:,i)+[-m.n(3,i); 1; m.n(1,i)]*b/2;
    m.v(:,end+1)=m.p(:,i)+[-m.n(3,i); -1; m.n(1,i)]*b/2;
end    

m.f=zeros(4,32);
m.f(:,1)=[1; 2; 3; 4];
for i=2:32
       m.f(:,i)=[1; 2; 3; 4]+repmat(m.f(4,i-1),4,1);
end



