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

x_base_R=0;   %����I
y_base_R=0;
z_base_R=0;

x_base_L=0;   %����I
y_base_L=0;
z_base_L=0;

SeqPt_R=[   500 -50 0;
            500 -200 0;
            500 -200 -200;
            500 -50 -200;
            500 -50 0]

SeqPt_L=[   500 50 0;
            500 200 0;
            500 200 -200;
            500 50 -200;
            500 50 0]
     
    
SeqVel_R=zeros(size(SeqPt_R,1)+1,3);
SeqAcc_R=zeros(size(SeqPt_R,1),3);

SeqVel_L=zeros(size(SeqPt_L,1)+1,3);
SeqAcc_L=zeros(size(SeqPt_L,1),3);
   
Seqt_R=[0 2 4 6 8];%����ɶ��Эp 
TotalTime_R=8;
tk_R=0.5;%�G�����u���ɶ�

Seqt_L=[0 2 4 6 8];
TotalTime_L=8;
tk_L=0.5;

%==�p��Cartesian Space�U�U�q�t��==%
%right
for i=1:1:size(SeqVel_R,1)
    if i==1        %V0
        SeqVel_R(i,1:3)=[0 0 0];
    elseif (i==2 || i==(size(SeqVel_R,1)-1))  %V1 or Vf�e�@��
        SeqVel_R(i,1:3)=(SeqPt_R(i,1:3)-SeqPt_R(i-1,1:3))/(Seqt_R(i)-Seqt_R(i-1)-0.5*tk_R);   
    elseif i==size(SeqVel_R,1)
        SeqVel_R(i,1:3)=[0 0 0];
    else
        SeqVel_R(i,1:3)=(SeqPt_R(i,1:3)-SeqPt_R(i-1,1:3))/(Seqt_R(i)-Seqt_R(i-1));   
    end
end

%left
for i=1:1:size(SeqVel_L,1)
    if i==1        %V0
        SeqVel_L(i,1:3)=[0 0 0];
    elseif (i==2 || i==(size(SeqVel_L,1)-1))  %V1 or Vf�e�@��
        SeqVel_L(i,1:3)=(SeqPt_L(i,1:3)-SeqPt_L(i-1,1:3))/(Seqt_L(i)-Seqt_L(i-1)-0.5*tk_L);   
    elseif i==size(SeqVel_L,1)
        SeqVel_L(i,1:3)=[0 0 0];
    else
        SeqVel_L(i,1:3)=(SeqPt_L(i,1:3)-SeqPt_L(i-1,1:3))/(Seqt_L(i)-Seqt_L(i-1));   
    end
end

%==�p��Cartesian Space�U�q�[�t��==%
%right
for i=1:1:size(SeqAcc_R,1)
     SeqAcc_R(i,1:3)=(SeqVel_R(i+1,1:3)-SeqVel_R(i,1:3))/tk_R;
end
%left
for i=1:1:size(SeqAcc_L,1)
     SeqAcc_L(i,1:3)=(SeqVel_L(i+1,1:3)-SeqVel_L(i,1:3))/tk_L;
end


%==�ϥ�linear fuction �W����ΦU�q�y��  �@5�I  4�q���u�_  5�q�G���q==%
%right
DEF_CYCLE_TIME=0.1;
Pcnt_R=0;%��X�`�I��
for t=0:DEF_CYCLE_TIME:TotalTime_R
    if t<tk_R                  %%parabolic
            Pseg=1;
            VSeg=1;
            ASeg=1;
            P=SeqPt_R(Pseg,1:3)+SeqVel_R(Pseg,1:3)*(t-0)+0.5*SeqAcc_R(ASeg,1:3)*(t-0)^2;  
    elseif t<Seqt_R(2)-0.5*tk_R   %linear
            Pseg=1;
            VSeg=2;
            ASeg=2;
            P=SeqPt_R(Pseg,1:3)+SeqVel_R(VSeg,1:3)*(t-0.5*tk_R);  
    elseif t<Seqt_R(2)+0.5*tk_R%parabolic
            Pseg=1;
            VSeg=2;    
            ASeg=2;
            P=SeqPt_R(Pseg,1:3)+SeqVel_R(VSeg,1:3)*(t-0.5*tk_R)+0.5*SeqAcc_R(ASeg,1:3)*(t-(Seqt_R(2)-0.5*tk_R))^2;  
    elseif t<Seqt_R(3)-0.5*tk_R      %linear 
            Pseg=2;
            VSeg=3;    
            ASeg=2;
            P=SeqPt_R(Pseg,1:3)+SeqVel_R(VSeg,1:3)*(t-Seqt_R(2));
    elseif t< Seqt_R(3)+0.5*tk_R %parabolic
            Pseg=2;
            VSeg=3;   
            ASeg=3;
            P=SeqPt_R(Pseg,1:3)+SeqVel_R(VSeg,1:3)*(t-Seqt_R(2))+0.5*SeqAcc_R(ASeg,1:3)*(t-(Seqt_R(3)-0.5*tk_R))^2;  
    elseif t<Seqt_R(4)-0.5*tk_R      %linear 
            Pseg=3;
            VSeg=4;    
            ASeg=3;
            P=SeqPt_R(Pseg,1:3)+SeqVel_R(VSeg,1:3)*(t-Seqt_R(3));
    elseif t< Seqt_R(4)+0.5*tk_R %parabolic
            Pseg=3;
            VSeg=4;   
            ASeg=4;
            P=SeqPt_R(Pseg,1:3)+SeqVel_R(VSeg,1:3)*(t-Seqt_R(3))+0.5*SeqAcc_R(ASeg,1:3)*(t-(Seqt_R(4)-0.5*tk_R))^2;          
            
    elseif t< Seqt_R(5)-tk_R %linear before final
            Pseg=4;
            VSeg=5;   
            ASeg=4;
            P=SeqPt_R(Pseg,1:3)+SeqVel_R(VSeg,1:3)*(t-Seqt_R(4));
    elseif t< Seqt_R(5)%parabolic  final
            Pseg=4;
            VSeg=5;   
            ASeg=5;
            P=SeqPt_R(Pseg,1:3)+SeqVel_R(VSeg,1:3)*(t-Seqt_R(4))+0.5*SeqAcc_R(ASeg,1:3)*(t-(Seqt_R(5)-tk_R))^2;  
    end
    
    Pcnt_R=Pcnt_R+1;       
    Path_R(Pcnt_R,1:3)=P;  %�W�e�����|�I
end


%left
Pcnt_L=0;
for t=0:DEF_CYCLE_TIME:TotalTime_L
    if t<tk_L                  %%parabolic
            Pseg=1;
            VSeg=1;
            ASeg=1;
            P=SeqPt_L(Pseg,1:3)+SeqVel_L(Pseg,1:3)*(t-0)+0.5*SeqAcc_L(ASeg,1:3)*(t-0)^2;  
    elseif t<Seqt_L(2)-0.5*tk_L   %linear
            Pseg=1;
            VSeg=2;
            ASeg=2;
            P=SeqPt_L(Pseg,1:3)+SeqVel_L(VSeg,1:3)*(t-0.5*tk_L);  
    elseif t<Seqt_L(2)+0.5*tk_L%parabolic
            Pseg=1;
            VSeg=2;    
            ASeg=2;
            P=SeqPt_L(Pseg,1:3)+SeqVel_L(VSeg,1:3)*(t-0.5*tk_L)+0.5*SeqAcc_L(ASeg,1:3)*(t-(Seqt_L(2)-0.5*tk_L))^2;  
    elseif t<Seqt_L(3)-0.5*tk_L      %linear 
            Pseg=2;
            VSeg=3;    
            ASeg=2;
            P=SeqPt_L(Pseg,1:3)+SeqVel_L(VSeg,1:3)*(t-Seqt_L(2));
    elseif t< Seqt_L(3)+0.5*tk_L %parabolic
            Pseg=2;
            VSeg=3;   
            ASeg=3;
            P=SeqPt_L(Pseg,1:3)+SeqVel_L(VSeg,1:3)*(t-Seqt_L(2))+0.5*SeqAcc_L(ASeg,1:3)*(t-(Seqt_L(3)-0.5*tk_L))^2;  
    elseif t<Seqt_L(4)-0.5*tk_L      %linear 
            Pseg=3;
            VSeg=4;    
            ASeg=3;
            P=SeqPt_L(Pseg,1:3)+SeqVel_L(VSeg,1:3)*(t-Seqt_L(3));
    elseif t< Seqt_L(4)+0.5*tk_L %parabolic
            Pseg=3;
            VSeg=4;   
            ASeg=4;
            P=SeqPt_L(Pseg,1:3)+SeqVel_L(VSeg,1:3)*(t-Seqt_L(3))+0.5*SeqAcc_L(ASeg,1:3)*(t-(Seqt_L(4)-0.5*tk_L))^2;          
            
    elseif t< Seqt_L(5)-tk_L %linear before final
            Pseg=4;
            VSeg=5;   
            ASeg=4;
            P=SeqPt_L(Pseg,1:3)+SeqVel_L(VSeg,1:3)*(t-Seqt_L(4));
    elseif t< Seqt_L(5)%parabolic  final
            Pseg=4;
            VSeg=5;   
            ASeg=5;
            P=SeqPt_L(Pseg,1:3)+SeqVel_L(VSeg,1:3)*(t-Seqt_L(4))+0.5*SeqAcc_L(ASeg,1:3)*(t-(Seqt_L(5)-tk_L))^2;  
    end
    
    Pcnt_L=Pcnt_L+1;       
    Path_L(Pcnt_L,1:3)=P;  %�W�e�����|�I
end

%==�elinear fuction �bcartesian space�U�U�ۥѫ�(x,y,z)���W��
%right hand
t=1:1:Pcnt_R; 
figure(2);
subplot(2,2,1),plot(t,Path_R(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x');
title('right hand t versus x') ; 

subplot(2,2,2),plot(t,Path_R(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y');
title('right hand t versus y') ; 

subplot(2,2,3),plot(t,Path_R(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z');
title('right hand t versus z') ; 

%left hand
t=1:1:Pcnt_L; 
figure(2);
subplot(2,2,1),plot(t,Path_L(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x');
title('left hand t versus x') ; 

subplot(2,2,2),plot(t,Path_L(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y');
title('left hand t versus y') ; 

subplot(2,2,3),plot(t,Path_L(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z');
title('left hand t versus z') ; 

%==�p��õe�U�ۥѫ�(x,y,z)���t��
%right hand
for i=1:1:Pcnt_R-1
   Path_vel_R(i,:)=Path_R(i+1,:)-Path_R(i,:);
end

t=1:1:size(Path_vel_R,1);  

figure(3);
subplot(2,2,1),plot(t,Path_vel_R(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x/t');
title('right hand t versus x/t') ;   
 
subplot(2,2,2),plot(t,Path_vel_R(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y/t');
title('right hand t versus y/t') ; 

subplot(2,2,3),plot(t,Path_vel_R(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z/t');
title('right hand t versus z/t') ;

%left hand
for i=1:1:Pcnt_L-1
   Path_vel_L(i,:)=Path_L(i+1,:)-Path_L(i,:);
end

t=1:1:size(Path_vel_L,1);  

figure(3);
subplot(2,2,1),plot(t,Path_vel_L(:,1),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('x/t');
title('left hand t versus x/t') ;   
 
subplot(2,2,2),plot(t,Path_vel_L(:,2),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('y/t');
title('left hand t versus y/t') ; 

subplot(2,2,3),plot(t,Path_vel_L(:,3),'LineWidth',2); 
grid on;
xlabel('t');
ylabel('z/t');
title('left hand t versus z/t') ;


%==�p���I�O����ŧi=%
PathPoint_R=zeros(Pcnt_R,3);%�O����ڤW���I�A�e�Ϩϥ�
PathTheta_R=zeros(Pcnt_R,7);%�O���C�b���סA�e�Ϩϥ�
PathPoint_L=zeros(Pcnt_L,3);%�O����ڤW���I�A�e�Ϩϥ�
PathTheta_L=zeros(Pcnt_L,7);%�O���C�b���סA�e�Ϩϥ�


%==�y���I=>IK=>FK����==%
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
    
    in_alpha_L=-60*(pi/180);
    in_beta_L=0*(t/DEF_DESCRETE_POINT)*(pi/180);
    in_gamma_L=0*(t/DEF_DESCRETE_POINT)*(pi/180);

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
    
   
    pause(0.001);
end



%�eJointAngle
figure(4);
Draw_7DOF_JointAnglePath(PathTheta_R);
xlabel('t');
ylabel('angle');
title('right hand t versus angle') ;

figure(5);
Draw_7DOF_JointAnglePath(PathTheta_L);
xlabel('t');
ylabel('angle');
title('left hand t versus angle') ;


PathVel_R=zeros(size(PathTheta_R,1),7);
for i=1:1:size(PathTheta_R,1)
    if(i==1)
         PathVel_R(i,:)= PathVel_R(i,:);
    else
         PathVel_R(i,:)=PathTheta_R(i,:)-PathTheta_R(i-1,:);
    end
end
figure(6);
Draw_7DOF_JointVelPath(PathVel_R);
xlabel('t');
ylabel('angle/t');
title('right hand t versus angle/t') ;


PathVel_L=zeros(size(PathTheta_L,1),7);
for i=1:1:size(PathTheta_L,1)
    if(i==1)
         PathVel_L(i,:)= PathVel_L(i,:);
    else
         PathVel_L(i,:)=PathTheta_L(i,:)-PathTheta_L(i-1,:);
    end
end
figure(7);
Draw_7DOF_JointVelPath(PathVel_L);
xlabel('t');
ylabel('angle/t');
title('left hand t versus angle/t') ;