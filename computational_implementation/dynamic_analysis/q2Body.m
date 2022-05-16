function q2Body(q)

global Body NBody

    for i = 1:NBody
        i1 = 3*i-2;
        i2 = i1+1;
        i3 = i2+1;
        Body(i).r = q(i1:i2,1);
        Body(i).theta = q(i3,1);
        ctheta = cos(Body(i).theta);
        stheta = sin(Body(i).theta);
        Body(i).A = [ctheta -stheta
                     stheta ctheta];
        Body(i).B = [-stheta -ctheta
                      ctheta -stheta];
    end
    
end