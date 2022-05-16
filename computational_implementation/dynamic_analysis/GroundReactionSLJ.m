function GroundForce = GroundReactionSLJ(k,t)

global FPlate Body  

clear GroundForce

    % LEFT

    pos_left = Body(FPlate(k).i).r(1,1) + Body(FPlate(k).i).A*FPlate(k).spi; % left foot
    
    if ppval(FPlate(k).COPx,t) > pos_left(1)
        GroundForce.i_left = FPlate(k).j;
    else
        GroundForce.i_left = FPlate(k).i;
    end
    
    GroundForce.force_left = [ppval(FPlate(k).fx,t);
                               ppval(FPlate(k).fz,t)]/2;
                           
    GroundForce.spP_left = [ppval(FPlate(k).COPx,t)-Body(GroundForce.i_left).r(1,1);
                             ppval(FPlate(k).COPz,t)-Body(GroundForce.i_left).r(2,1)];
                   
    % RIGHT
    
    pos_right = Body(FPlate(2).i).r(1,1) + Body(FPlate(2).i).A*FPlate(2).spi; % because the right foot is associated to FPlate2
    
    if ppval(FPlate(k).COPx,t) > pos_right(1)
        GroundForce.i_right = FPlate(2).j;
    else
        GroundForce.i_right = FPlate(2).i;
    end               
    
    GroundForce.force_right = [ppval(FPlate(k).fx,t);
                              ppval(FPlate(k).fz,t)]/2;
    
    GroundForce.spP_right = [ppval(FPlate(k).COPx,t)-Body(GroundForce.i_right).r(1,1);
                             ppval(FPlate(k).COPz,t)-Body(GroundForce.i_right).r(2,1)];
    
                   
end