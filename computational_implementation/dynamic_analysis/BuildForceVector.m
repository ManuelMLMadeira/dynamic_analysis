function [g] = BuildForceVector(time)
    
    %Add the gravitation forces 
    [g] = ForceGravity();
    
    %Add contact forces (ground contact with the feet) 
    [g] = ForceContact(g,time);
end