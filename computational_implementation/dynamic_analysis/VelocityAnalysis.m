function qd = VelocityAnalysis(time)

%global variables
global flag

%Form Jacobian matrix
flag.position = 0;
flag.Jacobian = 1;
flag.velocity = 1;
flag.acceleration = 0;

[~,Jac,niu,~] = Kinem_FuncEval(time);

%Solve system and equations
qd = Jac\niu;

end