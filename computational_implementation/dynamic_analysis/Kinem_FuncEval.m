function [Phi,Jac,niu,gamma]  =  Kinem_FuncEval(time)

global NRevolute NDriver NConstraints NCoordinates

% calculate the constraint function equation
line = 1;
Phi = zeros(NConstraints,1);
Jac = zeros(NConstraints,NCoordinates);
niu = zeros(NConstraints,1);
gamma = zeros(NConstraints,1);

%For each revolute joint
for k = 1:NRevolute
    [Phi, Jac, niu, gamma, line] = JointRevolute(Phi,Jac,niu,gamma,k,line);
end

%For each driver 
for k = 1:NDriver
    [Phi, Jac, niu, gamma, line] = Driver(Phi,Jac,niu,gamma,k,line,time);
end


end