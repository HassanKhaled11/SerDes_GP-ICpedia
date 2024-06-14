function readDataEye(num )
fileID=fopen('channel_bits.txt','r');
formatSpec='%f';
data=fscanf(fileID,formatSpec);
fclose(fileID);

eyediagram(data,num);
end