function y = ampScale(T, fs, type)
scale = 1 / type;
time = 0:(1 / fs):T;

% Create an empty vector
y = zeros(1, length(time));

for i = 1:length(time)
    if (i <= 0.15 * length(time))
        y(i) = 6 * time(i) * scale;
    
    elseif (i <= 0.3 * length(time))
        y(i) = -4 * time(i) * scale + 0.75;
        
    elseif (i <= 0.8 * length(time))
        y(i) = 0.15;
        
    elseif (i <= length(time))
        y(i) = -1.5 * time(i) * scale + 0.75;
        
    else
        y(i) = 0;
    end
end

    
