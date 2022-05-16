function q = PositionAnalysis(q0,time)

%global variables
global tol MaxIter flag

%form the constraint equations vector and the Jacobian
flag.position = 1;
flag.Jacobian = 1;
flag.velocity = 0;
flag.acceleration = 0;

%define initial error
error = 10*tol;
it = 0;
q = q0;
 
%start the NR equations
while (error>tol)
    it = it+1;
    %to avoid infinite loop (no convergence)
    if (it>MaxIter) 
        disp('There is something running more than what it is supposed - Position Analysis: it > MaxIter')
        break
    end

    [Phi,Jac,~,~] = Kinem_FuncEval(time);
    
    %Calculate correction step
    Deltaq = Jac\Phi;
   
    %Evaluate new positions and error
    q = q - Deltaq;
    % Update bodies with new q
    q2Body(q);
    
    error = max(abs(Deltaq));
end



end