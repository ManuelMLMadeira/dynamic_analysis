function[q,qd] = y2q(y)
% Store information for Report

    %Access global information
    
    global NCoordinates 

    %Create vectors q and qd
    q = y(1:NCoordinates,1);
    qd = y(NCoordinates+1:end,1);

    %Update Body information
    q2Body(q)
    qd2Body(qd)
    
% Finish function y2q
end