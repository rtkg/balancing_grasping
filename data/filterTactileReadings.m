function ts=filterTactileReadings(ts_raw)

window_size = 10; 
b = (1/window_size)*ones(1,window_size);
a = 1;

ts=zeros(size(ts_raw));
for i=1:size(ts_raw,2)
    ts(:,i)=filter(b,a,ts_raw(:,i));
end

