%% GroundReactions
% run preprocessing and then this

global FPlate Data

motion_indexes = 81:Data.nframes-100;
motion_percentage = (motion_indexes - motion_indexes(1))/(motion_indexes(end) - motion_indexes(1));
ylims = [-50 200; -50 200];

GroundForces = FPlate(1).Data(motion_indexes,2:3)/2;
gfy = GroundForces(:,2);
gfx = GroundForces(:,1);
 
figure
plot(motion_percentage,gfy,'LineWidth',2)
title('GroundReaction Forces - Vertical Component')
xlabel('% of Motion')
ylabel ('Force [N]')
% ylim(ylims(1,:))

figure
plot(motion_percentage,GroundForces(:,1),'LineWidth',2)
title('GroundReaction Forces - Horizontal Component')
xlabel('% of Motion')
ylabel ('Force [N]')
ylim(ylims(2,:))