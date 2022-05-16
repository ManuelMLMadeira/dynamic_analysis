function [xf] = ResidualAnalysis(x,fs)

fc = (0.1:0.1:20);
l_fc = length(fc);


% Generating filters
for i = 1 : l_fc
    [b,a] = butter(2,fc(i)/(fs/2));
    x_filt(:,i) = filtfilt(b,a,x);
    
    dif_x = sum((x(:)-x_filt(:,i)).^2);

    Rx(i)=sqrt(dif_x/size(x,1)); %residual (coord x): root mean square of noise 
end

min_corr = 0.95;

% Linear regression: Rx vs. fc
i = l_fc;
corr_x = 1; % correlation

while i>1
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

    
% Final filtered data 
xf = x_filt(:,min_i_x);


end