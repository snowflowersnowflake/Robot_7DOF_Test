clear all
close all
clc


%�T�w�Ѽ�
DEF_RIGHT_HAND=1;
DEF_LEFT_HAND=2;

DEF_TYPE_STOP=1;
DEF_TYPE_LINE=2;
DEF_TYPE_ARC=3;

DEF_FRAME_UPDATE=1;
DEF_FRAME_KEEP=2;

L0=225;   %�Y��ӻH
L1=250;   %L�� ����
L2=25;    %L�� �u��
L3=25;    %L�� �u��
L4=230;   %L�� ���� 
L5=210;   %��end-effector

x_base_R=0;   %����I
y_base_R=0;
z_base_R=0;

x_base_L=0;   %����I
y_base_L=0;
z_base_L=0;


%% ����ɶ��Эp�ΰ_�l�I�W�� %%
%�_�l�I
i=1;
S_INITIAL=i;
SeqItv(i)=0;

%�k�⧨ ���⧨
i=i+1;
S_R_HOLD_L_HOLD_1=i;
SeqItv(i)=2;

%�k�⩹��X 140 ���⩹��X 140 
i=i+1;
S_R_FX_L_FX=i;
SeqItv(i)=5;

%�k�⤣�� ����}1
i=i+1;
S_R_KEEP_L_REL_1=i;
SeqItv(i)=2;

%�k�⤣�� ���⩹��X 180
i=i+1;
S_R_KEEP_L_FX=i;
SeqItv(i)=5;

%�k�⤣�� ���⧨1
i=i+1;
S_R_KEEP_L_HOLD_1=i;
SeqItv(i)=2;

%�k����੹��X ������੹�tX
i=i+1;
S_R_FCIRX_L_BCIRX=i;
SeqItv(i)=5;

%�k��} ���⤣��
i=i+1;
S_R_REL_L_HOLD_1=i;
SeqItv(i)=2;

%�k�⩹X�t  ���⤣�� 
i=i+1;
S_R_BX_L_KEEP_1=i;
SeqItv(i)=10;

%==����ɶ��Эp==
CurT=0;
for i=1:1:size(SeqItv,2)
    CurT=CurT+SeqItv(i);
    Seqt(i)=CurT;
end
TotalTime=CurT;

DEF_CYCLE_TIME=0.5;


Pcnt=1;%��X�`��

  
%�w�I�b���u���Шt��m    
Needle_RobotF=[370 -340 0];
Needle_ini_Plate=[70 -70 0];
Neddle_current_plate=Needle_ini_Plate;
TranFrameToRobot=Needle_RobotF-Needle_ini_Plate;

%�|�ӧ����I�y�Цb�[�l�y�Шt ���W�A�k�W�A�k�U�A���U
% Corner_PlateF=[   90 90 0;
%                     90 -90 0;
%             -100+10 -100+10 0;
%                 -90 90 0]

% for i=1:1:4        
%     Corner_RobotF(i,1:3)=Corner_PlateF(i,1:3)+TranFrameToRobot
% end

%�k���P���|
ini_rotate_p_R=[-90 -90 0]+[140 0 0]+TranFrameToRobot;%��x��V�e�i140 �q�[�l���Шt�����u�y�Шt
rR=sqrt((ini_rotate_p_R(1)-Needle_RobotF(1))^2+(ini_rotate_p_R(2)-Needle_RobotF(2))^2);
ini_rad_R=pi+atan((ini_rotate_p_R(2)-Needle_RobotF(2))/(ini_rotate_p_R(1)-Needle_RobotF(1)));%����ɪ��_�l���ਤ��

%�����P���|
ini_rotate_p_L=[90 90 0]+[140 0 0]+TranFrameToRobot;%��x��V�e�i140
rL=sqrt((ini_rotate_p_L(1)-Needle_RobotF(1))^2+(ini_rotate_p_L(2)-Needle_RobotF(2))^2);
ini_rad_L=atan((ini_rotate_p_L(2)-Needle_RobotF(2))/(ini_rotate_p_L(1)-Needle_RobotF(1)));

HoldLen_L=[180 0 0];%�������I���Z
HoldLen_R=[180 0 0];%�������I���Z


%%
R_p_robotF=zeros(size(SeqItv,2),9);
L_p_robotF=zeros(size(SeqItv,2),9);

R_p_robotF(S_INITIAL,:)=[[-90 -90 0]+TranFrameToRobot  50 -90 0 -50 DEF_TYPE_STOP DEF_FRAME_UPDATE];%�_�l�I
L_p_robotF(S_INITIAL,:)=[[-90  90 0]+TranFrameToRobot -90  90 0  90 DEF_TYPE_STOP DEF_FRAME_UPDATE];

R_p_robotF(S_R_HOLD_L_HOLD_1,:)=[[-90 -90 0]+TranFrameToRobot  50 -90 0 -50 DEF_TYPE_STOP DEF_FRAME_UPDATE];%�k�⧨ ���⧨
L_p_robotF(S_R_HOLD_L_HOLD_1,:)=[[-90  90 0]+TranFrameToRobot -90  90 0  90 DEF_TYPE_STOP DEF_FRAME_UPDATE];

R_p_robotF(S_R_FX_L_FX,:)=[[50 -90 0]+TranFrameToRobot  50 -90 0 -50 DEF_TYPE_LINE DEF_FRAME_UPDATE];%�k�⩹��X 140 ���⩹��X 140 
L_p_robotF(S_R_FX_L_FX,:)=[[50  90 0]+TranFrameToRobot -70  90 0  90 DEF_TYPE_LINE DEF_FRAME_UPDATE];

R_p_robotF(S_R_KEEP_L_REL_1,:)=[[50 -90 0]+TranFrameToRobot  50 -90 0 -50 DEF_TYPE_STOP DEF_FRAME_KEEP];%�k�⤣�� ����}1
L_p_robotF(S_R_KEEP_L_REL_1,:)=[[50  90 0]+TranFrameToRobot -70  90 0  90 DEF_TYPE_STOP DEF_FRAME_KEEP];

R_p_robotF(S_R_KEEP_L_FX,:)=[[50 -90 0]+TranFrameToRobot  50 -90 0  -50 DEF_TYPE_LINE DEF_FRAME_KEEP];%�k�⤣�� ���⩹��X 180
L_p_robotF(S_R_KEEP_L_FX,:)=[[230  90 0]+TranFrameToRobot -50  90 0  90 DEF_TYPE_LINE DEF_FRAME_KEEP];

R_p_robotF(S_R_KEEP_L_HOLD_1,:)=[[50 -90 0]+TranFrameToRobot  50 -90 0 -50 DEF_TYPE_STOP DEF_FRAME_KEEP];%�k�⤣�� ���⧨1
L_p_robotF(S_R_KEEP_L_HOLD_1,:)=[[230  90 0]+TranFrameToRobot -50  90 0  90 DEF_TYPE_STOP DEF_FRAME_KEEP];

R_p_robotF(S_R_FCIRX_L_BCIRX,:)=[[90 -90 0]+TranFrameToRobot  50 -90 0 -50  DEF_TYPE_ARC DEF_FRAME_UPDATE];%�k����੹��X ������੹�tX
L_p_robotF(S_R_FCIRX_L_BCIRX,:)=[[-90  90 0]+TranFrameToRobot -90  90 0  90 DEF_TYPE_ARC DEF_FRAME_UPDATE];

R_p_robotF(S_R_REL_L_HOLD_1,:)=[[90 -90 0]+TranFrameToRobot  50 -90 0 -50 DEF_TYPE_STOP DEF_FRAME_KEEP];%�k��} ���⤣��1
L_p_robotF(S_R_REL_L_HOLD_1,:)=[[-90  90 0]+TranFrameToRobot -90  90 0  90 DEF_TYPE_STOP DEF_FRAME_KEEP];

R_p_robotF(S_R_BX_L_KEEP_1,:)=[[-90 -90 0]+TranFrameToRobot  50 -90 0 -50 DEF_TYPE_LINE DEF_FRAME_KEEP];%�k�⩹X�t  ���⤣��1 
L_p_robotF(S_R_BX_L_KEEP_1,:)=[[-90  90 0]+TranFrameToRobot -90  90 0  90 DEF_TYPE_LINE DEF_FRAME_KEEP];


%% x y z alpha beta gamma %%
R_p=zeros(size(SeqItv,2),7);
L_p=zeros(size(SeqItv,2),7);

R_p(S_INITIAL,:)=[210 -360 0  50 -90 0 -50];%�_�l�I
L_p(S_INITIAL,:)=[210 -180 0 -90  90 0  90];

R_p(S_R_HOLD_L_HOLD_1,:)=[210 -360 0  50 -90 0 -50];%�k�⧨ ���⧨
L_p(S_R_HOLD_L_HOLD_1,:)=[210 -180 0 -90  90 0  90];

R_p(S_R_FX_L_FX,:)=[350 -360 0  50 -90 0 -50];%�k�⩹��X 140 ���⩹��X 140 
L_p(S_R_FX_L_FX,:)=[350 -180 0 -70  90 0  90];

R_p(S_R_KEEP_L_REL_1,:)=[350 -360 0  50 -90 0 -50];%�k�⤣�� ����}1
L_p(S_R_KEEP_L_REL_1,:)=[350 -180 0 -70  90 0  90];

R_p(S_R_KEEP_L_FX,:)=[350 -360 0  50 -90 0 -50];%�k�⤣�� ���⩹��X 180
L_p(S_R_KEEP_L_FX,:)=[530 -180 0 -50  90 0  90];

R_p(S_R_KEEP_L_HOLD_1,:)=[350 -360 0  50 -90 0 -50];%�k�⤣�� ���⧨1
L_p(S_R_KEEP_L_HOLD_1,:)=[530 -180 0 -50  90 0  90];

R_p(S_R_FCIRX_L_BCIRX,:)=[390 -360 0  50 -90 0 -50];%�k����੹��X ������੹�tX
L_p(S_R_FCIRX_L_BCIRX,:)=[210 -180 0 -90  90 0  90];

R_p(S_R_REL_L_HOLD_1,:)=[390 -360 0  50 -90 0 -50];%�k��} ���⤣��1
L_p(S_R_REL_L_HOLD_1,:)=[210 -180 0 -90  90 0  90];

R_p(S_R_BX_L_KEEP_1,:)=[210 -360 0  50 -90 0 -50];%�k�⩹X�t  ���⤣��1 
L_p(S_R_BX_L_KEEP_1,:)=[210 -180 0 -90  90 0  90];

% R_p=[   210 -360 0  50 -90 0 -50;
%         350 -360 0  50 -90 0 -50;
%         350 -360 0  50 -90 0 -50;
%         390 -360 0  50 -90 0 -50;
%         210 -360 0  50 -90 0 -50];
% L_p=[   210 -180 0 -90  90 0  90;
%         350 -180 0 -70  90 0  90;
%         530 -180 0 -50  90 0  90;
%         210 -180 0 -90  90 0  90;
%         210 -180 0 -90  90 0  90];
  
%%==�קאּ���Τ��\�h�Ϭq�A�u�����t�������A���Ҽ{�t�׳s��==%%
index=2;
for abst=0:DEF_CYCLE_TIME:TotalTime
 
    if(abst>Seqt(index))
        index=index+1;
    end
    
    Itv=SeqItv(index);
    t=abst-Seqt(index-1);
    
    type=R_p_robotF(index,8);
    framupdate=R_p_robotF(index,9);
    
    if(type==DEF_TYPE_STOP)
        PathPlanPoint_R=R_p_robotF(index,:);
        PathPlanPoint_L=L_p_robotF(index,:);
        
        %�_�����|�P����I�y��
        if(framupdate==DEF_FRAME_UPDATE) 
            ObjCorner=[ PathPlanPoint_L(1:3)+HoldLen_L;
                        PathPlanPoint_R(1:3)+HoldLen_R;
                        PathPlanPoint_R(1:3);
                        PathPlanPoint_L(1:3)];
        end
    elseif(type==DEF_TYPE_LINE)
        PathPlanPoint_R=R_p_robotF(index-1,:)+(R_p_robotF(index,:)-R_p_robotF(index-1,:))*t/Itv;%�W�@�����_�l�I�}�l��
        PathPlanPoint_L=L_p_robotF(index-1,:)+(L_p_robotF(index,:)-L_p_robotF(index-1,:))*t/Itv;    
        
         %�_�����|�P����I�y��
        if(framupdate==DEF_FRAME_UPDATE)      
            ObjCorner=[ PathPlanPoint_L(1:3)+HoldLen_L;
                        PathPlanPoint_R(1:3)+HoldLen_R;
                        PathPlanPoint_R(1:3);
                        PathPlanPoint_L(1:3)];
        end        
    elseif(type==DEF_TYPE_ARC)
        PathPlanPoint_R=[Needle_RobotF 0 0 0 0] +rR*[cos(0.5*pi*t/Itv+ini_rad_R) sin(0.5*pi*t/Itv+ini_rad_R) 0 0 0 0 0]+[0 0 0 R_p_robotF(S_R_FCIRX_L_BCIRX-1,4:7)+(R_p_robotF(S_R_FCIRX_L_BCIRX,4:7)-R_p_robotF(S_R_FCIRX_L_BCIRX-1,4:7))*t/Itv]; %�k��W��U����
        PathPlanPoint_L=[Needle_RobotF 0 0 0 0] +rL*[cos(0.5*pi*t/Itv+ini_rad_L) sin(0.5*pi*t/Itv+ini_rad_L) 0 0 0 0 0]+[0 0 0 L_p_robotF(S_R_FCIRX_L_BCIRX-1,4:7)+(L_p_robotF(S_R_FCIRX_L_BCIRX,4:7)-L_p_robotF(S_R_FCIRX_L_BCIRX-1,4:7))*t/Itv]; %����W��U����

        ObjCenter=(PathPlanPoint_R(1:3)+PathPlanPoint_L(1:3))/2;%�p���_�����|�P����I�y��
        V_oc_lend=PathPlanPoint_L(1:3)-ObjCenter;%�_���������I�쥪�⪺�V�q
        V_oc_lend_ro_p90=[V_oc_lend 1]*Rz(0.5*pi);
        V_oc_lend_ro_n90=[V_oc_lend 1]*Rz(-0.5*pi);
        ObjCorner=[ PathPlanPoint_L(1:3); 
                    ObjCenter+V_oc_lend_ro_p90(1:3);
                    PathPlanPoint_R(1:3);
                    ObjCenter+V_oc_lend_ro_n90(1:3)];
    end
    
    in_x_end_R=PathPlanPoint_R(1);
    in_y_end_R=PathPlanPoint_R(2);
    in_z_end_R=PathPlanPoint_R(3);
    
    in_x_end_L=PathPlanPoint_L(1);
    in_y_end_L=PathPlanPoint_L(2);
    in_z_end_L=PathPlanPoint_L(3);

    in_alpha_R=PathPlanPoint_R(4)*(pi/180);
    in_beta_R=PathPlanPoint_R(5)*(pi/180);
    in_gamma_R=PathPlanPoint_R(6)*(pi/180);
    
    in_alpha_L=PathPlanPoint_L(4)*(pi/180);
    in_beta_L=PathPlanPoint_L(5)*(pi/180);
    in_gamma_L=PathPlanPoint_L(6)*(pi/180);
    
    Rednt_alpha_R=PathPlanPoint_R(7)*(pi/180);
    Rednt_alpha_L=PathPlanPoint_L(7)*(pi/180);
    
    %���I��min==>IK==>theta==>FK==>���I��mout
    %inverse kinematic
    in_linkL=[L0;L1;L2;L3;L4;L5];
    in_base=[0;-L0;0];%header0 �y�Шt������shoulder0 �y�Шt �tY��V��L0
    in_end=[in_x_end_R;in_y_end_R;in_z_end_R];
    in_PoseAngle=[in_alpha_R;in_beta_R;in_gamma_R];
    %tic 
    theta_R=IK_7DOF_FB7roll(DEF_RIGHT_HAND,in_linkL,in_base,in_end,in_PoseAngle,Rednt_alpha_R);
    %toc
    %AngleConstrain
    bover=AngleOverConstrain(DEF_RIGHT_HAND,theta_R);
    if bover == true
        break;
    end    
    
    in_linkL=[L0;L1;L2;L3;L4;L5];
    in_base=[0;L0;0];
    in_end=[in_x_end_L;in_y_end_L;in_z_end_L];
    in_PoseAngle=[in_alpha_L;in_beta_L;in_gamma_L];
    theta_L=IK_7DOF_FB7roll(DEF_LEFT_HAND,in_linkL,in_base,in_end,in_PoseAngle,Rednt_alpha_L);
    
    %AngleConstrain
    bover=AngleOverConstrain(DEF_LEFT_HAND,theta_L);
    if bover == true
        break;
    end    
    
    %forward kinematic
    [out_x_end_R,out_y_end_R,out_z_end_R,out_alpha_R,out_beta_R,out_gamma_R,ArmJoint_R,RotationM_R] = FK_7DOF_FB7roll(DEF_RIGHT_HAND,L0,L1,L2,L3,L4,L5,x_base_R,y_base_R,z_base_R,theta_R);
    [out_x_end_L,out_y_end_L,out_z_end_L,out_alpha_L,out_beta_L,out_gamma_L,ArmJoint_L,RotationM_L] = FK_7DOF_FB7roll(DEF_LEFT_HAND,L0,L1,L2,L3,L4,L5,x_base_L,y_base_L,z_base_L,theta_L);

    %�O���C�b�����ܤ�
    PathTheta_R(Pcnt,1:7)=theta_R*(180/pi);
    PathTheta_L(Pcnt,1:7)=theta_L*(180/pi);
    
    PathPlanPoint_R=[in_x_end_R in_y_end_R in_z_end_R in_alpha_R in_beta_R in_gamma_R Rednt_alpha_R];
    PathIFKPoint_R=[out_x_end_R out_y_end_R out_z_end_R out_alpha_R out_beta_R out_gamma_R Rednt_alpha_R];%Rednt_alpha_R �٤��|��A�����θ�W�����̼�
    
    PathPlanPoint_L=[in_x_end_L in_y_end_L in_z_end_L in_alpha_L in_beta_L in_gamma_L Rednt_alpha_L];
    PathIFKPoint_L=[out_x_end_L out_y_end_L out_z_end_L out_alpha_L out_beta_L out_gamma_L Rednt_alpha_L];
    
    %�T�{FK �MIK�~�t
%     if(out_x_end-in_x_end)>1e-5 || (out_y_end-in_y_end)>1e-5 || (out_z_end-in_z_end)>1e-5 || (out_alpha-in_alpha)>1e-5 || (out_beta-in_beta)>1e-5 || (out_gamma-in_gamma)>1e-5 
%         display('===============')
%         display('IK FK not match')
%         i
%         In=[in_x_end in_y_end in_z_end in_alpha*(180/pi) in_beta*(180/pi) in_gamma*(180/pi)]
%         Out=[out_x_end out_y_end out_z_end out_alpha*(180/pi) out_beta*(180/pi) out_gamma*(180/pi)]
%         
%         break;
%     end
    
   
    %Path_R(Pcnt,1:7)=P_R;  %�W�e�����|�I
    %Path_L(Pcnt,1:7)=P_L;  %�W�e�����|�I
     
    %�O���W�����|�W���I
    PathPlanPointRec_R(Pcnt,1:7)=PathPlanPoint_R;
    PathPlanPointRec_L(Pcnt,1:7)=PathPlanPoint_L;
    
    %�O���g�LIK FK�B�����|�W���I
    PathIFKPointRec_R(Pcnt,1:7)=PathIFKPoint_R;
    PathIFKPointRec_L(Pcnt,1:7)=PathIFKPoint_L;
    
    %�e���`�I��
    %Draw_7DOF_FB7roll_point_dual(P_R,RotationM_R,PathPoint_R,PathPoint_L,RotationM_L,PathPoint_L);
    Draw_7DOF_FB7roll_point_dual_script;
    
    pause(0.001);
    Pcnt=Pcnt+1;      
    
end

%==�e�bcartesian space�U�U�ۥѫ�(x,y,z)���W��
%right hand
t=0:DEF_CYCLE_TIME:TotalTime; 
figure(2);
subplot(2,2,1),plot(t,PathPlanPointRec_R(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x (mm)');
title('right hand t versus x') ; 

subplot(2,2,2),plot(t,PathPlanPointRec_R(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y (mm)');
title('right hand t versus y') ; 

subplot(2,2,3),plot(t,PathPlanPointRec_R(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z (mm)');
title('right hand t versus z') ; 

%left hand
t=0:DEF_CYCLE_TIME:TotalTime; 
figure(3);
subplot(2,2,1),plot(t,PathPlanPointRec_L(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x (mm)');
title('left hand t versus x') ; 

subplot(2,2,2),plot(t,PathPlanPointRec_L(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y (mm)');
title('left hand t versus y') ; 

subplot(2,2,3),plot(t,PathPlanPointRec_L(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z (mm)');
title('left hand t versus z') ; 

%==�p��õe�U�ۥѫ�(x,y,z)���t��
%right hand
for i=1:1:size(PathPlanPointRec_R,1)-1
PathPlanVelRec_R(i,:)=(PathPlanPointRec_R(i+1,:)-PathPlanPointRec_R(i,:))/DEF_CYCLE_TIME;
end

t=0:DEF_CYCLE_TIME:TotalTime-DEF_CYCLE_TIME; %�]���t�׷|�֤@�����

figure(4);
subplot(2,2,1),plot(t,PathPlanVelRec_R(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x/t (mm/s)');
title('right hand t versus x/t') ;   
 
subplot(2,2,2),plot(t,PathPlanVelRec_R(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y/t (mm/s)');
title('right hand t versus y/t') ; 

subplot(2,2,3),plot(t,PathPlanVelRec_R(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z/t (mm/s)');
title('right hand t versus z/t') ;

%left hand
for i=1:1:size(PathPlanPointRec_L,1)-1
   PathPlanVelRec_L(i,:)=(PathPlanPointRec_L(i+1,:)-PathPlanPointRec_L(i,:))/DEF_CYCLE_TIME;
end

t=0:DEF_CYCLE_TIME:TotalTime-DEF_CYCLE_TIME; %�]���t�׷|�֤@�����

figure(5);
subplot(2,2,1),plot(t,PathPlanVelRec_L(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x/t (mm/s)');
title('left hand t versus x/t') ;   
 
subplot(2,2,2),plot(t,PathPlanVelRec_L(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y/t (mm/s)');
title('left hand t versus y/t') ; 

subplot(2,2,3),plot(t,PathPlanVelRec_L(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z/t (mm/s)');
title('left hand t versus z/t') ;


%% ==�p���I�O����ŧi==%%
% PathPlanPoint_R=zeros(Pcnt,7);%�O����ڤW���I�A�e�Ϩϥ�
% PathTheta_R=zeros(Pcnt,7);%�O���C�b���סA�e�Ϩϥ�
%  
% PathPlanPoint_L=zeros(Pcnt,7);%�O����ڤW���I�A�e�Ϩϥ�
% PathTheta_L=zeros(Pcnt,7);%�O���C�b���סA�e�Ϩϥ�


%% ==�eJointAngle== %%
%right
figure(6); hold on; grid on; title('right hand joint angle'); xlabel('t'); ylabel('deg');
t=0:DEF_CYCLE_TIME:TotalTime; 
for i=1:1:7
    plot(t,PathTheta_R(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');

%left
figure(7); hold on; grid on; title('left hand joint angle'); xlabel('t'); ylabel('deg');
t=0:DEF_CYCLE_TIME:TotalTime; 
for i=1:1:7
    plot(t,PathTheta_L(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');

%
% ==�eJointVel== %%
%right
PathVel_R=zeros(size(PathTheta_R,1),7);
for i=1:1:size(PathTheta_R,1)
    if(i==1)
         PathVel_R(i,:)=[0 0 0 0 0 0 0];
    else
         PathVel_R(i,:)=(PathTheta_R(i,:)-PathTheta_R(i-1,:))/DEF_CYCLE_TIME;
    end
end
figure(8); hold on; grid on; title('right hand joint rotation speed'); xlabel('t'); ylabel('deg/s');
t=0:DEF_CYCLE_TIME:TotalTime; 
for i=1:1:7
    plot(t,PathVel_R(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');

%left
PathVel_L=zeros(size(PathTheta_L,1),7);
for i=1:1:size(PathTheta_L,1)
    if(i==1)
         PathVel_L(i,:)=[0 0 0 0 0 0 0];
    else
         PathVel_L(i,:)=(PathTheta_L(i,:)-PathTheta_L(i-1,:))/DEF_CYCLE_TIME;
    end
end
figure(9); hold on; grid on; title('left hand joint rotation speed'); xlabel('t'); ylabel('angle/s');
t=0:DEF_CYCLE_TIME:TotalTime; 
for i=1:1:7
    plot(t,PathVel_L(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');

%% ==�eJointAcc== %%
%right
PathAcc_R=zeros(size(PathVel_R,1),7);
for i=1:1:size(PathVel_R,1)
    if(i==1)
         PathAcc_R(i,:)=[0 0 0 0 0 0 0];
    else
         PathAcc_R(i,:)=(PathVel_R(i,:)-PathVel_R(i-1,:))/DEF_CYCLE_TIME;
    end
end

figure(10); hold on; grid on; title('right hand acc'); xlabel('t'); ylabel('angle/s^2');
t=0:DEF_CYCLE_TIME:TotalTime; 
for i=1:1:7
    plot(t,PathAcc_R(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');

%left
PathAcc_L=zeros(size(PathVel_L,1),7);
for i=1:1:size(PathVel_L,1)
    if(i==1)
         PathAcc_L(i,:)=[0 0 0 0 0 0 0];
    else
         PathAcc_L(i,:)=(PathVel_L(i,:)-PathVel_L(i-1,:))/DEF_CYCLE_TIME;
    end
end

figure(11); hold on; grid on; title('left hand acc'); xlabel('t'); ylabel('angle/t^2');
t=0:DEF_CYCLE_TIME:TotalTime; 
for i=1:1:7
    plot(t,PathAcc_L(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');