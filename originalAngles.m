function [xAngle yAngle zAngle] = originalAngles(i,channelsFrame,skel)

xAngleDegree = channelsFrame(skel.tree(i).rotInd(1));
yAngleDegree = channelsFrame(skel.tree(i).rotInd(2));
zAngleDegree = channelsFrame(skel.tree(i).rotInd(3));

xAngle = deg2rad(xAngleDegree);
yAngle = deg2rad(yAngleDegree);
zAngle = deg2rad(zAngleDegree);

end