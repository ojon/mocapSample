function xyzStruct_out = bvh2xyz(skel, channels)

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
  thisPosition = [xpos; ypos; zpos];
  if ~skel.tree(i).parent
    xyzStruct(i).rotation = thisRotation;
    xyzStruct(i).xyz = (skel.tree(i).offset)' + thisPosition; % transposed to fit column convention
  else
    xyzStruct(i).xyz = ...
        xyzStruct(skel.tree(i).parent).rotation * ((skel.tree(i).offset)' + thisPosition) ...
        + xyzStruct(skel.tree(i).parent).xyz;
    xyzStruct(i).rotation = xyzStruct(skel.tree(i).parent).rotation * thisRotation;
    
  end
  xyzStruct_out(i).rotation = xyzStruct(i).rotation;
  xyzStruct_out(i).xyz = xyzStruct(i).xyz;
end



function transmat =  maketrans
% the transformation necessary to transform into the orientation demanded
% for our purposes, this may be altered to be more elegant in future (at
% skeletal level), this was investigated, but it is hard to apply based
% purely on the structure of the skeleton, so this observation based
% approach is going to be applied, which assumes that the basic skeletal
% structure remains consistent for every recording from Ipi.
transmat{1} = [0 0 -1; 0 1 0; 1 0 0];
transmat{2} = [0 1 0; -1 0 0; 0 0 1];
transmat{3} = [0 1 0; -1 0 0; 0 0 1];
transmat{4} = [0 1 0; -1 0 0; 0 0 1];
transmat{5} = [0 1 0; -1 0 0; 0 0 1];
transmat{6} = [0 1 0; -1 0 0; 0 0 1];
transmat{7} = eye(3);
transmat{8} = [0 1 0; 0 0 1; 1 0 0];
transmat{9} = [0 1 0; 0 0 1; 1 0 0];
transmat{10} = [0 1 0; 0 0 1; 1 0 0];
transmat{11} = [0 1 0; 0 0 1; 1 0 0];
transmat{12} = eye(3);
transmat{13} = [0 1 0; 0 0 -1; -1 0 0];
transmat{14} = [0 1 0; 0 0 -1; -1 0 0];
transmat{15} = [0 1 0; 0 0 -1; -1 0 0];
transmat{16} = [0 1 0; 0 0 -1; -1 0 0];
transmat{17} = eye(3);
transmat{18} = [0 -1 0; -1 0 0; 0 0 -1];
transmat{19} = [0 0 -1; 0 1 0; 1 0 0];
transmat{20} = [0 0 -1; 0 1 0; 1 0 0];
transmat{21} = eye(3);
transmat{22} = eye(3);
transmat{23} = [0 -1 0; -1 0 0; 0 0 -1];
transmat{24} = [0 0 1; 0 1 0; -1 0 0];
transmat{25} = [0 0 1; 0 1 0; -1 0 0];
transmat{26} = eye(3);
transmat{27} = eye(3);