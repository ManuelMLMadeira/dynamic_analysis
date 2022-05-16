function WritesModelInput(model)
%Adapted for Dynamic 

global NBody NRevolute NGround NDriver NFplates Body JntRevolute JntDriver Data file FPlate

% Open file
fid = fopen(model,'w');

%Store the general dimensions of the system
fprintf(fid,'%d %d %d %d %d\r\n', NBody, NRevolute, NGround, NDriver,NFplates);


for i = 1:NBody
    fprintf(fid,'%d %f %f %f %f %f 0.0 0.0 0.0 %f %f\r\n', i, ...
    Body(i).mass, Body(i).inertia,...
    Body(i).r(1,1),Body(i).r(1,2),Body(i).theta(1),...
    Body(i).PCoM, Body(i).Length);

end

%Store the data for the revolute joints
for k = 1:NRevolute
    
    % Bodies i and j
    i=JntRevolute(k).i;
    j=JntRevolute(k).j;
    
    fprintf(fid,'%d %d %d %f %f %f %f\r\n',k, i, j,...
        JntRevolute(k).spi(1)*Body(i).Length,JntRevolute(k).spi(2)*Body(i).Length,...
        JntRevolute(k).spj(1)*Body(j).Length,JntRevolute(k).spj(2)*Body(j).Length);
end

%Store the data for the drivers
for k=1:NDriver
     
    fprintf(fid,'%d %d %d %d %d %d %d\r\n',k, JntDriver(k).type, JntDriver(k).i,...
        JntDriver(k).coordi,JntDriver(k).j,JntDriver(k).coordj,JntDriver(k).filename);
    % Writes the data to the files
    
    dlmwrite(strcat(file,num2str(JntDriver(k).filename),'.txt'),JntDriver(k).Data,'delimiter',' ','newline','pc');
end


%Stores the data regarding the force plates
for k=1:NFplates
    
    % Bodies i and j
    i=FPlate(k).i;
    j=FPlate(k).j;
    
    fprintf(fid,'%d %d %d %f %f %f %f %d\r\n', k, i, j,...
        FPlate(k).spi(1)*Body(i).Length,FPlate(k).spi(2)*Body(i).Length,...
        FPlate(k).spj(1)*Body(j).Length,FPlate(k).spj(2)*Body(j).Length,...
        FPlate(k).filename);
    
    % Writes the data to the files
    dlmwrite([file,'FPlates_',num2str(FPlate(k).filename),'.txt'],...
        FPlate(k).Data,'delimiter',' ','precision',20,'newline','pc');
end



fprintf(fid,'%f %f %f', 0.0,Data.tstep,Data.tend);

end


