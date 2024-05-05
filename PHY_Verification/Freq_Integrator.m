% Clear workspace and command window
clc;
clear;

% Define filename (replace 'Freq_Integrator.hex' with your actual filename)
filename = 'Freq_Integrator.hex';

% Read the data as strings
fid = fopen(filename);
data_str = textscan(fid, '%s');
fclose(fid);

% Convert strings to hexadecimal numbers (assuming 4 digits per value)
data = hex2dec(data_str{1});

% Plot the data (assuming values represent y-axis)
plot(data);

% Add labels and title (modify as needed)
xlabel('#symbol');
ylabel('Frequency');
title('Freq Integrator Saturation');

% Show the plot
grid on;

