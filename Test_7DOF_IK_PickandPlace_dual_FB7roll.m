
clear all
close all
clc


%�T�w�Ѽ�
DEF_RIGHT_HAND=1;
DEF_LEFT_HAND=2;

L0=225;   %�Y��ӻH
L1=250;   %L�� ����
L2=25;    %L�� �u��
L3=25;    %L�� �u��
L4=230;   %L�� ���� 
L5=180;   %��end-effector
%%1cm=10mm  �H�W�y�г��Ҭ�mm

x_base_R=0;   %����I
y_base_R=0;
z_base_R=0;

x_base_L=0;   %����I
y_base_L=0;
z_base_L=0;


DEF_DESCRETE_POINT=90;

%�⦹���|����90��
% O_R=[500 -50 0];
% Q_R=[500 -200 0];
% R_R=[500 -200 -200];
% S_R=[500 -50 -200];

% O_R=[500 -50 0];
% Q_R=[500 -200 0];
% R_R=[500 -200 -220];
% S_R=[500 -50 -220];
% 
% O_L=[500 50 0];
% Q_L=[500 200 0];
% R_L=[500 200 -200];
% S_L=[500 50 -200];


Path_R=zeros(DEF_DESCRETE_POINT,3);%�W�e�����|�I
PathPoint_R=zeros(DEF_DESCRETE_POINT,3);%�O����ڤW���I�A�e�Ϩϥ�
PathTheta_R=zeros(DEF_DESCRETE_POINT,7);%�O���C�b���סA�e�Ϩϥ�
 
Path_L=zeros(DEF_DESCRETE_POINT,3);%�W�e�����|�I
PathPoint_L=zeros(DEF_DESCRETE_POINT,3);%�O����ڤW���I�A�e�Ϩϥ�
PathTheta_L=zeros(DEF_DESCRETE_POINT,7);%�O���C�b���סA�e�Ϩϥ�

Red_can=zeros(DEF_DESCRETE_POINT,3);
Green_can=zeros(DEF_DESCRETE_POINT,3);
Blue_can=zeros(DEF_DESCRETE_POINT,3);
handle_top=zeros(DEF_DESCRETE_POINT,3);
handle_bottom=zeros(DEF_DESCRETE_POINT,3);
refri_R1_top=zeros(DEF_DESCRETE_POINT,3);
refri_L1_top=zeros(DEF_DESCRETE_POINT,3);
refri_R1_bottom=zeros(DEF_DESCRETE_POINT,3);
refri_L1_bottom=zeros(DEF_DESCRETE_POINT,3);

%% ���|�W��
R_p0 = [300 -300 -200];%�_�l�I
L_p0 = [300 200 -200];%�_�l�I

R_p1 = [500 50 -210];%�����m
L_p1 = [300 200 -200];%���⤣��

Rp2x = 500;
Rp2y = (50-650)*0.5;
Rp2z = -210;
rR2 = 50-Rp2y;
R_p2 = [Rp2x Rp2y Rp2z]; %�Ԫ��b�|���
R_pp2 = [150 -300 -210]; %�Ԫ���̶}���I
L_p2 = [300 200 -200];%���⤣��

R_p3 = [150 -300 -210];%�k�⤣��
L_p3 = [400 200 -200];%���⩹�e

R_p4 = [150 -300 -210];%�k�⤣��
L_p4 = [400 100 -200];%���⩹�k

R_p5 = [150 -300 -210];%�k�⤣��
L_p5 = [520  -60 -200];%���Ⲿ�ʨ��ⶼ��  % pick the object
%====================
R_p6 = [150 -300 -210];%�k�⤣��
L_p6 = [400 100 -200];%����h�^

R_p7 = [150 -300 -210];%�k�⤣��
L_p7 = [400 200 -210];%����U��

Rp8x = 500;
Rp8y = (50-650)*0.5;
Rp8z = -210;
rR8 = 50-Rp8y;
R_p8 = [Rp8x Rp8y Rp8z];
R_pp8 =  [500 50 -210];%�����m
L_p8 = [400 200 -210];%���⤣��

R_p9 =  [500 50 -210];
L_p9 = [300 200 -210];%����h�^

R_p10 = [200 0 -300];%�k��̫�a�W�h������
L_p10 = [200 0 -300];

%% planning cans and refrigerator and handle
% RedCan1 = [520 50 -200];
% GreenCan1 = [520 -100 -200];
% BlueCan1 = [520 -250 -200];
RedCan1 = [520 50 -200];
GreenCan1 = [520 -60 -200];
BlueCan1 = [520 -170 -200];

%% plot the handle
 handleTop=[500 50 -210]; %[400 50 -50]
 handleBottom=[500 50 -210]; %[400 50 -150]
 
 %% plot the door of the refrigerator
 
%  Refri_R1_Up=[400 -80 0];%point1
%  Refri_R1_bottom=[400 -80 -200];%point3
%  Refri_L1_Up=[400 80 0];%point5
%  Refri_L1_bottom=[400 80 -200];%point7
Refri_R1_top=[500 -350 -210];%point1    y-50  z-210
Refri_R1_bottom=[500 -350 -210];%point3     y-50  z+190
Refri_L1_top=[500 50 -210];%point5     y-50  z-210
Refri_L1_bottom=[500 50 -210];%point7    y-50  z+190

for t=1:1:DEF_DESCRETE_POINT
    if t<=DEF_DESCRETE_POINT*0.1
        Path_R(t,1:3)=R_p0+(R_p1-R_p0)*t/(DEF_DESCRETE_POINT*0.1);
        Path_L(t,1:3)=L_p0+(L_p1-L_p0)*t/(DEF_DESCRETE_POINT*0.1);
        Red_can(t,1:3)=RedCan1;
        Green_can(t,1:3)=GreenCan1;
        Blue_can(t,1:3)=BlueCan1;
        handle_top(t,1:3)=handleTop;
        handle_bottom(t,1:3)=handleBottom;
        refri_R1_top(t,1:3)=Refri_R1_top;
        refri_L1_top(t,1:3)=Refri_L1_top;
        refri_R1_bottom(t,1:3)=Refri_R1_bottom;
        refri_L1_bottom(t,1:3)=Refri_L1_bottom;
        
    elseif t<=DEF_DESCRETE_POINT*0.2
        Path_R(t,1:3)=R_p2+rR2*[sin(0.5*pi*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1)+ pi) cos(0.5*pi*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1)) 0];
%         Path_R(t,1:3)=R_p1+(R_pp2-R_p1)*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1);
        Path_L(t,1:3)=L_p1+(L_p2-L_p1)*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1);
        Red_can(t,1:3)=RedCan1;
        Green_can(t,1:3)=GreenCan1;
        Blue_can(t,1:3)=BlueCan1;
        handle_top(t,1:3)=R_p2+rR2*[sin(0.5*pi*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1)+ pi) cos(0.5*pi*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1)) 0];
        handle_bottom(t,1:3)=R_p2+rR2*[sin(0.5*pi*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1)+ pi) cos(0.5*pi*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1)) 0];
        refri_R1_top(t,1:3)=Refri_R1_top;
        refri_L1_top(t,1:3)=R_p2+rR2*[sin(0.5*pi*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1)+ pi) cos(0.5*pi*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1)) 0];
        refri_R1_bottom(t,1:3)=Refri_R1_bottom;
        refri_L1_bottom(t,1:3)=R_p2+rR2*[sin(0.5*pi*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1)+ pi) cos(0.5*pi*(t-DEF_DESCRETE_POINT*0.1)/(DEF_DESCRETE_POINT*0.1)) 0];
        
    elseif t<=DEF_DESCRETE_POINT*0.3
        Path_R(t,1:3)=R_pp2+(R_p3-R_pp2)*(t-DEF_DESCRETE_POINT*0.2)/(DEF_DESCRETE_POINT*0.1);
        Path_L(t,1:3)=L_p2+(L_p3-L_p2)*(t-DEF_DESCRETE_POINT*0.2)/(DEF_DESCRETE_POINT*0.1);
        Red_can(t,1:3)=RedCan1;
        Green_can(t,1:3)=GreenCan1;
        Blue_can(t,1:3)=BlueCan1;
        handle_top(t,1:3)=R_pp2+(R_p3-R_pp2)*(t-DEF_DESCRETE_POINT*0.2)/(DEF_DESCRETE_POINT*0.1);
        handle_bottom(t,1:3)=R_pp2+(R_p3-R_pp2)*(t-DEF_DESCRETE_POINT*0.2)/(DEF_DESCRETE_POINT*0.1);
        refri_R1_top(t,1:3)=Refri_R1_top;
        refri_L1_top(t,1:3)=R_pp2+(R_p3-R_pp2)*(t-DEF_DESCRETE_POINT*0.2)/(DEF_DESCRETE_POINT*0.1);
        refri_R1_bottom(t,1:3)=Refri_R1_bottom;
        refri_L1_bottom(t,1:3)=R_pp2+(R_p3-R_pp2)*(t-DEF_DESCRETE_POINT*0.2)/(DEF_DESCRETE_POINT*0.1);
        
    elseif t<=DEF_DESCRETE_POINT*0.4
        Path_R(t,1:3)=R_p3+(R_p4-R_p3)*(t-DEF_DESCRETE_POINT*0.3)/(DEF_DESCRETE_POINT*0.1);
        Path_L(t,1:3)=L_p3+(L_p4-L_p3)*(t-DEF_DESCRETE_POINT*0.3)/(DEF_DESCRETE_POINT*0.1);
        Red_can(t,1:3)=RedCan1;
        Green_can(t,1:3)=GreenCan1;
        Blue_can(t,1:3)=BlueCan1;
        handle_top(t,1:3)=R_p3+(R_p4-R_p3)*(t-DEF_DESCRETE_POINT*0.3)/(DEF_DESCRETE_POINT*0.1);
        handle_bottom(t,1:3)=R_p3+(R_p4-R_p3)*(t-DEF_DESCRETE_POINT*0.3)/(DEF_DESCRETE_POINT*0.1);
        refri_R1_top(t,1:3)=Refri_R1_top;
        refri_L1_top(t,1:3)=R_p3+(R_p4-R_p3)*(t-DEF_DESCRETE_POINT*0.3)/(DEF_DESCRETE_POINT*0.1);
        refri_R1_bottom(t,1:3)=Refri_R1_bottom;
        refri_L1_bottom(t,1:3)=R_p3+(R_p4-R_p3)*(t-DEF_DESCRETE_POINT*0.3)/(DEF_DESCRETE_POINT*0.1);
        
    elseif t<=DEF_DESCRETE_POINT*0.5
        Path_R(t,1:3)=R_p4+(R_p5-R_p4)*(t-DEF_DESCRETE_POINT*0.4)/(DEF_DESCRETE_POINT*0.1);
        Path_L(t,1:3)=L_p4+(L_p5-L_p4)*(t-DEF_DESCRETE_POINT*0.4)/(DEF_DESCRETE_POINT*0.1);
        Red_can(t,1:3)=RedCan1;
        Green_can(t,1:3)=GreenCan1;
        Blue_can(t,1:3)=BlueCan1;
        handle_top(t,1:3)=R_p4+(R_p5-R_p4)*(t-DEF_DESCRETE_POINT*0.4)/(DEF_DESCRETE_POINT*0.1);
        handle_bottom(t,1:3)=R_p4+(R_p5-R_p4)*(t-DEF_DESCRETE_POINT*0.4)/(DEF_DESCRETE_POINT*0.1);
        refri_R1_top(t,1:3)=Refri_R1_top;
        refri_L1_top(t,1:3)=R_p4+(R_p5-R_p4)*(t-DEF_DESCRETE_POINT*0.4)/(DEF_DESCRETE_POINT*0.1);
        refri_R1_bottom(t,1:3)=Refri_R1_bottom;
        refri_L1_bottom(t,1:3)=R_p4+(R_p5-R_p4)*(t-DEF_DESCRETE_POINT*0.4)/(DEF_DESCRETE_POINT*0.1);
        
    elseif t<=DEF_DESCRETE_POINT*0.6
        Path_R(t,1:3)=R_p5+(R_p6-R_p5)*(t-DEF_DESCRETE_POINT*0.5)/(DEF_DESCRETE_POINT*0.1);
        Path_L(t,1:3)=L_p5+(L_p6-L_p5)*(t-DEF_DESCRETE_POINT*0.5)/(DEF_DESCRETE_POINT*0.1);
        Red_can(t,1:3)=RedCan1;
        Green_can(t,1:3)=L_p5+(L_p6-L_p5)*(t-DEF_DESCRETE_POINT*0.5)/(DEF_DESCRETE_POINT*0.1);
        Blue_can(t,1:3)=BlueCan1;
        handle_top(t,1:3)=R_p5+(R_p6-R_p5)*(t-DEF_DESCRETE_POINT*0.5)/(DEF_DESCRETE_POINT*0.1);
        handle_bottom(t,1:3)=R_p5+(R_p6-R_p5)*(t-DEF_DESCRETE_POINT*0.5)/(DEF_DESCRETE_POINT*0.1);
        refri_R1_top(t,1:3)=Refri_R1_top;
        refri_L1_top(t,1:3)=R_p5+(R_p6-R_p5)*(t-DEF_DESCRETE_POINT*0.5)/(DEF_DESCRETE_POINT*0.1);
        refri_R1_bottom(t,1:3)=Refri_R1_bottom;
        refri_L1_bottom(t,1:3)=R_p5+(R_p6-R_p5)*(t-DEF_DESCRETE_POINT*0.5)/(DEF_DESCRETE_POINT*0.1);
        
    elseif t<=DEF_DESCRETE_POINT*0.7
        Path_R(t,1:3)=R_p6+(R_p7-R_p6)*(t-DEF_DESCRETE_POINT*0.6)/(DEF_DESCRETE_POINT*0.1);
        Path_L(t,1:3)=L_p6+(L_p7-L_p6)*(t-DEF_DESCRETE_POINT*0.6)/(DEF_DESCRETE_POINT*0.1);
        Red_can(t,1:3)=RedCan1;
        Green_can(t,1:3)= L_p6+(L_p7-L_p6)*(t-DEF_DESCRETE_POINT*0.6)/(DEF_DESCRETE_POINT*0.1);
        Blue_can(t,1:3)=BlueCan1;
        handle_top(t,1:3)=R_p6+(R_p7-R_p6)*(t-DEF_DESCRETE_POINT*0.6)/(DEF_DESCRETE_POINT*0.1);
        handle_bottom(t,1:3)=R_p6+(R_p7-R_p6)*(t-DEF_DESCRETE_POINT*0.6)/(DEF_DESCRETE_POINT*0.1);
        refri_R1_top(t,1:3)=Refri_R1_top;
        refri_L1_top(t,1:3)=R_p6+(R_p7-R_p6)*(t-DEF_DESCRETE_POINT*0.6)/(DEF_DESCRETE_POINT*0.1);
        refri_R1_bottom(t,1:3)=Refri_R1_bottom;
        refri_L1_bottom(t,1:3)=R_p6+(R_p7-R_p6)*(t-DEF_DESCRETE_POINT*0.6)/(DEF_DESCRETE_POINT*0.1);
        
    elseif t<=DEF_DESCRETE_POINT*0.8
        Path_R(t,1:3)=R_p8+rR8*[cos(0.5*pi*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1)+pi) sin(0.5*pi*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1)) 0];
%         Path_R(t,1:3)=R_p7+(R_pp8-R_p7)*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1);
        Path_L(t,1:3)=L_p7+(L_p8-L_p7)*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1);
        Red_can(t,1:3)=RedCan1;
        Green_can(t,1:3)=L_p7+(L_p8-L_p7)*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1);
        Blue_can(t,1:3)=BlueCan1;
        handle_top(t,1:3)=R_p8+rR8*[cos(0.5*pi*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1)+pi) sin(0.5*pi*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1)) 0];
        handle_bottom(t,1:3)=R_p8+rR8*[cos(0.5*pi*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1)+pi) sin(0.5*pi*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1)) 0];
        refri_R1_top(t,1:3)=Refri_R1_top;
        refri_L1_top(t,1:3)=R_p8+rR8*[cos(0.5*pi*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1)+pi) sin(0.5*pi*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1)) 0];
        refri_R1_bottom(t,1:3)=Refri_R1_bottom;
        refri_L1_bottom(t,1:3)=R_p8+rR8*[cos(0.5*pi*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1)+pi) sin(0.5*pi*(t-DEF_DESCRETE_POINT*0.7)/(DEF_DESCRETE_POINT*0.1)) 0];

    elseif t<=DEF_DESCRETE_POINT*0.9
        Path_R(t,1:3)=R_pp8+(R_p9-R_pp8)*(t-DEF_DESCRETE_POINT*0.8)/(DEF_DESCRETE_POINT*0.1);
        Path_L(t,1:3)=L_p8+(L_p9-L_p8)*(t-DEF_DESCRETE_POINT*0.8)/(DEF_DESCRETE_POINT*0.1);
        Red_can(t,1:3)=RedCan1;
        Green_can(t,1:3)=L_p8+(L_p9-L_p8)*(t-DEF_DESCRETE_POINT*0.8)/(DEF_DESCRETE_POINT*0.1);
        Blue_can(t,1:3)=BlueCan1;
        handle_top(t,1:3)=handleTop;
        handle_bottom(t,1:3)=handleBottom;
        refri_R1_top(t,1:3)=Refri_R1_top;
        refri_L1_top(t,1:3)=Refri_L1_top;
        refri_R1_bottom(t,1:3)=Refri_R1_bottom;
        refri_L1_bottom(t,1:3)=Refri_L1_bottom;
        
    elseif t<=DEF_DESCRETE_POINT
        Path_R(t,1:3)=R_p9+(R_p10-R_p9)*(t-DEF_DESCRETE_POINT*0.9)/(DEF_DESCRETE_POINT*0.1);
        Path_L(t,1:3)=L_p9+(L_p10-L_p9)*(t-DEF_DESCRETE_POINT*0.9)/(DEF_DESCRETE_POINT*0.1);
        Red_can(t,1:3)=RedCan1;
        Green_can(t,1:3)=L_p9+(L_p10-L_p9)*(t-DEF_DESCRETE_POINT*0.9)/(DEF_DESCRETE_POINT*0.1);
        Blue_can(t,1:3)=BlueCan1;
        handle_top(t,1:3)=handleTop;
        handle_bottom(t,1:3)=handleBottom;
        refri_R1_top(t,1:3)=Refri_R1_top;
        refri_L1_top(t,1:3)=Refri_L1_top;
        refri_R1_bottom(t,1:3)=Refri_R1_bottom;
        refri_L1_bottom(t,1:3)=Refri_L1_bottom;
    end
    
end




%�e����ΰ�IK FK����
% for t=1:1:DEF_DESCRETE_POINT
%     if t<=25
%         Path_R(t,1:3)=O_R+(Q_R-O_R)*t/25;
%         Path_L(t,1:3)=O_L+(Q_L-O_L)*t/25;
%     elseif t<=50
%         Path_R(t,1:3)=Q_R+(R_R-Q_R)*(t-25)/25;
%         Path_L(t,1:3)=Q_L+(R_L-Q_L)*(t-25)/25;
%     elseif t<=75
%         Path_R(t,1:3)=R_R+(S_R-R_R)*(t-50)/25;
%         Path_L(t,1:3)=R_L+(S_L-R_L)*(t-50)/25;
%     else 
%         Path_R(t,1:3)=S_R+(O_R-S_R)*(t-75)/15;
%         Path_L(t,1:3)=S_L+(O_L-S_L)*(t-75)/15;
%     end
% end

for t=1:1:DEF_DESCRETE_POINT
 
    %��J�Ѽ�
    in_x_end_R=Path_R(t,1);
    in_y_end_R=Path_R(t,2);
    in_z_end_R=Path_R(t,3);
    
    in_x_end_L=Path_L(t,1);
    in_y_end_L=Path_L(t,2);
    in_z_end_L=Path_L(t,3);
   
    in_alpha_R=60*(pi/180);
    in_beta_R=0*(t/DEF_DESCRETE_POINT)*(pi/180);
    in_gamma_R=0*(t/DEF_DESCRETE_POINT)*(pi/180);
    
    in_alpha_L=-50*(pi/180);
    in_beta_L=0*(t/DEF_DESCRETE_POINT)*(pi/180);
    in_gamma_L=0*(t/DEF_DESCRETE_POINT)*(pi/180);

    Rednt_alpha_R=-60*(pi/180);
    Rednt_alpha_L=30*(pi/180);
  
    
  
    %���I��min==>IK==>theta==>FK==>���I��mout
    %inverse kinematic
    in_linkL=[L0;L1;L2;L3;L4;L5];
    in_base=[0;-L0;0];%header0 �y�Шt������shoulder0 �y�Шt �tY��V��L0
    in_end=[in_x_end_R;in_y_end_R;in_z_end_R];
    in_PoseAngle=[in_alpha_R;in_beta_R;in_gamma_R];
    theta_R=IK_7DOF_FB7roll(DEF_RIGHT_HAND,in_linkL,in_base,in_end,in_PoseAngle,Rednt_alpha_R);
    
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
    %theta=[0 0 0 0 0 0 0];
    
    [out_x_end_R,out_y_end_R,out_z_end_R,out_alpha_R,out_beta_R,out_gamma_R,P_R,RotationM_R] = FK_7DOF_FB7roll(DEF_RIGHT_HAND,L0,L1,L2,L3,L4,L5,x_base_R,y_base_R,z_base_R,theta_R);
    [out_x_end_L,out_y_end_L,out_z_end_L,out_alpha_L,out_beta_L,out_gamma_L,P_L,RotationM_L] = FK_7DOF_FB7roll(DEF_LEFT_HAND,L0,L1,L2,L3,L4,L5,x_base_L,y_base_L,z_base_L,theta_L);

    
    %�O�����|�W���I
    PathPoint_R(t,1:3)=[out_x_end_R out_y_end_R out_z_end_R];
    PathPoint_L(t,1:3)=[out_x_end_L out_y_end_L out_z_end_L];
    
    
    %�e���`�I��
    Draw_7DOF_FB7roll_point_dual(P_R,RotationM_R,PathPoint_R,P_L,RotationM_L,PathPoint_L);
   
    %�O���C�b�����ܤ�
    PathTheta_R(t,1:7)=theta_R*(180/pi);
    PathTheta_L(t,1:7)=theta_L*(180/pi);
    
    In_R=[in_x_end_R in_y_end_R in_z_end_R in_alpha_R in_beta_R in_gamma_R];
    Out_R=[out_x_end_R out_y_end_R out_z_end_R out_alpha_R out_beta_R out_gamma_R];
    
    In_L=[in_x_end_L in_y_end_L in_z_end_L in_alpha_L in_beta_L in_gamma_L]
    Out_L=[out_x_end_L out_y_end_L out_z_end_L out_alpha_L out_beta_L out_gamma_L]
    
     plot3( Red_can(t,1), Red_can(t,2), Red_can(t,3),'ro','MarkerFaceColor','r','MarkerSize',20,'Linewidth',4);
%     text(525,120,-70,'Red can') 
    plot3( Green_can(t,1), Green_can(t,2), Green_can(t,3),'go','MarkerFaceColor','g','MarkerSize',20,'Linewidth',4);
%     text(525,20,-70,'Green can')
    plot3( Blue_can(t,1), Blue_can(t,2), Blue_can(t,3),'bo','MarkerFaceColor','b','MarkerSize',20,'Linewidth',4);
%     text(525,-80,-70,'Blue can')
    plot3([handle_top(t,1), handle_bottom(t,1)], [handle_top(t,2), handle_bottom(t,2)], [handle_top(t,3)+60, handle_bottom(t,3)-60], '-','Color',[0 0 0],'Linewidth',8); 

    plot3([refri_L1_top(t,1), refri_L1_bottom(t,1)],[refri_L1_top(t,2)+50, refri_L1_bottom(t,2)+50],[refri_L1_top(t,3)+210, refri_L1_bottom(t,3)-190],'-','Color',[0 0 0],'Linewidth',4); %Line2
    plot3([refri_R1_top(t,1), refri_R1_bottom(t,1)],[refri_R1_top(t,2)+50, refri_R1_bottom(t,2)+50],[refri_R1_top(t,3)+210, refri_R1_bottom(t,3)-190],'-','Color',[0 0 0],'Linewidth',4); %Line6
    plot3([refri_L1_top(t,1), refri_R1_top(t,1)],[refri_L1_top(t,2)+50, refri_R1_top(t,2)+50],[refri_L1_top(t,3)+210, refri_R1_top(t,3)+210],'-','Color',[0 0 0],'Linewidth',4); %Line9
    plot3([refri_L1_bottom(t,1), refri_R1_bottom(t,1)],[refri_L1_bottom(t,2)+50, refri_R1_bottom(t,2)+50],[refri_L1_bottom(t,3)-190, refri_R1_bottom(t,3)-190],'-','Color',[0 0 0],'Linewidth',4); %Line11
    
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
    
    pause(0.1);
end

 %�eJointAngle
% figure(2)
% Draw_7DOF_JointAnglePath(PathTheta_R);
% hold on; grid on; 
% title('Trajectory Planning of Joint Space for Right-Arm');
% figure(2)
% Draw_7DOF_JointAnglePath(PathTheta_L)
% hold on; grid on; 
% title('Trajectory Planning of Joint Space for Left-Arm');