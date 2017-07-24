
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
Seqt= zeros(1,14);
%����ɶ��Эp 
i=1;
Seqt(i)=0;
i=i+1;
Seqt(i)=20;%�k�⩹�����������A��m����
i=i+1;
Seqt(i)=24;%�k�⧨��hold
i=i+1;
Seqt(i)=58;%�k�⩹����}�����A��m����
i=i+1;
Seqt(i)=60;%���⩹�񶼮��I�e�i���~1
i=i+1;
Seqt(i)=75;%���⩹�񶼮��I�e�i���~2
i=i+1;
Seqt(i)=90;%���⩹�񶼮��I
i=i+1;
Seqt(i)=95;%���⧨��hold
i=i+1;
Seqt(i)=110;%����q�񶼮��I�h�^���~1
i=i+1;
Seqt(i)=120;%����q�񶼮��I�h�^���~2
i=i+1;
Seqt(i)=150;%�k�⩹�����������A��m����
i=i+1;
Seqt(i)=155;%�k�⧨��rlease
i=i+1;
Seqt(i)=160;%����q�񶼮��I�h�^���~3
i=i+1;
Seqt(i)=170;%���k��^��̫����ⴤ���Ʀ�m

TotalTime=170;

SeqItv=zeros(1, size(Seqt,2)-1);

for i=1:1:size(SeqItv,2)
    SeqItv(i)=Seqt(i+1)-Seqt(i);
end    

% Seqt_L= [0 6 26 29 31 39 47 50 54 58 65]%����ɶ��Эp 
% TotalTime_L=65;
% SeqItv_L=zeros(1, size(Seqt_L,2)-1);
% 
% for i=1:1:size(SeqItv_L,2)
%     SeqItv_L(i)=Seqt_L(i+1)-Seqt_L(i);
% end    

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
R_p=[   300 -300 -200;%�_�l�I
        500 50 -210;%�����������A��m
        150 -300 -210;%����}�����A��m
        500 50 -210;%�����������A��m
        200 0 -300];%�̫����ⴤ���Ʀ�m
    
L_p=[   300 200 -200;%�_�l�I
        400 200 -200;%���⩹�񶼮��I�e�i���~1
        400 100 -200;%���⩹�񶼮��I�e�i���~2
        520  -60 -200;%�񶼮��I
        400 100 -200;%����q�񶼮��I�h�^���~1
        400 200 -210;%����q�񶼮��I�h�^���~2
        300 200 -210;%����q�񶼮��I�h�^���~3
        200 0 -300];%�̫����ⴤ���Ʀ�m
   
rDoorPath = 50-(50-650)*0.5;
Cen_DoorPath = [500 (50-650)*0.5 -210]; %�Ԫ��b�|��� center of open door path


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

DEF_CYCLE_TIME=0.022;
Pcnt_R=0;%��X�`�I��
Pcnt_L=0;%�ثe�M�k��@�� ���ӷQ��k����}

for abst=0:DEF_CYCLE_TIME:TotalTime
    if abst<=Seqt(2)%�k�⩹�����������A��m����
        Itv=SeqItv(1);
        t=abst-Seqt(1);
        
        P_R=R_p(1,:)+(R_p(2,:)-R_p(1,:))*t/Itv;
        P_L=L_p(1,:);
        
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=handleTop;
        P_handle_bottom=handleBottom;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_Refri_L1_top;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_Refri_L1_bottom;
        
    elseif abst<=Seqt(3)%�k�⧨��hold
        Itv=SeqItv(2);
        t=abst-Seqt(2);
        
        P_R=R_p(2,:);
        P_L=L_p(1,:);
        
    elseif abst<=Seqt(4)%�k�⩹����}�����A��m����
        Itv=SeqItv(3);
        t=abst-Seqt(3);
        
        P_R=Cen_DoorPath+rDoorPath*[sin(0.5*pi*t/Itv+ pi) cos(0.5*pi*t/Itv) 0];
        P_L=L_p(1,:);
        
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=P_R;
        P_handle_bottom=P_R;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_R;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_R;
        
    elseif abst<=Seqt(5) %���⩹�񶼮��I�e�i���~1 %���⩹x����100
        Itv=SeqItv(4);
        t=abst-Seqt(4);
        
        P_R=R_p(3,:);
        P_L=L_p(1,:)+(L_p(2,:)-L_p(1,:))*t/Itv;

        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=P_R;
        P_handle_bottom=P_R;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_R;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_R;
        
            
        
    elseif abst<=Seqt(6)%���⩹�񶼮��I�e�i���~2 ���⩹y����-100
        Itv=SeqItv(5);
        t=abst-Seqt(5);
        
        P_R=R_p(3,:);
        P_L=L_p(2,:)+(L_p(3,:)-L_p(2,:))*t/Itv;
        
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=P_R;
        P_handle_bottom=P_R;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_R;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_R;
        
    elseif abst<=Seqt(7)%���Ⲿ�ʨ�񶼮��I
        Itv=SeqItv(6);
        t=abst-Seqt(6);
        
        P_R=R_p(3,:);
        P_L=L_p(3,:)+(L_p(4,:)-L_p(3,:))*t/Itv;
     
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=P_R;
        P_handle_bottom=P_R;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_R;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_R;
        
    elseif abst<=Seqt(8)%���⧨��hold
        Itv=SeqItv(7);
        t=abst-Seqt(7);
        
        P_R=R_p(3,:);
        P_L=L_p(4,:);
     
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=P_GreenCan1;
        P_Blue_can=P_BlueCan1;
        P_handle_top=P_R;
        P_handle_bottom=P_R;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_R;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_R;
        
    elseif abst<=Seqt(9)%����q�񶼮��I�h�^���~1
        Itv=SeqItv(8);
        t=abst-Seqt(8);
        
        P_R=R_p(3,:);
        P_L=L_p(4,:)+(L_p(5,:)-L_p(4,:))*t/Itv;
        
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=L_p(4,:)+(L_p(5,:)-L_p(4,:))*t/Itv;
        P_Blue_can=P_BlueCan1;
        P_handle_top=P_R;
        P_handle_bottom=P_R;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_R;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_R;
        
    elseif abst<=Seqt(10)%����q�񶼮��I�h�^���~2 %���⩹z����-10
        Itv=SeqItv(9);
        t=abst-Seqt(9);
        
        P_R=R_p(3,:);
        P_L=L_p(5,:)+(L_p(6,:)-L_p(5,:))*t/Itv;
        
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can= P_L;
        P_Blue_can=P_BlueCan1;
        P_handle_top=P_R;
        P_handle_bottom=P_R;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_R;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_R;
        
    elseif abst<=Seqt(11)%�k�⩹�����������A��m����
        Itv=SeqItv(10);
        t=abst-Seqt(10);
        
        P_R=Cen_DoorPath+rDoorPath*[cos(0.5*pi*t/Itv+pi) sin(0.5*pi*t/Itv) 0];
        P_L=L_p(6,:);
        
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=L_p(6,:);
        P_Blue_can=P_BlueCan1;
        P_handle_top=P_R;
        P_handle_bottom=P_R;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_R;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_R;
    elseif abst<=Seqt(12)%�k�⧨��rlease
        Itv=SeqItv(11);
        t=abst-Seqt(11);
        
        P_R=R_p(4,:);
        P_L=L_p(6,:);
        
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=L_p(6,:);
        P_Blue_can=P_BlueCan1;
        P_handle_top=P_R;
        P_handle_bottom=P_R;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_R;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_R;
        
        
    elseif abst<=Seqt(13)%����q�񶼮��I�h�^���~3 %���⩹x����-100
        Itv=SeqItv(12);
        t=abst-Seqt(12);
        
        P_R=R_p(4,:);
        P_L=L_p(6,:)+(L_p(7,:)-L_p(6,:))*t/Itv;
        
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=P_L;
        P_Blue_can=P_BlueCan1;
        P_handle_top=handleTop;
        P_handle_bottom=handleBottom;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_Refri_L1_top;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_Refri_L1_bottom;
        
    elseif abst<Seqt(14)%���k��^��̫����ⴤ���Ʀ�m
        Itv=SeqItv(13);
        t=abst-Seqt(13);
        
        P_R=R_p(4,:)+(R_p(5,:)-R_p(4,:))*t/Itv;
        P_L=L_p(7,:)+(L_p(8,:)-L_p(7,:))*t/Itv;
        
        %�����I��
        P_Red_can=P_RedCan1;
        P_Green_can=P_L;
        P_Blue_can=P_BlueCan1;
        P_handle_top=handleTop;
        P_handle_bottom=handleBottom;
        P_refri_R1_top=P_Refri_R1_top;
        P_refri_L1_top=P_Refri_L1_top;
        P_refri_R1_bottom=P_Refri_R1_bottom;
        P_refri_L1_bottom=P_Refri_L1_bottom;
    else 
        P_R=R_p(5,:);
        P_L=L_p(8,:);
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
t=0:DEF_CYCLE_TIME:TotalTime; 
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
t=0:DEF_CYCLE_TIME:TotalTime; 
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
cnt=0;
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
    
    
    pause(0.001);
end

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
figure(9); hold on; grid on; title('left hand joint rotation speed'); xlabel('t'); ylabel('deg/s');
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

figure(10); hold on; grid on; title('right hand acc'); xlabel('t'); ylabel('deg/s^2');
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

figure(11); hold on; grid on; title('left hand acc'); xlabel('t'); ylabel('deg/t^2');
t=0:DEF_CYCLE_TIME:TotalTime; 
for i=1:1:7
    plot(t,PathAcc_L(:,i),'LineWidth',2); 
end
legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7')