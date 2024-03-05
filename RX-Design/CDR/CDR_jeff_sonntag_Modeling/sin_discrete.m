% MATLAB script to generate memory initialization file with sine values

% Define the range of angles (in radians)
%theta = linspace(0, 2*pi,360);

% Compute sine values and scale to integer range (0 to 255 for 8-bit memory)


f=5e9;
T=1/f;
np=10000;
N=1000;
t=linspace(0,np*T,N);

x1=sin(2*pi*f*t+0*pi/2); %0
x2=sin(2*pi*f*t+1*pi/4); %45
x3=sin(2*pi*f*t+1*pi/2); %90
x4=sin(2*pi*f*t+3*pi/4); %135
x5=sin(2*pi*f*t+2*pi/2); %180
x6=sin(2*pi*f*t+5*pi/4); %225
x7=sin(2*pi*f*t+3*pi/2); %270
x8=sin(2*pi*f*t+7*pi/4); %315
% Open a file for writing
scaledSinValues_0 = round(127.5 * sin(x1) + 127.5);
scaledSinValues_45 = round(127.5 * sin(x2) + 127.5);
scaledSinValues_90 = round(127.5 * sin(x3) + 127.5);
scaledSinValues_135 = round(127.5 * sin(x4) + 127.5);

scaledSinValues_180 = round(127.5 * sin(x5) + 127.5);
scaledSinValues_225 = round(127.5 * sin(x6) + 127.5);
scaledSinValues_270 = round(127.5 * sin(x7) + 127.5);
scaledSinValues_315 = round(127.5 * sin(x8) + 127.5);


fileID_0 = fopen('sine_0.hex', 'w');
fileID_90 = fopen('sine_90.hex', 'w');
fileID_180 = fopen('sine_180.hex', 'w');
fileID_270 = fopen('sine_270.hex', 'w');

fileID_45 = fopen('sine_45.hex', 'w');
fileID_135 = fopen('sine_135.hex', 'w');
fileID_225 = fopen('sine_225.hex', 'w');
fileID_315 = fopen('sine_315.hex', 'w');


% Check if the file was opened successfully\\
if fileID_0 == -1 || fileID_90 == -1 || fileID_180 == -1 || fileID_270 == -1 || fileID_45 == -1 || fileID_135 == -1 || fileID_225 == -1 || fileID_315 == -1 
    error('Error opening the file.');
end

% Write memory initialization values to the file in hexadecimal format
for i = 1:length(scaledSinValues_0)
    fprintf(fileID_0, '%02X\n', scaledSinValues_0(i));
end

for i = 1:length(scaledSinValues_90)
    fprintf(fileID_90, '%02X\n', scaledSinValues_90(i));
end

for i = 1:length(scaledSinValues_180)
    fprintf(fileID_180, '%02X\n', scaledSinValues_180(i));
end

for i = 1:length(scaledSinValues_270)
    fprintf(fileID_270, '%02X\n', scaledSinValues_270(i));
end

for i = 1:length(scaledSinValues_45)
    fprintf(fileID_45, '%02X\n', scaledSinValues_45(i));
end

for i = 1:length(scaledSinValues_135)
    fprintf(fileID_135, '%02X\n', scaledSinValues_135(i));
end

for i = 1:length(scaledSinValues_225)
    fprintf(fileID_225, '%02X\n', scaledSinValues_225(i));
end

for i = 1:length(scaledSinValues_315)
    fprintf(fileID_315, '%02X\n', scaledSinValues_315(i));
end



% Close the file
fclose(fileID_0);
fclose(fileID_90);
fclose(fileID_180);
fclose(fileID_270);

fclose(fileID_45);
fclose(fileID_135);
fclose(fileID_225);
fclose(fileID_315);

disp('Memory initialization file generated: sine_memory_init.hex');
