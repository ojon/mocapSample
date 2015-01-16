clear;
clc;
load('./transmatf_IPI.mat');
load('dadosThrow0.mat');

[skel channelsMatrix] = bvhReadFile('./throw.bvh');

nFrames = size(channelsMatrix,1)

for i = 1:nFrames
    
    %valores dos canais para o frame 1
    channelsFrame = channelsMatrix(i,:)
    
    %angulos do arquivo bvh para a articulacao/segmento do quadril(1)
    %valores em rad no frame atual
    [xHangle yHangle zHangle] = originalAngles(1,channelsFrame,skel);
    
    %matriz de rotacao do quadril    
    hRot = rotationMatrix(xHangle, yHangle, zHangle, skel.tree(1).order);
    
    %angulos do arquivo bvh para a articulaca/segmento da coxa(18)    
    [xTangle yTangle zTangle] = originalAngles(18,channelsFrame,skel);
    
    %matriz de rotacao da coxa    
    tRot = rotationMatrix(xTangle, yTangle, zTangle, skel.tree(18).order);        
    tRot = hRot * tRot;
    
    %matriz de rotacao relativa??
    %transmat eh a matriz de rotacao especifica para padroes IPI
    hipRelROT = (hRot*transmat{1})' * (tRot*transmat{18});
    
    hipAng = euler_rot(hipRelROT,1);
    hipAngs(:,i) = hipAng;
    
    %angulos do arquivo bvh para a articulacao/segmento da perna(19)    
    [xSangle ySangle zSangle] = originalAngles(19,channelsFrame,skel);
    
    %matriz de rotacao da perna    
    sRot = rotationMatrix(xSangle, ySangle, zSangle, skel.tree(19).order);        
    sRot = tRot * sRot;
    
    %matriz de rotacao relativa??
    %transmat eh a matriz de rotacao especifica para padroes IPI
    kneeRelROT = (tRot*transmat{18})' * (sRot*transmat{19});
    
    kneeAng = euler_rot(kneeRelROT,1);
    KneeAngs(:,i) = kneeAng;
                    
end