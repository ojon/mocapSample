clear;
clc;
[skel channelsMatrix] = bvhReadFile('./throw.bvh');
load('./transmatf_IPI.mat');
load('dadosThrow0.mat');
angs = []

for i = 1:94
    
    channelsFrame = channelsMatrix(i,:)
    
    %Hip
    xHAngleDegree = channelsFrame(skel.tree(1).rotInd(1));
    yHAngleDegree = channelsFrame(skel.tree(1).rotInd(2));
    zHAngleDegree = channelsFrame(skel.tree(1).rotInd(3));
    
    xHangle = deg2rad(xHAngleDegree);
    yHangle = deg2rad(yHAngleDegree);
    zHangle = deg2rad(zHAngleDegree);
    
    hRot = rotationMatrix(xHangle, yHangle, zHangle, skel.tree(1).order);
    
    %RThight
    xTAngleDegree = channelsFrame(skel.tree(18).rotInd(1));
    yTAngleDegree = channelsFrame(skel.tree(18).rotInd(2));
    zTAngleDegree = channelsFrame(skel.tree(18).rotInd(3));
    
    xTangle = deg2rad(xTAngleDegree);
    yTangle = deg2rad(yTAngleDegree);
    zTangle = deg2rad(zTAngleDegree);
    
    tRot = rotationMatrix(xTangle, yTangle, zTangle, skel.tree(18).order);
    
    %relROT = hRot' * tRot;
    
    %euler_rot(relROT,1)
    
    relROT = (hRot*transmat{1})' * (tRot*transmat{18});
    
    ang = euler_rot(relROT,1);
    EULER(:,i) = ang;
    
    angs = [angs ang];
end
    EULER = deg2rad(EULER'); EULER = unwrap(EULER,pi()*0.9); EULER = rad2deg(EULER);
    EULER = EULER';
