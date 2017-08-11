
clear all
close all
clc



%�T�w�Ѽ�
DEF_RIGHT_HAND=1;
DEF_LEFT_HAND=2;

%% ==���c�T�w�Ѽ�==%
L0=225;   %�Y��ӻH
L1=250;   %L�� ����
L2=25;    %L�� �u��
L3=25;    %L�� �u��
L4=230;   %L�� ���� 
L5=180;   %��end-effector

x_base_R=0;   %����I
y_base_R=0;
z_base_R=0;

x_base_L=0;   %����I
y_base_L=0;
z_base_L=0;



%% ==�Ѱ_�l�I���e�i100�i��k��u���_��   ���Ƥj�p200x200  ��t10==%%
R_p=[   300 -10 0;
        500 -10 0;%�k�⩹�e200
        300 -10 0;%�k���P�}�� x����h200 
        500 -10 0;%�k��x ��P���e200   
        300 -10 0;%�k���P�}x����200
        500 -10 0];%�k��x���e200
    
L_p=[   300 90 0;
        500 90 0;%���⩹�e200
        500 90 0;%���⤣��
        300 90 0;%����x ��P����200  
        300 90 0;%���⤣��
        500 90 0];%����x���e200


%% ==���q�Эp== %% 
i=1;
S_INITIAL=i;
i=i+1;
S_RL_F_200=i;%�k�⩹�e200 %���⩹�e200
i=i+1;
S_R_X_B_200_S1=i;%�k���P�}�� x����h200 %���⤣��
i=i+1;
S_R_X_CIRF_200_L_X_CIRB_200=i;%�k��x ��P���e200 %����x��P����200  
i=i+1;
S_R_X_B_200_S2=i;%�k���P�}x����200 %���⤣��
i=i+1;
S_R_X_F_200_L_X_F_200=i;%�k��x���e200 %����x���e200

%{
S_INITIAL=1;
S_RL_F_200=2;
S_R_X_B_200_S1=3;
S_R_X_CIRF_200_L_X_CIRB_200=4;
S_R_X_B_200_S2=5;
S_R_X_F_200_L_X_F_200=6;
%}


%% ==�U�q��O�ɶ�== %% 
SeqItv=zeros(1,6);

SeqItv(S_INITIAL)=0;
SeqItv(S_RL_F_200)=10;%�k�⩹�e200 %���⩹�e200
SeqItv(S_R_X_B_200_S1)=5;%�k���P�}�� x����h200 %���⤣��
SeqItv(S_R_X_CIRF_200_L_X_CIRB_200)=10;%�k��x ��P���e200 %����x��P����200  
SeqItv(S_R_X_B_200_S2)=5;%�k���P�}x����200 %���⤣��
SeqItv(S_R_X_F_200_L_X_F_200)=10;%�k��x���e200 %����x���e200


%% ==����ɶ��Эp== %% 
Seqt=zeros(1,i);

CurT=0;
for i=1:1:size(SeqItv,2)
    CurT=CurT+SeqItv(i);
    Seqt(i)=CurT;
end    

TotalTime=CurT;
DEF_CYCLE_TIME=1;

%% ==trajectory generator== %% 
Pcnt=0;%��X�`�I��
for abst=0:DEF_CYCLE_TIME:TotalTime
    if abst<=Seqt(S_RL_F_200)%�k�⩹�e200 %���⩹�e200
        Itv=SeqItv(S_RL_F_200);
        t=abst-Seqt(S_INITIAL);

        P_R=R_p(S_INITIAL,:)+(R_p(S_RL_F_200,:)-R_p(S_INITIAL,:))*t/Itv;
        P_L=L_p(S_INITIAL,:)+(L_p(S_RL_F_200,:)-L_p(S_INITIAL,:))*t/Itv;
    elseif abst<=Seqt(S_R_X_B_200_S1)%�k���P�}�� x����h200 %���⤣��
        Itv=SeqItv(S_R_X_B_200_S1);
        t=abst-Seqt(S_RL_F_200);

        P_R=R_p(S_RL_F_200,:)+(R_p(S_R_X_B_200_S1,:)-R_p(S_RL_F_200,:))*t/Itv;
        P_L=L_p(S_RL_F_200,:);
    elseif abst<=Seqt(S_R_X_CIRF_200_L_X_CIRB_200)%�k��x ��P���e200 %����x��P����200  
        Itv=SeqItv(S_R_X_CIRF_200_L_X_CIRB_200);
        t=abst-Seqt(S_R_X_B_200_S1);
        
        xcR=(500+300)*0.5;
        ycR=-10;
        zcR=0;
        rR=500-xcR;
        
        xcL=(500+300)*0.5;
        ycL=90;
        zcL=0;
        rL=500-xcL;
              
        P_R=[xcR ycR zcR]+rR*[cos( pi*t/Itv + pi) sin(pi*t/Itv + pi) 0]; %�k��U��W����
        P_L=[xcL ycL zcL]+rL*[cos( pi*t/Itv) sin(pi*t/Itv) 0]; %����W��U����
    elseif abst<=Seqt(S_R_X_B_200_S2) %�k���P�}x����200 %���⤣��
        Itv=SeqItv(S_R_X_B_200_S2);
        t=abst-Seqt(S_R_X_CIRF_200_L_X_CIRB_200);
        
        P_R=R_p(S_R_X_CIRF_200_L_X_CIRB_200,:)+(R_p(S_R_X_B_200_S2,:)-R_p(S_R_X_CIRF_200_L_X_CIRB_200,:))*t/Itv;
        P_L=L_p(S_R_X_CIRF_200_L_X_CIRB_200,:)+(L_p(S_R_X_B_200_S2,:)-L_p(S_R_X_CIRF_200_L_X_CIRB_200,:))*t/Itv;
    elseif abst<=Seqt(S_R_X_F_200_L_X_F_200)
        Itv=SeqItv(S_R_X_F_200_L_X_F_200);
        t=abst-Seqt(S_R_X_B_200_S2);
        
        P_R=R_p(S_R_X_B_200_S2,:)+(R_p(S_R_X_F_200_L_X_F_200,:)-R_p(S_R_X_F_200_L_X_F_200,:))*t/Itv;
        P_L=L_p(S_R_X_B_200_S2,:)+(L_p(S_R_X_F_200_L_X_F_200,:)-L_p(S_R_X_F_200_L_X_F_200,:))*t/Itv;

    end
    
    Pcnt=Pcnt+1;    
    Path_R(Pcnt,1:3)=P_R;  %�W�e�����|�I
    Path_L(Pcnt,1:3)=P_L;  %�W�e�����|�I
    
end

%==�e�bcartesian space�U�U�ۥѫ�(x,y,z)���W��
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

%==�p��õe�U�ۥѫ�(x,y,z)���t��
%right hand
for i=1:1:Pcnt-1
   Path_vel_R(i,:)=(Path_R(i+1,:)-Path_R(i,:))/DEF_CYCLE_TIME;
end

t=0:DEF_CYCLE_TIME:TotalTime-DEF_CYCLE_TIME; %�]���t�׷|�֤@�����

figure(4);
subplot(2,2,1),plot(t,Path_vel_R(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x/t (mm/s)');
title('right hand t versus x/t') ;   
 
subplot(2,2,2),plot(t,Path_vel_R(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y/t (mm/s)');
title('right hand t versus y/t') ; 

subplot(2,2,3),plot(t,Path_vel_R(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z/t (mm/s)');
title('right hand t versus z/t') ;

%left hand
for i=1:1:Pcnt-1
   Path_vel_L(i,:)=(Path_L(i+1,:)-Path_L(i,:))/DEF_CYCLE_TIME;
end

t=0:DEF_CYCLE_TIME:TotalTime-DEF_CYCLE_TIME; %�]���t�׷|�֤@�����

figure(5);
subplot(2,2,1),plot(t,Path_vel_L(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x/t (mm/s)');
title('left hand t versus x/t') ;   
 
subplot(2,2,2),plot(t,Path_vel_L(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y/t (mm/s)');
title('left hand t versus y/t') ; 

subplot(2,2,3),plot(t,Path_vel_L(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z/t (mm/s)');
title('left hand t versus z/t') ;


%% ==�p���I�O����ŧi==%%
PathPoint_R=zeros(Pcnt,3);%�O����ڤW���I�A�e�Ϩϥ�
PathTheta_R=zeros(Pcnt,7);%�O���C�b���סA�e�Ϩϥ�

PathPoint_L=zeros(Pcnt,3);%�O����ڤW���I�A�e�Ϩϥ�
PathTheta_L=zeros(Pcnt,7);%�O���C�b���סA�e�Ϩϥ�


%% ==Dual arm IK==%%
for t=1:1:Pcnt
 
    %��J�Ѽ�
    in_x_end_R=Path_R(t,1);
    in_y_end_R=Path_R(t,2);
    in_z_end_R=Path_R(t,3);
    
    in_x_end_L=Path_L(t,1);
    in_y_end_L=Path_L(t,2);
    in_z_end_L=Path_L(t,3);
   
    in_alpha_R=70*(pi/180);
    in_beta_R=-90*(pi/180);
    in_gamma_R=0*(t/Pcnt)*(pi/180);
    
    in_alpha_L=-60*(pi/180);
    in_beta_L=90*(pi/180);
    in_gamma_L=0*(t/Pcnt)*(pi/180);

    Rednt_alpha_R=-90*(pi/180);
    Rednt_alpha_L=90*(pi/180);

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
    in_base=[0;L0;0];%header0 �y�Шt������shoulder0 �y�Шt �tY��V��L0
    in_end=[in_x_end_L;in_y_end_L;in_z_end_L];
    in_PoseAngle=[in_alpha_L;in_beta_L;in_gamma_L];
    theta_L=IK_7DOF_FB7roll(DEF_LEFT_HAND,in_linkL,in_base,in_end,in_PoseAngle,Rednt_alpha_L);

    %AngleConstrain
    bover=AngleOverConstrain(DEF_LEFT_HAND,theta_L);
    if bover == true
        break;
    end    
    
    %forward kinematic
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
   
    pause(0.1);
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

%% == �Mfeedback���������==%% 
%�efeed back JointAngle �M�~�t
%right 
% figure(12); hold on; grid on; title('right hand feedback joint angle'); xlabel('t'); ylabel('angle');
% PathTheta_R_Read = csvread('D://GetDrinkJointAngle_R.csv'); 
% t=0:DEF_CYCLE_TIME:TotalTime; 
% for i=1:1:7
%     plot(t,PathTheta_R_Read(:,i+1),'LineWidth',2); 
% end
% hold off
% legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');
% 
% figure(13); hold on; grid on; title('right hand command vs feedback joint angle'); xlabel('t'); ylabel('abs(command-feedback) deg');
% PathTheta_R_Err=abs(PathTheta_R-PathTheta_R_Read(:,2:8));
% t=0:DEF_CYCLE_TIME:TotalTime; 
% for i=1:1:7
%     plot(t,PathTheta_R_Err(:,i),'LineWidth',2); 
% end
% legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');
% 
% %left
% figure(14); hold on; grid on; title('left hand feedback joint angle'); xlabel('t'); ylabel('angle');
% PathTheta_L_Read = csvread('D://GetDrinkJointAngle_L.csv'); 
% t=0:DEF_CYCLE_TIME:TotalTime; 
% for i=1:1:7
%     plot(t,PathTheta_L_Read(:,i+1),'LineWidth',2); 
% end
% legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');
% 
% figure(15); hold on; grid on; title('left hand command vs feedback joint angle'); xlabel('t'); ylabel('abs(command-feedback) deg');
% PathTheta_L_Err=abs(PathTheta_L-PathTheta_L_Read(:,2:8));
% t=0:DEF_CYCLE_TIME:TotalTime; 
% for i=1:1:7
%     plot(t,PathTheta_L_Err(:,i),'LineWidth',2); 
% end
% legend('axis1','axis2','axis3','axis4','axis5','axis6','axis7');