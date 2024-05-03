% function up_dn()
% fileID=fopen('Up_Dn.hex','r');
% % formatSpec='%f,%';
% % data=csvread(fileID,formatSpec);
% data=csvread(fileID,formatSpec);
% cumData= zeroes(length);
% fclose(fileID);
% len =length(data);
% cumData= zeroes(length,2);
% 
% cumData[1] = data[1][1]-data [1][2]
% for i = 2:len
%     cumData[i]=data[i][1]-data [i][2]+cumData[i-1];
% end

function up_dn()
    % Open the file for reading
    fileID = fopen('Up_Dn.hex', 'r');
    
    % Assuming the file is a comma-separated value file with two columns of numbers
    formatSpec = '%f %f';  % Define the format (e.g., two floating point numbers)
    
    % Read the data from the file using textscan instead of csvread for more control
    data = textscan(fileID, formatSpec, 'Delimiter', ',')
    fclose(fileID);  % Close the file after reading
    
    % Convert cell array data to a matrix
    data = [data{1}, data{2}];
    
    % Initialize the cumulative data array
    len = size(data, 1);
    cumData = zeros(len, 1);
    
    % Calculate the first element
    cumData(1) = data(1,1) - data(1,2);
    
    % Compute the cumulative sum of up-down values
    for i = 2:len
        cumData(i) = data(i,1) - data(i,2) + cumData(i-1);
    end
        % Create a vector of indices for the x-axis
    indices = 1:len;
% Plotting the cumulated value vs. the index
    figure; % Opens a new figure window
    plot(indices, cumData, 'LineWidth', 2);
    title('Cumulative Value vs. Number of Bits Taken');
    xlabel('Number of Bits Taken');
    ylabel('Cumulative Value (early,late)');
    grid on; % Add grid lines to the plot for better visibilitend
end