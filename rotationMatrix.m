function rotMat = rotationMatrix(xangle, yangle, zangle, order);

% ROTATIONMATRIX Compute the rotation matrix for an angle in each direction.
%
%	Description:
%
%	ROTATIONMATRIX(XANGLE, YANGLE, ZANGLE, ORDER) is a helper function
%	for computing the rotation matrix for a given set of angles in a
%	given order.
%	 Arguments:
%	  XANGLE - rotation for x-axis.
%	  YANGLE - rotation for y-axis.
%	  ZANGLE - rotation for z-axis.
%	  ORDER - the order for the rotations.
%	
%
%	See also
%	BVH2XYZ, ACCLAIM2XYZ


%	Copyright (c) 2005, 2006 Neil D. Lawrence
% 	rotationMatrix.m CVS version 1.3
% 	rotationMatrix.m SVN version 42
% 	last update 2008-08-12T20:23:47.000000Z

if nargin < 4
  order = 'zxy';
end
if isempty(order)
  order = 'zxy';
end
% Here we assume we rotate z, then x then y.
c1 = cos(xangle); % The x angle
c2 = cos(yangle); % The y angle
c3 = cos(zangle); % the z angle
s1 = sin(xangle);
s2 = sin(yangle);
s3 = sin(zangle);

% see http://en.wikipedia.org/wiki/Rotation_matrix for
% additional info.

% x y and z rotation matrices math those used by Zatsiorsky
  rotMat = eye(3);
  for i = 1:length(order)
    switch order(i)
     case 'x'
      rotMat = rotMat*[1 0 0
                0  c1 -s1
                0 s1 c1];
     case 'y'
      rotMat = rotMat*[c2 0 s2
                0 1 0
                -s2 0 c2];
     case 'z' 
      rotMat = rotMat*[c3 -s3 0
                s3 c3 0
                0 0 1];
      
    end
  end
  

