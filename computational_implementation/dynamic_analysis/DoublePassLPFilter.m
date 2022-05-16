function FilteredData = DoublePassLPFilter(RawData, cutoff_freq, fs)

Wn = cutoff_freq/(fs/2);
[b,a] = butter(2,Wn,'low');
FilteredData = filtfilt(b,a,RawData);

end