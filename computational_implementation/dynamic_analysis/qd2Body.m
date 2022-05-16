function qd2Body(qd)

global Body NBody

    for i = 1:NBody
        i1 = 3*i-2;
        i2 = i1+1;
        i3 = i2+1;
        Body(i).rd = qd(i1:i2,1);
        Body(i).thetad = qd(i3,1);
    end
    
end