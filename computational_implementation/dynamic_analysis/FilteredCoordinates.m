function [filtered_coords] = FilteredCoordinates(coords,fs)

x = coords(:,1)/1000; %meters
y = coords(:,2)/1000; %meters
fc = (0.1:0.1:15);
l_fc = length(fc);

% Generating filters
for i = 1 : l_fc
    [b,a] = butter(2,fc(i)/(fs/2));
    x_filt(:,i) = filtfilt(b,a,x);
    y_filt(:,i) = filtfilt(b,a,y);

    dif_x = sum((x(:)-x_filt(:,i)).^2);
    dif_y = sum((y(:)-y_filt(:,i)).^2);

    Rx(i)=sqrt(dif_x/size(x,1)); %residual (coord x): root mean square of noise 
    Ry(i)=sqrt(dif_y/size(y,1)); %residual (coord y): root mean square of noise 
end

min_corr = 0.92;

% Linear regression: Rx vs. fc
i = l_fc;
corr_x = 1; % correlation

while i>0
    i = i - 1; 
    [corr_x,m_x,new_b_x] = regression(fc(i:l_fc),Rx(i:l_fc));
    corr_x = corr_x^2;
    if corr_x < min_corr
        break 
    else 
        b_x = new_b_x;
    end 
end

[minv,min_i_x] = min(abs(Rx-b_x));


% Linear regression: Ry vs. fc

i = l_fc;
corr_y = 1; % correlation

while i > 0
    i = i - 1;
    [corr_y,m_y,new_b_y] = regression(fc(i:l_fc),Ry(i:l_fc));
    corr_y = corr_y^2;
    if corr_y < min_corr
        break 
    else 
        b_y = new_b_y;
    end 
end

[minv,min_i_y] = min(abs(Ry-b_y));

    
% Final filtered data 
xf = x_filt(:,min_i_x);
yf = y_filt(:,min_i_y);


filtered_coords=[xf,yf];
end