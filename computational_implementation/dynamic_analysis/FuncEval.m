function [yd,lambda,Jac] = FuncEval(time,y)
% Function to evaluate yd as required by the time integrator (ode45)

    %Access global memory
    global flag NConstraints NCoordinates
    
    %Transfer positions and velocities to body arrays
    [q,qd] = y2q(y);

    %Build the process matrix
    [M] = BuildMassMatrix();

    flag.position = 1;
    flag.jacobian = 1;
    flag.velocity = 1;
    flag.acceleration = 1;
    
    % Build Jacobian Matrix and gamma
    [Phi,Jac,niu,gamma] = Kinem_FuncEval(time);
    alpha = 5;
    beta = 5;
    %Formule CM11 slide 19
    
    gamma = gamma-2*alpha*(Jac*qd-niu)-beta^2*Phi;
    
    %Build the force vector
    [g] = BuildForceVector(time);
    
    %Build leading Matrix and r.h.s. vector
    Null = zeros(NConstraints,NConstraints);
    [Mat] = [M Jac'; 
             Jac Null];
    b = [g;
         gamma];
    
    %Solve the system of linear equations
    x = Mat\b;

    %Form the acceleration and lagrange multiplies vectors
    qdd = x(1:NCoordinates,1);
    lambda = x(NCoordinates+1:end,1);

    %Form vector yd
    yd = [qd;
          qdd];
   
    
    %Finish function Evaluation
end