function ComputeAverageLengths(Data) 
% This function computes the average lengths of the human body segments

% Global memory data
global NBody Body

% Number of frames to evaluate
NFrames = Data.nframes;

for i = 1:NBody
    
  % Allocates memory for the lengths
  SegmentLength = zeros (NFrames,1);
  
  % Goes through all frames 
  for j = 1:NFrames
      
      % Position of the coordinates of points Pi and Pj (in data matrix)
      Pi = 2*(Body(i).pi - 1) + 1;
      Pj = 2*(Body(i).pj - 1) + 1;
      
      % Computes the length of current frame (j) of current body (i)
      SegmentLength(j) = norm(Data.coordinates(j, Pi : Pi+1) - ...
          Data.coordinates(j, Pj : Pj+1));
      
      % End of loop that goes through all frames
  end 
  
  % Define the average length
  Body(i).Length = mean(SegmentLength);
  
  %End of the loop that goes through all bodies
end 

end