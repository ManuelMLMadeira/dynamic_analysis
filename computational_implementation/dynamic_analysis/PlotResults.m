function [] = PlotResults(lambda,Jac,t)

bodymass = 51; %from data provided

% Get g for each revolute joint (refers to 2 lambdas)
for k = 1:13
    p = 2*k-1;
    % For each instant in time
    for j = 1:length(lambda)
        g_Rev(:,j,k) = -Jac(p:p+1,:,j)'*lambda(p:p+1,j)./bodymass; 
    end
end

% Get g for each driver (refers to 1 lambda)
for k = 1:16
    p = k + 26;
    for j = 1:length(lambda)
        g_Driver(:,j,k) = -Jac(p,:,j)'*lambda(p,j)./bodymass;
    end
end

%set time as percentage
time = ((t-t(1))/(t(end)-t(1)))*100;

%Plot joints

code = [1 2; 1 3; 3 4; 1 5; 5 6; 1 7; 7 8; 8 9; 9 10; 1 11; 11 12; 12 13; 13 14];
   
codenames = ['head and trunk,trunk and right arm,right arm and forearm,trunk and left arm,left arm and forearm,trunk and right thigh,right thigh and leg,right leg and ankle,right ankle and toes,trunk and left thigh,left thigh and leg,left leg and ankle, left ankle and toes'];
codenames= strsplit(codenames,',');

for i = 1:size(g_Rev,3)
    figure('NumberTitle', 'off','Name',sprintf('Revolute Joint %i',i))
    legend = codenames(i);
    body = code(i,:);
    hold on
    for j = 1:2
        subplot(2,3,3*j-2), plot(time,g_Rev(3*body(j)-1,:,i))
        xlabel('% of Motion'), title('Force x [N/Kg]'), axis tight;
        subplot(2,3,3*j-1), plot(time,g_Rev(3*body(j)-2,:,i))
        xlabel('% of Motion'), title('Force z [N/Kg]'), axis tight;
        subplot(2,3,3*j), plot(time,g_Rev(3*body(j),:,i))
        xlabel('% of Motion'), title('Moment [N.m/Kg]'), axis tight;
    end
    
    suptitle(strcat('Forces and moments of joint ', num2str(i), ' (', legend,')'));
  
    hold off
end


% Drivers

codedriver = ['Neck,Right shoulder,Right elbow,Left shoulder,Left elbow,Right hip,Right knee,Right ankle,Right toes,Left hip,Left knee,Left ankle,Left toes'];
codedriver = string(strsplit(codedriver,','));

for i= 1:(size(g_Driver,3)-3)
    figure('NumberTitle', 'off','Name',sprintf('Driver %i',i))
    legend = codedriver(1,i);
    bodyi = code(i,1);
    hold on
    plot(time,g_Driver(3*bodyi,:,i)), xlabel('% of Motion'),
    ylabel('Moment [N.m/Kg]'), axis tight;
    title(sprintf('%s driver', legend))
    hold off
end
    
