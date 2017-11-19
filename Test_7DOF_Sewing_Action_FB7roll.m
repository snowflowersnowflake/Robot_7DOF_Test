clear all
close all
clc

%% �T�w�Ѽ�
DEF_RIGHT_HAND=1;
DEF_LEFT_HAND=2;

L0=248;   %�Y��ӻH
L1=250;   %L�� ����
L2=25;    %L�� �u��
L3=25;    %L�� �u��
L4=230;   %L�� ���� 
L5=195;   %��end-effector

x_base_R=0;   %����I
y_base_R=0;
z_base_R=0;

x_base_L=0;   %����I
y_base_L=0;
z_base_L=0;

DEF_CYCLE_TIME=0.5;
Pcnt=1;%��X�`��

Needle_RobotF=[350 -300 30];%�w�I�b���u���Шt��m   
Needle_ini_Plate=[30 -30 0];%�U�w�I�b�[�lplate�y�Шt�W����l�I
TranFrameToRobot=Needle_RobotF-Needle_ini_Plate;%�Q�Ψ�Ӫ��t�ȥh�����

MovOutLen=50;%���X����I������
SewingLength=60;%�_����{
RelMovLen=180;%�ج[����I���Z

HoldLen_L=[180 0 0];%�������I���Z �ѮبM�w
HoldLen_R=[180 0 0];%�������I���Z �ѮبM�w
%% �U�Ϭq���I��  �ק令�@�ӰϬq�B�ʥΤ@��fun
%�o��O�ϥά[�l���Шt�A��LineMoveToScript�̭��~���ഫ

TotalTime=0;
Seg=0;


%�����} ��
disp('footlifter up');

%�k�⧨ ���⧨
disp('right hold');disp('left hold');

%�����} ��
disp('footlifter down');

%�D�b�Ұ�
disp('spindle on');

%�k�⩹��X SewingLenth ���⩹��X �_�u���� SewingLenth
FRAME_UPDATE=true;%�[�lø��
R_starP=[[-90 -90 0] [50  0 0] -50]; 
R_endP=[[-90+SewingLength -90 0]  50 0 0 -50]; 
L_starP=[[-90  90 0] [-90  0 0]  90];
L_endP=[[-90+SewingLength  90 0] [-90 0 0]  90];
CostTime=3;
LineMoveTo_Script;
TotalTime=TotalTime+CostTime;
Seg=Seg+1;

%�D�b����
disp('spindle off');

%�k�⤣�� ����}
disp('left release');

%�k�⤣�� ���⩹��y���� 
FRAME_UPDATE=false;
R_starP=[[-90+SewingLength -90 0]  [50 0 0] -50]; 
R_endP=[[-90+SewingLength -90 0]  [50 0 0] -50]; 
L_starP=[[-90+SewingLength  90 0] [-90 0 0]  90];
L_endP= [[-90+SewingLength  90+MovOutLen 0] [-90 0 0]  90];
CostTime=3;
LineMoveTo_Script;
TotalTime=TotalTime+CostTime;
Seg=Seg+1;

%�k�⤣�� ���⩹��X ����I���j����(Release move length)
R_starP=[[-90+SewingLength -90 0]  [50 0 0] -50];
R_endP=[[-90+SewingLength -90 0]  [50 0 0] -50];
L_starP=[[-90+SewingLength  90+MovOutLen 0] [-90 0 0]  90];
L_endP=[[-90+SewingLength+RelMovLen  90+MovOutLen 0] [-60 0 0]  90];
CostTime=4;
LineMoveTo_Script;
TotalTime=TotalTime+CostTime;
Seg=Seg+1;

%�k�⤣�� ���⩹�ty����MovOutLen
R_starP=[[-90+SewingLength -90 0]  [50 0 0] -50];
R_endP=[[-90+SewingLength -90 0]  [50 0 0] -50];
L_starP=[[-90+SewingLength+RelMovLen  90+MovOutLen 0] [-60 0 0]  90];
L_endP=[[-90+SewingLength+RelMovLen  90 0] [-60 0 0]  90];
CostTime=3;
LineMoveTo_Script;
TotalTime=TotalTime+CostTime;
Seg=Seg+1;

%�k�⤣�� ���⧨
disp('left hold');

%�����}��
disp('footlifter up')

%�k����੹��X ������੹�tX
FRAME_UPDATE=true;
arc_cen=Needle_ini_Plate; %�����߬��w�b�[�l�W���_�l�I
R_starP=[[-90+SewingLength -90 0]  [50 0 0] -50];
R_endP=[[90 -90 0] [50 0 0] -50];
L_starP=[[-90+SewingLength+RelMovLen  90 0] [-60 0 0]  90];
L_endP=[[-90 90 0] -90 0 0  90];
rot_rad=0.5*pi; %����ɪ��_�l���ਤ��
CostTime=3;
RotateMoveTo_Script;
TotalTime=TotalTime+CostTime;
Seg=Seg+1;

%�����}��
disp('footlifter down');

%�k��} ���⤣��1
disp('left release');

%�k�⩹X�tY�t���X  ���⤣��1 
FRAME_UPDATE=false;
R_starP=[[90 -90 0] [50 0 0] -50  ];
R_endP=[[90-MovOutLen -90-MovOutLen 0]  [50 0 0] -70];
L_starP=[[-90 90 0] -90 0 0  90];
L_endP=[[-90 90 0] -90 0 0  90];
CostTime=2;
LineMoveTo_Script;
TotalTime=TotalTime+CostTime;
Seg=Seg+1;

%�k�⩹X�t����RelMovLen  ���⤣��1 
R_starP=[[90-MovOutLen -90-MovOutLen 0]  [50 0 0] -70];
R_endP=[[90-MovOutLen-RelMovLen -90-MovOutLen 0]  [50 0 0] -70];
L_starP=[[-90 90 0] -90 0 0  90];
L_endP=[[-90 90 0] -90 0 0  90];
CostTime=5;
LineMoveTo_Script;
TotalTime=TotalTime+CostTime;
Seg=Seg+1;

%�k�⩹X��Y��MovOutLen  ���⤣��1 
R_starP=[[90-MovOutLen-RelMovLen -90-MovOutLen 0]  [50 0 0] -70];
R_endP=[[90-RelMovLen -90 0]  [50 0 0] -70];
L_starP=[[-90 90 0] -90 0 0  90];
L_endP=[[-90 90 0] -90 0 0  90];
CostTime=2;
LineMoveTo_Script;
TotalTime=TotalTime+CostTime;
Seg=Seg+1;

%�k�⧨ ���⤣��1
disp('right hold');
  

%% ==�e�bcartesian space�U�U�ۥѫ�(x,y,z)���W��
%right hand
t=0:DEF_CYCLE_TIME:TotalTime+DEF_CYCLE_TIME*(Seg-1);%�Y������
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
t=0:DEF_CYCLE_TIME:TotalTime+DEF_CYCLE_TIME*(Seg-1); 
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

t=0:DEF_CYCLE_TIME:TotalTime+DEF_CYCLE_TIME*(Seg-2); %�]���t�׷|�֤@�����

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

t=0:DEF_CYCLE_TIME:TotalTime+DEF_CYCLE_TIME*(Seg-2); %�]���t�׷|�֤@�����

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


%% ==�eJointAngle== %%
%right
figure(6); hold on; grid on; title('right hand joint angle'); xlabel('t'); ylabel('deg');
t=0:DEF_CYCLE_TIME:TotalTime+DEF_CYCLE_TIME*(Seg-1);%�Y������
for i=1:1:7
    plot(t,PathTheta_R(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');

%left
figure(7); hold on; grid on; title('left hand joint angle'); xlabel('t'); ylabel('deg');
t=0:DEF_CYCLE_TIME:TotalTime+DEF_CYCLE_TIME*(Seg-1);%�Y������
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
t=0:DEF_CYCLE_TIME:TotalTime+DEF_CYCLE_TIME*(Seg-1);
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
t=0:DEF_CYCLE_TIME:TotalTime+DEF_CYCLE_TIME*(Seg-1);
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
t=0:DEF_CYCLE_TIME:TotalTime+DEF_CYCLE_TIME*(Seg-1);
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
t=0:DEF_CYCLE_TIME:TotalTime+DEF_CYCLE_TIME*(Seg-1);
for i=1:1:7
    plot(t,PathAcc_L(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');