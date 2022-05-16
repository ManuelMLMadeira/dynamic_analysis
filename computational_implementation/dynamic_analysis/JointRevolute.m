function[Phi,Jac,niu,gamma,line] = JointRevolute(Phi,Jac,niu,gamma,k,line)
% Computes all the contributions of revolute joints of position, velocity
% and acceleration analysis, if required.


% Access global memory
global JntRevolute flag Body

% Define local variables
i = JntRevolute(k).i;
j = JntRevolute(k).j;
spPi = JntRevolute(k).spi;
spPj = JntRevolute(k).spj;

l1 = line;
l2 = line + 1;

% Position Constraint Equation
if (flag.position == 1)
    Phi(l1:l2) = Body(i).r + Body(i).A*spPi - (Body(j).r + Body(j).A*spPj);
end

% Jacobian Matrix
if (flag.Jacobian == 1)
    JacRevi = [eye(2) Body(i).B*spPi];
    JacRevj = [-eye(2) -Body(j).B*spPj];
    
    c1 = 3*i-2;
    c2 = c1+2;
    c3 = 3*j-2;
    c4 = c3+2;
    
    Jac(l1:l2,c1:c2) = JacRevi;
    Jac(l1:l2,c3:c4) = JacRevj;
end

% Right hand side of velocity equations
if (flag.velocity ==1)
    niu(l1:l2,1) = 0; %the niu for the joint constraints is always zero
end

% Right hand side of acceleration equations
if (flag.acceleration == 1)
    gamma(l1:l2,1) = Body(i).A * spPi*Body(i).thetad^2 - ...
                     Body(j).A * spPj*Body(j).thetad^2;
end

% Update line number for next constraint
line = line+2;

% Finish function
end