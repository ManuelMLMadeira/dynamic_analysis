function [g] = ForceContact(g,time)

    global FPlate file
    
    inds = find([ppval(FPlate(1).fz,time) ppval(FPlate(2).fz,time) ppval(FPlate(3).fz,time)]>5); %puts forces below 5N to 0
    NForces = length(inds);
    
    for k = 1:NForces
        plate_j = inds(k);
        
        % if the motion is gait, each foot in each plate
        if strcmp(file, 'gait')
            [GroundForce] = GroundReaction(plate_j,time);
            g = ApplyForce(GroundForce.i,g,GroundForce.force,GroundForce.spP);
        
        % if the motion is Standing Long Jump, two feet in plates 1 and 3 (no feet in 2)
        else
            [GroundForce] = GroundReactionSLJ(plate_j,time);
            g = ApplyForce(GroundForce.i_right,g,GroundForce.force_right,GroundForce.spP_right);
            g = ApplyForce(GroundForce.i_left,g,GroundForce.force_left,GroundForce.spP_left);
        end

    end
    
end