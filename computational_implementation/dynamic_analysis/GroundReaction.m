function GroundForce = GroundReaction(k,t)

global FPlate Body  

clear GroundForce

    pos = Body(FPlate(k).i).r(1,1) + Body(FPlate(k).i).A*FPlate(k).spi;
    
    if ppval(FPlate(k).COPx,t) > pos(1)
        GroundForce.i = FPlate(k).j;
    else
        GroundForce.i = FPlate(k).i;
    end
        
    GroundForce.force = [ppval(FPlate(k).fx,t);
                         ppval(FPlate(k).fz,t)];
    GroundForce.spP = [ppval(FPlate(k).COPx,t)-Body(GroundForce.i).r(1,1);
                       ppval(FPlate(k).COPz,t)-Body(GroundForce.i).r(2,1)];
                   
end