
%input parameter
%arc_cen=Needle_RobotF %������
%R_starP %�k�����_�I
%R_endP %�k�������I
%L_starP %�������_�I
%L_endP %���������I
%rot_rad %����ɪ��_�l���ਤ��
%CostTime ��O�ɶ�

arc_cen=arc_cen+TranFrameToRobot;
if (Coordinate == DEF_OBJFRAME_COOR)
    L_starP(1,1:3)=L_starP(1,1:3)+TranFrameToRobot;
    L_endP(1,1:3)=L_endP(1,1:3)+TranFrameToRobot;
    R_starP(1,1:3)=R_starP(1,1:3)+TranFrameToRobot;
    R_endP(1,1:3)=R_endP(1,1:3)+TranFrameToRobot;
end

%�k���P���|
rR=sqrt((R_starP(1)-arc_cen(1))^2+(R_starP(2)-arc_cen(2))^2);%�k�����b�|
ini_rad_R=pi+atan((R_starP(2)-arc_cen(2))/(R_starP(1)-arc_cen(1)));%����ɪ��_�l���ਤ��

%�����P���|
rL=sqrt((L_starP(1)-arc_cen(1))^2+(L_starP(2)-arc_cen(2))^2);
ini_rad_L=atan((L_starP(2)-arc_cen(2))/(L_starP(1)-arc_cen(1)));

for t=0:DEF_CYCLE_TIME:CostTime
        PathPlanPoint_R=[arc_cen 0 0 0 0] +rR*[cos(rot_rad*t/CostTime+ini_rad_R) sin(rot_rad*t/CostTime+ini_rad_R) 0 0 0 0 0]+[0 0 0 R_starP(4:7)+(R_endP(4:7)-R_starP(4:7))*t/CostTime]; %�k��W��U����
        PathPlanPoint_L=[arc_cen 0 0 0 0] +rL*[cos(rot_rad*t/CostTime+ini_rad_L) sin(rot_rad*t/CostTime+ini_rad_L) 0 0 0 0 0]+[0 0 0 L_starP(4:7)+(L_endP(4:7)-L_starP(4:7))*t/CostTime]; %����W��U����

        if (FRAME_UPDATE==true)
            ObjCenter=(PathPlanPoint_R(1:3)+PathPlanPoint_L(1:3))/2;%�p���_�����|�P����I�y��
            V_oc_lend=PathPlanPoint_L(1:3)-ObjCenter;%�_���������I�쥪�⪺�V�q
            V_oc_lend_ro_p90=[V_oc_lend 1]*Rz(0.5*pi);
            V_oc_lend_ro_n90=[V_oc_lend 1]*Rz(-0.5*pi);
            ObjCorner=[ PathPlanPoint_L(1:3); 
                        ObjCenter+V_oc_lend_ro_p90(1:3);
                        PathPlanPoint_R(1:3);
                        ObjCenter+V_oc_lend_ro_n90(1:3)];         
        end         
    VerifyOutput_script;
    
end


