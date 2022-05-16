function Data = ReadProcessData(file)

file_xls = [file,'.xlsx'];

if strcmp(file,'static')
    %define data
    Data.nframes =xlsread(file_xls,1,'B1');
    Data.fs =xlsread(file_xls ,1,'B4');
    Data.coordinates =xlsread(file_xls ,1,'C12:BG205');
    Data.tstep=xlsread(file_xls ,1,'B13')-xlsread(file_xls ,1,'B12');
    Data.tend=xlsread(file_xls ,1,'B205')-xlsread(file_xls ,1,'B12');
    
elseif strcmp(file,'gait')
    %define data
    Data.nframes=xlsread(file_xls ,1,'B1');
    Data.fs=xlsread(file_xls ,1,'B4');
    Data.coordinates=xlsread(file_xls ,1,'C12:BG155'); 
    Data.tstep=xlsread(file_xls ,1,'B13')-xlsread(file_xls ,1,'B12');
    Data.tend=xlsread(file_xls ,1,'B155')-xlsread(file_xls ,1,'B12');
    
elseif strcmp(file,'jump')
    %define data
    Data.nframes=xlsread(file_xls ,1,'B1');
    Data.fs=xlsread(file_xls ,1,'B4');
    Data.coordinates=xlsread(file_xls ,1,'C12:BG413'); 
    Data.tstep=xlsread(file_xls ,1,'B13')-xlsread(file_xls ,1,'B12');
    Data.tend=xlsread(file_xls ,1,'B413')-xlsread(file_xls ,1,'B12');
end

%Project onto sagital plane (get x and z coordinates for each body)
i = 1;
j = 1;
while i <= size(Data.coordinates,2)
    Temp(:,j) = Data.coordinates(:,i);
    Temp(:,j+1) = Data.coordinates(:,i+2);
    i = i + 3;
    j = j + 2;
end
Data.coordinates = Temp;

%Organize data according to definition of the biomechanical model, which is
%as follows:
% P1 - Head; P2 - Midpoint between shoulders; P3 - Right elbow;
% P4 - Right wrist; P5 - Left elbow; P6 - Left wrist;
% P7 - Midpoint between hips; P8 - Right knee; P9 - Right ankle;
% P10 - Right metatarsal; P11 - Right hallux; P12 - Left knee;
% P13 - Left ankle; P14 - Left metatarsal; P15 - Left hallux;

%Data from the lab is organized as follows:
% 1 - Head; 2 - L_Shoulder; 3 - L_Elbow; 
% 4 - L_Wrist; 5 - R_Shoulder; 6 - R_Elbow;
% 7 - R_Wrist; 8 - L_Hip; 9 - L_Knee; 
% 10 - L_Ankle; 11 - L_Heel; 12 - L_Meta_V;
% 13 - L_Toe_II; 14 - R_Hip; 15 - R_Knee; 
% 16 - R_Ankle; 17 - R_Heel; 18 - R_Meta_V;
% 19 - R_Toe_II;

FilteredData = [FilteredCoordinates(Data.coordinates(:,1:2),Data.fs),... %Head
   (FilteredCoordinates(Data.coordinates(:,3:4),Data.fs) + FilteredCoordinates(Data.coordinates(:,9:10),Data.fs))/2,...  %Midpoint between shoulders
    FilteredCoordinates(Data.coordinates(:,11:12),Data.fs),...   %Right elbow
    FilteredCoordinates(Data.coordinates(:,13:14),Data.fs),...   %Right wrist
    FilteredCoordinates(Data.coordinates(:,5:6),Data.fs),...     % Left elbow
    FilteredCoordinates(Data.coordinates(:,7:8),Data.fs),...     % Left Wrist
   (FilteredCoordinates(Data.coordinates(:,15:16),Data.fs) + FilteredCoordinates(Data.coordinates(:,27:28),Data.fs))/2,...     %Midpoint between hips 
    FilteredCoordinates(Data.coordinates(:,29:30),Data.fs),...   %Right knee
    FilteredCoordinates(Data.coordinates(:,31:32),Data.fs),...   %Right ankle
    FilteredCoordinates(Data.coordinates(:,35:36),Data.fs),...   %Right metatarsal
    FilteredCoordinates(Data.coordinates(:,37:38),Data.fs),...   %Right hallux
    FilteredCoordinates(Data.coordinates(:,17:18),Data.fs),...   %Left knee
    FilteredCoordinates(Data.coordinates(:,19:20),Data.fs),...   %Left ankle
    FilteredCoordinates(Data.coordinates(:,23:24),Data.fs),...   %Left metatarsal
    FilteredCoordinates(Data.coordinates(:,25:26),Data.fs)];     %Left hallux 

Data.coordinates = FilteredData;
