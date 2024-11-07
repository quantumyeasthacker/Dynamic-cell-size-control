% Author: Josiah Kratz

% Output: Plot of average birth volume as a function of nutrient-imposed
% growth rate, exports corresponding csv file

close all
clear all

%%

% read in filenames
dd = dir('*.mat');


% calculate average birth volume and growth rate for each nutrient
% condition
vol = zeros(numel(dd),1);
alpha = zeros(numel(dd),1);

for i=1:numel(dd)
    
    filename = dd(i).name;
    data = load(filename);
    data_cell = struct2cell(data); % converting data type to cell
    
    birth_length = data_cell{1}.newborn_length;
    elong_rate = data_cell{1}.elongation_rate;
    alpha(i) = log(2) * mean(elong_rate)*60; % converting to 1/h
    
    width = data_cell{1}.ave_width;
    volume = (birth_length-width) * pi .* (width/2).^2 + (4/3) * pi * (width/2).^3;
    vol(i) = mean(volume,'omitnan');
end

scatter(alpha, vol)
xlabel('Growth rate (h^{-1})')
ylabel('Birth volume (\mum^3)')

%% Export data for own analysis in python

data = [alpha, vol];
writematrix(data, 'taheri.csv')