 function ProcessedData = FilterForcePlateData(ProcessedData, SamplingFrequency)
% Considering only the vertical component of the force, it will estimate
% the instants of time in which contact existed by finding 
% the time steps for which the force was larger than 5 N
global file

% ContactTimeSteps = find(ProcessedData(:,2) > 5);
% ContactIndices = (ProcessedData(:,2) > 5);

% Filters the forces
for j = 1 : 2

    % Filters the force data resorting to Residual Analysis
    
    FilteredData = ResidualAnalysis(ProcessedData(:,j),...
         SamplingFrequency);
    
    
    % The instants of time for which no contact existed will be assigned
    % a 0 N force
    if (strcmp(file,'gait'))
        thr = 7;
    else
        thr = 10;
    end
    
    ContactTimeSteps = find(ProcessedData(:,2) > thr);
    ContactIndices = (ProcessedData(:,2) > thr);
    
    FilteredData(~ContactIndices) = 0;
    
    
    % Update the output
    ProcessedData(:,j) = FilteredData;
    
end

% Filters the center of pressure
for j = 3 : 4
    % Before filtering, the position of the center of pressure
    % imediately before ad after contact will be put at those
    % positions to diminish the impact of the filter adaptation
    RawCoP = ProcessedData(:,j);

    if ((~isempty(ContactTimeSteps))&& (ContactTimeSteps(1) > 1))
        % Puts the position for all time steps before contact equal to
        % the position of the first contact
        RawCoP(1 : ContactTimeSteps(1) - 1) = RawCoP(ContactTimeSteps(1));
    end 
    
    if ((~isempty(ContactTimeSteps))&&(ContactTimeSteps(end)<length(RawCoP)))
        % Puts the position for all time steps after contact equal to
        % the position of the last contact  
        RawCoP(ContactTimeSteps(end) + 1 : end) = RawCoP(ContactTimeSteps(end));
    end 
    
   
    % Filters the x of the center of pressure resorting to residual
    % analysis (the z of COP is always 0)
    cutoff_freq = 10;
    if (~isempty(ContactTimeSteps)) && j~=4
        FilteredData = DoublePassLPFilter(RawCoP, cutoff_freq, SamplingFrequency);
    else 
        FilteredData = RawCoP;
    end
    
%     % Debug
%     figure
%     plot(FilteredData)
%     hold on
%     plot(DoublePassLPFilter(RawCoP, 10, SamplingFrequency)) 
%     hold on
%     plot(RawCoP)
%     hold off
%     legend('RA', 'lpf10','raw')

    % Update the output
    ProcessedData(:,j) = FilteredData;
    
end 

end
 

    