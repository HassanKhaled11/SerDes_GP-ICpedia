function eye_diagram()
fileID=fopen('channel_bits.txt','r');
formatSpec='%f';
data=fscanf(fileID,formatSpec);
fclose(fileID);

N=10
clk= 100;
sampleClk=10;
time= linspace(0,clk/sampleClk,10);
figure;
%plot the eye diagram
    for num_data = 1:floor(length(data)/clk)
        for one_bit_val = 1:floor(clk/sampleClk)
            startIndex = (num_data - 1) * clk + 1 + (one_bit_val - 1) * sampleClk;
            endIndex = startIndex + sampleClk - 1;
            plot(time, data(startIndex:endIndex));
            hold on;
        end
    end
    hold off;
end


% function eye_diagram()
% %   Open file, read data, and close file
%   fileID = fopen('channel_bits.txt', 'r');
%   data = fscanf(fileID, '%f');  % Assuming data is binary (integers)
%   fprintf('%g',data)
%   fclose(fileID);
%   % Set parameters (adjust units as needed)
%   clk = 100; % Clock period (e.g., samples)
%   sampleClk = 10; % Sampling clock period (e.g., samples)
%   numSamplesPerBit = clk / sampleClk;  % Samples per bit period
% 
%   % Generate time vector
%   timePerBit = clk / sampleClk;
%   time = linspace(0, timePerBit, numSamplesPerBit);
% 
%   % Figure and Eye Diagram
%   figure;
%   hold on;
% 
%   % Extract and plot data for multiple bit periods
%   numBitsToPlot = 10;  % Number of bit periods to overlay (adjust as needed)
%   for bitIdx = 1:numBitsToPlot
%     startIndex = (bitIdx - 1) * clk + 1;
%     endIndex = startIndex + clk - 1;
%     plot(time, data(startIndex:endIndex));
%   end
% 
%   hold off;
%   xlabel('Time');
%   ylabel('Data Value (Binary)');
%   title('Eye Diagram');
% end
% 
