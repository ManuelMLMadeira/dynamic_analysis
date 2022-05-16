function [q, qd] = CorrectInitialConditions()
    % global memory assignement
    global tstart
    % setup the inital conditions for Kinematic Analysis
    time = tstart;
    q0 = Body2q();

    % Perform the position Analysis
    q = PositionAnalysis(q0,time);
    % Update bodies
    q2Body(q);
    
    % Perform the velocity Analysis
    qd = VelocityAnalysis(time);
    
    %Transfer data to working arrays
    qd2Body(qd)
    
    % end function CorrectInitalConditions
end