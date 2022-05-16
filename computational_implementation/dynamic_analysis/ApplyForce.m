function [g] = ApplyForce(i,g,force,sP)
    i1 = 3*i-2;
    i2 = i1+1;
    i3 = i2+1;
    g(i1:i2,1) = g(i1:i2,1) + force;
    g(i3,1) = g(i3,1) + sP(1,1)*force(2,1)-sP(2,1)*force(1,1);
end