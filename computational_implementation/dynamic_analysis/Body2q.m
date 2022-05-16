function q = Body2q()

global Body NBody

    for i = 1:NBody
        i1 = 3*i-2;
        i2 = i1+1;
        i3 = i2+1;
        q(i1:i2,1) = Body(i).r;
        q(i3,1) = Body(i).theta;
    end
    
end