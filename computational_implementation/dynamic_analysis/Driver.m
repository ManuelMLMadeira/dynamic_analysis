function[Phi,Jac,niu,gamma,line] = Driver(Phi,Jac,niu,gamma,k,line,time)

% Access global memory
global JntDriver flag Body 

% Define local variables
bodyi = JntDriver(k).i;
type = JntDriver(k).type;
coordi = JntDriver(k).coordi;
bodyj = JntDriver(k).j;

l1 = line; % all drivers are just one equation
l2 = line;

% Position Constraint Equation
if (flag.position == 1)
    if (type == 1)          
        if (coordi == 1)
            Phi(l1:l2,1) = Body(bodyi).r(1,1) - ppval(JntDriver(k).p, time);
        elseif(coordi == 2)
            Phi(l1:l2,1) = Body(bodyi).r(2,1) - ppval(JntDriver(k).p, time);
        elseif (coordi == 3)
            Phi(l1:l2,1) = Body(bodyi).theta  - ppval(JntDriver(k).p, time);
        end
    elseif (type == 3)       
        Phi(l1:l2,1) = Body(bodyj).theta - (Body(bodyi).theta + ppval(JntDriver(k).p, time));
    end  
end

% Jacobian Matrix
if (flag.Jacobian ==1)
    if (type == 1)  
        c1 = 3*(bodyi-1) + coordi;
        c2 = c1;
        Jac(l1:l2,c1:c2) = 1;
    elseif (type == 3)
        c1 = 3*(bodyi-1) + 3;
        c2 = c1;
        Jac(l1:l2,c1:c2) = -1;
        c1 = 3*(bodyj-1) + 3;
        c2 = c1;
        Jac(l1:l2,c1:c2) = 1;
    end   
end

% Right hand side of velocity equations
if (flag.velocity == 1)
       niu(l1:l2,1) = ppval(JntDriver(k).v, time);
end

% Right hand side of acceleration equations
if (flag.acceleration == 1)
        gamma(l1:l2,1) = ppval(JntDriver(k).a, time);
end

%Update line number for next constraint
line = line+1;

%Finish function
end