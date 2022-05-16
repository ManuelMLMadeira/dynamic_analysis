function [g] = ForceGravity()
    %Acces global memory
    global Body NBody NCoordinates grav
    
    %Initialise the force vector
    g = zeros(NCoordinates, 1);
    
    %Gravity force for each body 
    for i = 1:NBody
        i1 = 3*i-2;
        i2 = i1+1;
        g(i1:i2) = Body(i).mass*grav;
    end
end