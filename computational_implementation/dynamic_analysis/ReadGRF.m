function ReadGRF(SamplingFrequency)
%This function reads and filters the data from the force plates

%Access global memory
global FPlate

% Transforms the data from the local reference of the force plates to the
% global reference frame of the laboratory. The output includes the
% magnitude of the forces in x, y and z and the position of the center of
% pressure in x, y and z.

[fp1,fp2,fp3] = tsv2mat(0, 0, 0);

% Time frame
Time = 0 : 1/SamplingFrequency : (size(fp1,1)-1)/SamplingFrequency;

% Saves the data into a structure
RawData(1).fp = fp1;
RawData(2).fp = fp2;
RawData(3).fp = fp3;

% Goes through all force plates and processes the results

for i = 1:3
    
    % Saves only the data relevant for the 2D analysis. The data eliminated
    % for the positions is eliminated here as well.
    
    FPData = [RawData(i).fp(:,1),RawData(i).fp(:,3),...
        RawData(i).fp(:,4)*1e-3,RawData(i).fp(:,6)*1e-3];
    
    % Filters the data
    FilteredFPData = FilterForcePlateData(FPData,SamplingFrequency);
    
    % Saves the data in an output structure
    FPlate(i).Data = [Time',FilteredFPData];
    
    % End of the loop that goes through all force plates
    
end

%End of fuction
end
