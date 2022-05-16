function [] = ReportResults(y,t)

global Body NBody file Nsteps NCoordinates


% Obtain Lagrange multipliers and other variables of interest
for i = 1:length(t)
    [yd(i,:),lambda(:,i),Jac(:,:,i)] = FuncEval(t(i),y(i,:)');
end

%Obtain q values
q = y(:,1:NCoordinates)';
qd = y(:,NCoordinates+1:end)';
qdd = yd(:,NCoordinates+1:end)';

% Remove the first 10 steps and last 10 steps of gait cycle
if strcmp(file,'gait')
    q = q(:,11:end-10); 
    qd = qd(:,11:end-10);
    qdd = qdd(:,11:end-10);
    t = t(11:end-10);
    Nsteps = Nsteps - 20;
    Jac = Jac(:,:,11:end-10);
    lambda = lambda(:,11:end-10);
else
    q = q(:,81:end-100);
    qd = qd(:,81:end-100);
    qdd = qdd(:,81:end-100);
    t = t(81:end-100);
    Nsteps = Nsteps - 180;
    Jac = Jac(:,:,81:end-100);
    lambda = lambda(:,81:end-100);
end


% Plot the stick figure
for i = 1:NBody
    x = 3*i-2;
    y = 3*i-1;
    theta = 3*i;
    for k = 1:Nsteps
       
        A = [cos(q(theta,k)) -sin(q(theta,k)); sin(q(theta,k)) cos(q(theta,k))];
        csi_global = A*[1;0];
        pProx(:,k) = q(x:y,k)+csi_global*(1-Body(i).PCoM)*Body(i).Length; % distal point
        pDist(:,k) = q(x:y,k)-csi_global*(Body(i).PCoM)*Body(i).Length; %proximal point

    end
    Body(i).pProx = pProx;
    Body(i).pDist = pDist;

end

 figure
 r = 1:Nsteps;
 Animate(r);
 

% Plots of the forces and moments 
PlotResults(lambda,Jac,t);   


end

