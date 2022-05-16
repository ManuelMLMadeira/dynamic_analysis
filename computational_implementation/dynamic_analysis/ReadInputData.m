function []= ReadInputData()

    % Function to read an input file (written as txt) for the biomechanical
    % system to be studied

    global file NBody NRevolute NGround NDriver NFPlates NConstraints Body 
    global JntRevolute JntDriver NCoordinates Nsteps MaxIter tstart tstep tend
    global FPlate tol grav tspan fs

    % Load the input file name
    [file,~]=uigetfile('*.txt','Select the dynamic model file (Gait or Jump)');
    H=dlmread(file);
    file=file(20:end-4);

    % Store the general dimensions of system
    NBody = H(1,1);
    NRevolute = H(1,2);
    NGround = H(1,3);
    NDriver = H(1,4);
    NFPlates = H(1,5);


    NConstraints = 2*NRevolute + 3*NGround + NDriver;
    line = 1;

    % Store data for rigid body transformation

    for i = 1:NBody
        line = line+1;
        Body(i).mass = H(line,2);
        Body(i).inertia = H(line,3);
        Body(i).r = H(line,4:5)';
        Body(i).theta = H(line,6);
        Body(i).rd = H(line,7:8)';
        Body(i).thetad = H(line,9);
        Body(i).PCoM=H(line,10);
        Body(i).Length=H(line,11);
        ctheta = cos(Body(i).theta);
        stheta = sin(Body(i).theta);
        Body(i).A = [ctheta -stheta
                     stheta ctheta];
        Body(i).B = [-stheta -ctheta
                      ctheta -stheta];
    end

    % Store data for revolute joint

    for k = 1:NRevolute
        line = line + 1;
        JntRevolute(k).i = H(line,2);
        JntRevolute(k).j = H(line,3);
        JntRevolute(k).spi = H(line,4:5)';
        JntRevolute(k).spj = H(line,6:7)';
    end

    for i = 1:NDriver 
        line=line+1;
        JntDriver(i).type = H(line,2);
        JntDriver(i).i = H(line,3);
        JntDriver(i).coordi = H(line,4);
        JntDriver(i).j = H(line,5);
        JntDriver(i).coordj = H(line,6);
        
        name  =  sprintf('%d.txt',i);
        D  =  dlmread(strcat(file,name));
        t = D(:,1);
        z = unwrap(D(:,2));

        % Spline interpolation
        JntDriver(i).p = spline(t,z);
       
        % Initialize arrays
        Nsplines = JntDriver(i).p.pieces;
        coefs_d = zeros(Nsplines,3);
        coefs_dd = zeros(Nsplines,2);

        % Calculate spline 1st derivative and build v for each driver
        for k = 1:Nsplines
            coefs_d(k,:) = polyder(JntDriver(i).p.coefs(k,:));
        end
        JntDriver(i).v = mkpp(t,coefs_d);
        
%         figure (2*i-1)
%         hold on
%         plot(t,ppval(JntDriver(i).v,t))
        

        % Calculate spline 2nd derivative and build a for each driver
        for k = 1:Nsplines
            coefs_dd(k,:) = polyder(JntDriver(i).v.coefs(k,:));
        end
        JntDriver(i).a = mkpp(t,coefs_dd);
        
%         figure(2*i)
%         hold on 
%         plot(t,ppval(JntDriver(i).a,t))
       
        %FILTERING 
        JntDriver(i).v = ResidualAnalysis(ppval(JntDriver(i).v,t),1/(t(2)-t(1)));
        JntDriver(i).v = spline(t,JntDriver(i).v);
%         figure(2*i-1)
%         plot(t,ppval(JntDriver(i).v,t))
%         hold off
        JntDriver(i).a = ResidualAnalysis(ppval(JntDriver(i).a,t),1/(t(2)-t(1)));
        JntDriver(i).a = spline(t,JntDriver(i).a);
%         figure(2*i)
%         
%         plot(t,ppval(JntDriver(i).a,t))
%         hold off 
    end
    

    for i = 1:NFPlates
        line = line+1;
        FPlate(i).i = H(line,2);
        FPlate(i).j = H(line,3);
        FPlate(i).spi = H(line,4:5)';
        FPlate(i).spj = H(line,6:7)';
        
        name = sprintf('%d.txt',i);
        D = dlmread(strcat(file,'FPlates_',name));
        t1 = D(:,1);
        fx = D(:,2);
        fz = D(:,3);
        COPx = D(:,4);
        COPz = D(:,5);

        %spline interpolation
        FPlate(i).fx = spline(t1,fx);
        
        FPlate(i).fz = spline(t1,fz);

        %save COP
        FPlate(i).COPx = spline(t1,COPx);
        FPlate(i).COPz = spline(t1,COPz);
        
    end

    % Store data for analysis period and time step
    line = line+1; 
    tstart = H(line,1);
    tstep = H(line,2);
    tend = H(line,3);
    Nsteps = round((tend-tstart)/tstep) + 1;

    NCoordinates = 3*NBody;
    % Analysis conditions 
    tol = 10^(-6);
    grav = [0; -9.81];
    tspan = tstart:tstep:tend;
    MaxIter = 12;
    fs = 1/tstep;
    
    
end