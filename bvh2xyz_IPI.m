function xyzStruct_out = bvh2xyz_IPI(skel, channels, transmat)

% BVH2XYZ Compute XYZ values given structure and channels.
%
%	Description:
%
%	XYZ = BVH2XYZ(SKEL, CHANNELS) Computes X, Y, Z coordinates given a
%	BVH skeleton structure and an associated set of channels.
%	 Returns:
%	  XYZ - the point cloud positions for the skeleton.
%	 Arguments:
%	  SKEL - a skeleton for the bvh file.
%	  CHANNELS - the channels for the bvh file.
%	
%
%	See also
%	ACCLAIM2XYZ, SKEL2XYZ


%	Copyright (c) 2005, 2008 Neil D. Lawrence
% 	bvh2xyz.m CVS version 1.3
% 	bvh2xyz.m SVN version 42
% 	last update 2008-08-12T20:23:47.000000Z
xyzStruct(1:length(skel.tree)) = struct('rotation', [], 'xyz', []); 
xyzStruct_out(1:length(skel.tree)) = struct('rotation', [], 'xyz', []); 

for i = 1:length(skel.tree)  
  if ~isempty(skel.tree(i).posInd)
    xpos = channels(skel.tree(i).posInd(1));
    ypos = channels(skel.tree(i).posInd(2));
    zpos = channels(skel.tree(i).posInd(3));
  else
    xpos = 0;
    ypos = 0;
    zpos = 0;
  end
  
  if nargin < 2 || isempty(skel.tree(i).rotInd)
    xangle = 0;
    yangle = 0;
    zangle = 0;
  else
    xangle = deg2rad(channels(skel.tree(i).rotInd(1)));
    yangle = deg2rad(channels(skel.tree(i).rotInd(2)));
    zangle = deg2rad(channels(skel.tree(i).rotInd(3)));
  end
  thisRotation = rotationMatrix(xangle, yangle, zangle, skel.tree(i).order);
  % Checked the 'rotationMatrix' function, it conforms with the equations
  % in Zatsiorsky and therefore should have the local axes of the segment
  % down the columns of the rotationmatrix
  thisPosition = [xpos; ypos; zpos];
  if ~skel.tree(i).parent
    xyzStruct(i).rotation = thisRotation;
    xyzStruct(i).xyz = (skel.tree(i).offset)' + thisPosition; % transposed to fit column convention
  else
    %rotacao do pai * (offset + thispos) + xyz do pa
    xyzStruct(i).xyz = ...       
        xyzStruct(skel.tree(i).parent).rotation * ((skel.tree(i).offset)' + thisPosition) ...
        + xyzStruct(skel.tree(i).parent).xyz;
    %rotacao do pai * thisrot
    xyzStruct(i).rotation = xyzStruct(skel.tree(i).parent).rotation * thisRotation;
    
  end
  %rot * transmat
  xyzStruct_out(i).rotation = xyzStruct(i).rotation * transmat{i};
  xyzStruct_out(i).xyz = xyzStruct(i).xyz;
end
