function [ROT] = euler_rot(joint_rotmat,conv)
    % [ROT] = euler_rot(joint_rotmat,conv)
	% joint_rotmat = 3 x 3 rotation matrix
	% This function calculates euler angles from a rotation matrix
	% with the specific application of biomechanical analysis.
	% Therefore only ZXY and YXY conventions included here.
	% 
	% Right hand positive sign convention

% if conv ==1 then ZXY convention, if conv == 2 then YXY convention

    if conv == 1
        ROT(1,1) = asind(joint_rotmat(3,2));
        ROT(2,1) = rad2deg(-atan2(joint_rotmat(3,1),joint_rotmat(3,3)));
        ROT(3,1) = rad2deg(-atan2(joint_rotmat(1,2),joint_rotmat(2,2)));
    elseif conv == 2
        ROT(1,1) = rad2deg(atan2(joint_rotmat(1,2),joint_rotmat(3,2)));
        ROT(2,1) = acosd(joint_rotmat(2,2));
        ROT(3,1) = rad2deg((-atan2(joint_rotmat(2,1),joint_rotmat(2,3))));
    end
end
