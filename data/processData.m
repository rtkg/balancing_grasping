function D=processData(dat)

F=weissFingerTip();
          
F_L_T= [0  0  1   0; %finger tip frame expressed in the left grasp frame
        0 -1  0   0;
        1  0  0 -36;
        0  0  0   1];

F_R_T= [0  0 -1   0; %finger tip frame expressed in the right grasp frame
        0  1  0   0;
        1  0  0 -36;
        0  0  0   1];


D.P_l.l=0; %link number ain't mattering for now
D.P_r.l=0;

D.P_l.res=2^12;% resolution of the tactile readings
D.P_r.res=2^12;% resolution of the tactile readings
D.P_l.dmax=85; %max taxel pressure [kPa]
D.P_r.dmax=85; %max taxel pressure [kPa]
D.P_l.tc=0.0038; %taxel length [m]
D.P_r.tc=0.0038; %taxel length [m]

ts_l=filterTactileReadings(dat.ts_l);
ts_r=filterTactileReadings(dat.ts_r);

D.P_l.d=ts_l(end,:); %store only the last of the filtered tactile readings
D.P_r.d=ts_r(end,:);

parent_frame_id='yumi_base_link';
D.O_W_T=blkdiag(zeros(3,3),1); %object frame expressed in the world (yumi_base_link) frame    
read_tf=false;
for i=size(dat.tf,2):-1:1
    if(read_tf)
        break;
    end
    for j=1:size(dat.tf(i).transforms,2)
        trfm=dat.tf(i).transforms(j);
        if strcmp('obj_frame',trfm.frame_id)
            assert(strcmp(parent_frame_id,trfm.parent_frame_id));
            D.O_W_T(1:3,1:3)=q2R(trfm.rotation);
            D.O_W_T(1:3,4)=trfm.translation;
            read_tf=true;
            break;
        end
    end   
end
assert(read_tf);
   
L_O_T=blkdiag(zeros(3,3),1); %grasp_l_frame expressed in the object frame
LF_O_T=blkdiag(zeros(3,3),1); %left fingertip frame expressed in the object frame
read_tf=false;
for i=size(dat.tf,2):-1:1
    if(read_tf)
        break;
    end
    for j=1:size(dat.tf(i).transforms,2)
        trfm=dat.tf(i).transforms(j);
        if strcmp('grasp_l_frame',trfm.frame_id)
            assert(strcmp(parent_frame_id,trfm.parent_frame_id));            
            L_O_T(1:3,1:3)=D.O_W_T(1:3,1:3)'*q2R(trfm.rotation);
            L_O_T(1:3,4)=trfm.translation-D.O_W_T(1:3,4);
            LF_O_T(1:3,1:3)=L_O_T(1:3,1:3)*F_L_T(1:3,1:3);
            LF_O_T(1:3,4)=L_O_T(1:3,1:3)*F_L_T(1:3,4)+L_O_T(1:3,4);
            
            D.P_l.p=LF_O_T(1:3,1:3)*F.p+repmat(LF_O_T(1:3,4),1,size(F.p,2));
            D.P_l.v=LF_O_T(1:3,1:3)*F.v+repmat(LF_O_T(1:3,4),1,size(F.v,2));
            D.P_l.n=LF_O_T(1:3,1:3)*F.n;
            D.P_l.f=F.f;
            D.P_l.P_O_T=L_O_T;
            
            read_tf=true;
            break;
        end
    end   
end
assert(read_tf);

R_O_T=blkdiag(zeros(3,3),1); %grasD.P_r_frame expressed in the object frame    
RF_O_T=blkdiag(zeros(3,3),1); %right fingertip frame expressed in the object frame
read_tf=false;
for i=size(dat.tf,2):-1:1
    if(read_tf)
        break;
    end
    for j=1:size(dat.tf(i).transforms,2)
        trfm=dat.tf(i).transforms(j);
        if strcmp('grasp_r_frame',trfm.frame_id)
            assert(strcmp(parent_frame_id,trfm.parent_frame_id));
            R_O_T(1:3,1:3)=D.O_W_T(1:3,1:3)'*q2R(trfm.rotation);
            R_O_T(1:3,4)=trfm.translation-D.O_W_T(1:3,4);
            RF_O_T(1:3,1:3)=R_O_T(1:3,1:3)*F_R_T(1:3,1:3);
            RF_O_T(1:3,4)=R_O_T(1:3,1:3)*F_R_T(1:3,4)+R_O_T(1:3,4);      
            
            D.P_r.p=RF_O_T(1:3,1:3)*F.p+repmat(RF_O_T(1:3,4),1,size(F.p,2));
            D.P_r.v=RF_O_T(1:3,1:3)*F.v+repmat(RF_O_T(1:3,4),1,size(F.v,2));
            D.P_r.n=RF_O_T(1:3,1:3)*F.n;
            D.P_r.f=F.f;
            D.P_r.P_O_T=R_O_T;
            
            read_tf=true;
            break;
        end
    end   
end

