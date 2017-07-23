
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


%DEF_DESCRETE_POINT=5000;
Seqt_R= [0 6 26 29 31 39 47 50 54 58 65]%����ɶ��Эp 
TotalTime_R=65
SeqItv_R=zeros(1, size(Seqt_R,2)-1);

for i=1:1:size(SeqItv_R,2)
    SeqItv_R(i)=Seqt_R(i+1)-Seqt_R(i);
end    

Seqt_L= [0 6 26 29 31 39 47 50 54 58 65]%����ɶ��Эp 
TotalTime_L=65;
SeqItv_L=zeros(1, size(Seqt_L,2)-1);

for i=1:1:size(SeqItv_L,2)
    SeqItv_L(i)=Seqt_L(i+1)-Seqt_L(i);
end    

%�U�q�I��
%BonPt=[0 0 0 0 0 0 0 0 0 0];%BonPt=boundary point	�Ϭq�����I		
%SegPt=[600 2000 300 200 800 800 300 400 400 400];  %SegPt=segment point �U�Ϭq�I��
%SegPt=[6 20 3 2 8 8 3 4 4 4];  %SegPt=segment point �U�Ϭq�I��

%�p��Ϭq�����I
% for i=1:1:10
%     for j=1:1:i
%         BonPt(i)= BonPt(i)+SegPt(j);
%     end    
% end

% TotalPt=0;
% for i=1:1:10
%     TotalPt=TotalPt+SegPt(i);
% end




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
L_p7 = [400 200 -210];%����


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
P_RedCan1 = [520 50 -200];
P_GreenCan1 = [520 -60 -200];
P_BlueCan1 = [520 -170 -200];

%% plot the handle
 handleTop=[500 50 -210]; %[400 50 -50]
 handleBottom=[500 50 -210]; %[400 50 -150]
 
 %% plot the door of the refrigerator
 
%  Refri_R1_Up=[400 -80 0];%point1
%  Refri_R1_bottom=[400 -80 -200];%point3
%  Refri_L1_Up=[400 80 0];%point5
%  Refri_L1_bottom=[400 80 -200];%point7
P_Refri_R1_top=[500 -350 -210];%point1    y-50  z-210
P_Refri_R1_bottom=[500 -350 -210];%point3     y-50  z+190
P_Refri_L1_top=[500 50 -210];%point5     y-50  z-210
P_Refri_L1_bottom=[500 50 -210];%point7    y-50  z+190

DEF_CYCLE_TIME=0.02;
Pcnt_R=0;%��X�`�I��
Pcnt_L=0;%�ثe�M�k��@�� ���ӷQ��k����}
for t=0:DEF_CYCLE_TIME:TotalTime_R
    if t<=Seqt_R(2)%�k�Ⲿ�ʨ�B�c����
        P_R=R_p0+(R_p1-R_p0)*t/SeqItv_R(1);
        P_L=L_p0+(L_p1-L_p0)*t/SeqItv_R(1);
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=handleTop;
        P_handle_bottom=handleBottom;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_Refri_L1_top;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_Refri_L1_bottom;
        
    elseif t<=Seqt_R(3)%�k��}�B�c��
        P_R=R_p2+rR2*[sin(0.5*pi*(t-Seqt_R(2))/SeqItv_R(2)+ pi) cos(0.5*pi*(t-Seqt_R(2))/SeqItv_R(2)) 0];
%         P_R=R_p1+(R_pp2-R_p1)*(t-Seqt_R(2))/SeqItv_R(2);
        P_L=L_p1+(L_p2-L_p1)*(t-Seqt_R(2))/SeqItv_R(2);
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=R_p2+rR2*[sin(0.5*pi*(t-Seqt_R(2))/SeqItv_R(2)+ pi) cos(0.5*pi*(t-Seqt_R(2))/SeqItv_R(2)) 0];
        P_handle_bottom=R_p2+rR2*[sin(0.5*pi*(t-Seqt_R(2))/SeqItv_R(2)+ pi) cos(0.5*pi*(t-Seqt_R(2))/SeqItv_R(2)) 0];
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=R_p2+rR2*[sin(0.5*pi*(t-Seqt_R(2))/SeqItv_R(2)+ pi) cos(0.5*pi*(t-Seqt_R(2))/SeqItv_R(2)) 0];
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=R_p2+rR2*[sin(0.5*pi*(t-Seqt_R(2))/SeqItv_R(2)+ pi) cos(0.5*pi*(t-Seqt_R(2))/SeqItv_R(2)) 0];
        
    elseif t<=Seqt_R(4) %���⩹x����100
        P_R=R_pp2+(R_p3-R_pp2)*(t-Seqt_R(3))/SeqItv_R(3);
        P_L=L_p2+(L_p3-L_p2)*(t-Seqt_R(3))/SeqItv_R(3);
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=R_pp2+(R_p3-R_pp2)*(t-Seqt_R(3))/SeqItv_R(3);
        P_handle_bottom=R_pp2+(R_p3-R_pp2)*(t-Seqt_R(3))/SeqItv_R(3);
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=R_pp2+(R_p3-R_pp2)*(t-Seqt_R(3))/SeqItv_R(3);
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=R_pp2+(R_p3-R_pp2)*(t-Seqt_R(3))/SeqItv_R(3);
        
    elseif t<=Seqt_R(5)%���⩹y����-100
        P_R=R_p3+(R_p4-R_p3)*(t-Seqt_R(4))/SeqItv_R(4);
        P_L=L_p3+(L_p4-L_p3)*(t-Seqt_R(4))/SeqItv_R(4);
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=R_p3+(R_p4-R_p3)*(t-Seqt_R(4))/SeqItv_R(4);
        P_handle_bottom=R_p3+(R_p4-R_p3)*(t-Seqt_R(4))/SeqItv_R(4);
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=R_p3+(R_p4-R_p3)*(t-Seqt_R(4))/SeqItv_R(4);
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=R_p3+(R_p4-R_p3)*(t-Seqt_R(4))/SeqItv_R(4);
        
    elseif t<=Seqt_R(6)%���Ⲿ�ʨ춼���I
        P_R=R_p4+(R_p5-R_p4)*(t-Seqt_R(5))/SeqItv_R(5);
        P_L=L_p4+(L_p5-L_p4)*(t-Seqt_R(5))/SeqItv_R(5);
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=R_p4+(R_p5-R_p4)*(t-Seqt_R(5))/SeqItv_R(5);
        P_handle_bottom=R_p4+(R_p5-R_p4)*(t-Seqt_R(5))/SeqItv_R(5);
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=R_p4+(R_p5-R_p4)*(t-Seqt_R(5))/SeqItv_R(5);
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=R_p4+(R_p5-R_p4)*(t-Seqt_R(5))/SeqItv_R(5);
        
    elseif t<=Seqt_R(7)%����h�^
        P_R=R_p5+(R_p6-R_p5)*(t-Seqt_R(6))/SeqItv_R(6);
        P_L=L_p5+(L_p6-L_p5)*(t-Seqt_R(6))/SeqItv_R(6);
        P_Red_can=P_RedCan1;
        P_Green_can=L_p5+(L_p6-L_p5)*(t-Seqt_R(6))/SeqItv_R(6);
        P_Blue_can=P_BlueCan1;
        P_handle_top=R_p5+(R_p6-R_p5)*(t-Seqt_R(6))/SeqItv_R(6);
        P_handle_bottom=R_p5+(R_p6-R_p5)*(t-Seqt_R(6))/SeqItv_R(6);
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=R_p5+(R_p6-R_p5)*(t-Seqt_R(6))/SeqItv_R(6);
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=R_p5+(R_p6-R_p5)*(t-Seqt_R(6))/SeqItv_R(6);
        
    elseif t<=Seqt_R(8)%���⩹z����-10
        P_R=R_p6+(R_p7-R_p6)*(t-Seqt_R(7))/SeqItv_R(7);
        P_L=L_p6+(L_p7-L_p6)*(t-Seqt_R(7))/SeqItv_R(7);
        P_Red_can=P_RedCan1;
        P_Green_can= L_p6+(L_p7-L_p6)*(t-Seqt_R(7))/SeqItv_R(7);
        P_Blue_can=P_BlueCan1;
        P_handle_top=R_p6+(R_p7-R_p6)*(t-Seqt_R(7))/SeqItv_R(7);
        P_handle_bottom=R_p6+(R_p7-R_p6)*(t-Seqt_R(7))/SeqItv_R(7);
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=R_p6+(R_p7-R_p6)*(t-Seqt_R(7))/SeqItv_R(7);
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=R_p6+(R_p7-R_p6)*(t-Seqt_R(7))/SeqItv_R(7);
        
    elseif t<=Seqt_R(9)%�k�����B�c��
        P_R=R_p8+rR8*[cos(0.5*pi*(t-Seqt_R(8))/SeqItv_R(8)+pi) sin(0.5*pi*(t-Seqt_R(8))/SeqItv_R(8)) 0];
%         P_R=R_p7+(R_pp8-R_p7)*(t-Seqt_R(8))/SeqItv_R(8);
        P_L=L_p7+(L_p8-L_p7)*(t-Seqt_R(8))/SeqItv_R(8);
        P_Red_can=P_RedCan1;
        P_Green_can=L_p7+(L_p8-L_p7)*(t-Seqt_R(8))/SeqItv_R(8);
        P_Blue_can=P_BlueCan1;
        P_handle_top=R_p8+rR8*[cos(0.5*pi*(t-Seqt_R(8))/SeqItv_R(8)+pi) sin(0.5*pi*(t-Seqt_R(8))/SeqItv_R(8)) 0];
        P_handle_bottom=R_p8+rR8*[cos(0.5*pi*(t-Seqt_R(8))/SeqItv_R(8)+pi) sin(0.5*pi*(t-Seqt_R(8))/SeqItv_R(8)) 0];
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=R_p8+rR8*[cos(0.5*pi*(t-Seqt_R(8))/SeqItv_R(8)+pi) sin(0.5*pi*(t-Seqt_R(8))/SeqItv_R(8)) 0];
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=R_p8+rR8*[cos(0.5*pi*(t-Seqt_R(8))/SeqItv_R(8)+pi) sin(0.5*pi*(t-Seqt_R(8))/SeqItv_R(8)) 0];

    elseif t<=Seqt_R(10)%���⩹x����-100
        P_R=R_pp8+(R_p9-R_pp8)*(t-Seqt_R(9))/SeqItv_R(9);
        P_L=L_p8+(L_p9-L_p8)*(t-Seqt_R(9))/SeqItv_R(9);
        P_Red_can=P_RedCan1;
        P_Green_can=L_p8+(L_p9-L_p8)*(t-Seqt_R(9))/SeqItv_R(9);
        P_Blue_can=P_BlueCan1;
        P_handle_top=handleTop;
        P_handle_bottom=handleBottom;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_Refri_L1_top;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_Refri_L1_bottom;
        
    elseif t<Seqt_R(11)%�k��a�W�h������
        P_R=R_p9+(R_p10-R_p9)*(t-Seqt_R(10))/SeqItv_R(10);
        P_L=L_p9+(L_p10-L_p9)*(t-Seqt_R(10))/SeqItv_R(10);
        P_Red_can=P_RedCan1;
        P_Green_can=L_p9+(L_p10-L_p9)*(t-Seqt_R(10))/SeqItv_R(10);
        P_Blue_can=P_BlueCan1;
        P_handle_top=handleTop;
        P_handle_bottom=handleBottom;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_Refri_L1_top;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_Refri_L1_bottom;
    else 
        P_R=R_p10;
        P_L=L_p10;
    end
    
    Pcnt_R=Pcnt_R+1;    
    Pcnt_L=Pcnt_L+1;    
    Path_R(Pcnt_R,1:3)=P_R;  %�W�e�����|�I
    Path_L(Pcnt_L,1:3)=P_L;  %�W�e�����|�I
    
    Red_can(Pcnt_R,1:3)=P_Red_can;
    Green_can(Pcnt_R,1:3)=P_Green_can;
    Blue_can(Pcnt_R,1:3)=P_Blue_can;
    handle_top(Pcnt_R,1:3)=P_handle_top;
    handle_bottom(Pcnt_R,1:3)=P_handle_bottom;
    refri_R1_top(Pcnt_R,1:3)=P_refri_R1_top;
    refri_L1_top(Pcnt_R,1:3)=P_refri_L1_top;
    refri_R1_bottom(Pcnt_R,1:3)=P_refri_R1_bottom;
    refri_L1_bottom(Pcnt_R,1:3)=P_refri_L1_bottom;
end



%==�e�����Ƹ��| �bcartesian space�U�U�ۥѫ�(x,y,z)���W��
%right hand
t=0:DEF_CYCLE_TIME:TotalTime_R; 
figure(2);
subplot(2,2,1),plot(t,Path_R(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x (mm)');
title('right hand t versus x') ; 

subplot(2,2,2),plot(t,Path_R(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y (mm)');
title('right hand t versus y') ; 

subplot(2,2,3),plot(t,Path_R(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z (mm)');
title('right hand t versus z') ; 

%left hand
t=0:DEF_CYCLE_TIME:TotalTime_L; 
figure(3);
subplot(2,2,1),plot(t,Path_L(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x (mm)');
title('left hand t versus x') ; 

subplot(2,2,2),plot(t,Path_L(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y (mm)');
title('left hand t versus y') ; 

subplot(2,2,3),plot(t,Path_L(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z (mm)');
title('left hand t versus z') ; 


%% ==�p���I�O����ŧi==%%
%Path_R=zeros(TotalPt,3);%�W�e�����|�I
PathPoint_R=zeros(Pcnt_R,3);%�O����ڤW���I�A�e�Ϩϥ�
PathTheta_R=zeros(Pcnt_R,7);%�O���C�b���סA�e�Ϩϥ�
 
%Path_L=zeros(TotalPt,3);%�W�e�����|�I
PathPoint_L=zeros(Pcnt_L,3);%�O����ڤW���I�A�e�Ϩϥ�
PathTheta_L=zeros(Pcnt_L,7);%�O���C�b���סA�e�Ϩϥ�

% Red_can=zeros(Pcnt_R,3);
% Green_can=zeros(Pcnt_R,3);
% Blue_can=zeros(Pcnt_R,3);
% handle_top=zeros(Pcnt_R,3);
% handle_bottom=zeros(Pcnt_R,3);
% refri_R1_top=zeros(Pcnt_R,3);
% refri_L1_top=zeros(Pcnt_R,3);
% refri_R1_bottom=zeros(Pcnt_R,3);
% refri_L1_bottom=zeros(Pcnt_R,3);

%% ==�y���I=>IK=>FK����== %%
DEF_DESCRETE_POINT=Pcnt_R;  %�Y�����I�Ƥ��P�|�����D
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
    %Draw_7DOF_FB7roll_point_dual(P_R,RotationM_R,PathPoint_R,P_L,RotationM_L,PathPoint_L);
   
    %�O���C�b�����ܤ�
    PathTheta_R(t,1:7)=theta_R*(180/pi);
    PathTheta_L(t,1:7)=theta_L*(180/pi);
    
    In_R=[in_x_end_R in_y_end_R in_z_end_R in_alpha_R in_beta_R in_gamma_R];
    Out_R=[out_x_end_R out_y_end_R out_z_end_R out_alpha_R out_beta_R out_gamma_R];
    
    In_L=[in_x_end_L in_y_end_L in_z_end_L in_alpha_L in_beta_L in_gamma_L]
    Out_L=[out_x_end_L out_y_end_L out_z_end_L out_alpha_L out_beta_L out_gamma_L]
    
%      plot3( Red_can(t,1), Red_can(t,2), Red_can(t,3),'ro','MarkerFaceColor','r','MarkerSize',20,'Linewidth',4);
% %     text(525,120,-70,'Red can') 
%     plot3( Green_can(t,1), Green_can(t,2), Green_can(t,3),'go','MarkerFaceColor','g','MarkerSize',20,'Linewidth',4);
% %     text(525,20,-70,'Green can')
%     plot3( Blue_can(t,1), Blue_can(t,2), Blue_can(t,3),'bo','MarkerFaceColor','b','MarkerSize',20,'Linewidth',4);
% %     text(525,-80,-70,'Blue can')
%     plot3([handle_top(t,1), handle_bottom(t,1)], [handle_top(t,2), handle_bottom(t,2)], [handle_top(t,3)+60, handle_bottom(t,3)-60], '-','Color',[0 0 0],'Linewidth',8); 
% 
%     plot3([refri_L1_top(t,1), refri_L1_bottom(t,1)],[refri_L1_top(t,2)+50, refri_L1_bottom(t,2)+50],[refri_L1_top(t,3)+210, refri_L1_bottom(t,3)-190],'-','Color',[0 0 0],'Linewidth',4); %Line2
%     plot3([refri_R1_top(t,1), refri_R1_bottom(t,1)],[refri_R1_top(t,2)+50, refri_R1_bottom(t,2)+50],[refri_R1_top(t,3)+210, refri_R1_bottom(t,3)-190],'-','Color',[0 0 0],'Linewidth',4); %Line6
%     plot3([refri_L1_top(t,1), refri_R1_top(t,1)],[refri_L1_top(t,2)+50, refri_R1_top(t,2)+50],[refri_L1_top(t,3)+210, refri_R1_top(t,3)+210],'-','Color',[0 0 0],'Linewidth',4); %Line9
%     plot3([refri_L1_bottom(t,1), refri_R1_bottom(t,1)],[refri_L1_bottom(t,2)+50, refri_R1_bottom(t,2)+50],[refri_L1_bottom(t,3)-190, refri_R1_bottom(t,3)-190],'-','Color',[0 0 0],'Linewidth',4); %Line11
    
    
    %pause(0.001);
end

%% ==�eJointAngle== %%
%right
figure(6); hold on; grid on; title('right hand joint angle'); xlabel('t'); ylabel('deg');
t=0:DEF_CYCLE_TIME:TotalTime_R; 
for i=1:1:7
    plot(t,PathTheta_R(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');

%left
figure(7); hold on; grid on; title('left hand joint angle'); xlabel('t'); ylabel('deg');
t=0:DEF_CYCLE_TIME:TotalTime_L; 
for i=1:1:7
    plot(t,PathTheta_L(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');

%% ==�eJointVel== %%
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
t=0:DEF_CYCLE_TIME:TotalTime_R; 
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
t=0:DEF_CYCLE_TIME:TotalTime_L; 
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
t=0:DEF_CYCLE_TIME:TotalTime_R; 
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
t=0:DEF_CYCLE_TIME:TotalTime_L; 
for i=1:1:7
    plot(t,PathAcc_L(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7')