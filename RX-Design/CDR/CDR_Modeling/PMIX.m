function PMIX
global P0;
global P90;
global P180;
global P270;
global N;
global T;
global f;

f = 10e9;
T = 1/f;
N = 1000;
t = linspace(0,N*T,1000);
P0   = sin(2*pi*f*t);
P90  = sin(2*pi*f*t-pi/2);
P180 = sin(2*pi*f*t-pi);
P270 = sin(2*pi*f*t-((3*pi)/2));
%---------------- NON LINEARITY ------------------
%code = linspace(0,1,1000);
%ph = atan2(code,1-code)*180/pi;
%figure(1);
%plot(code,ph,code,90*code);
%-------------------------------------------------
%code = 1;
%sum = code.*P270 + (1-code).*P0;
%sum = sum./max(abs(sum));
%figure(2);
%plot(t,P0,t,P90,t,P180,t,P270,t,sum,"black");
%---------------- PHASE INTERPOLATON WITH SELECTION ---------------------------------
% code_binary='00 1111 1111'
% code = bin2dec(code_binary);
% binary_mask1 = bin2dec('1100000000');
% extract_bits = bitand(code, binary_mask1);
% phase_sel_bin = dec2bin(bitshift(extract_bits, -8), 2); % Shift extracted bits to the right by 8 positions
% phase_sel = bin2dec(phase_sel_bin);
% int_val = double(uint8(mod(code,256))); %git the value of the 8bits
% int_value = double(int_val/255.0); %make the value normalized (maximum 1)
% 
% switch phase_sel 
%     case 0 
%         sum = int_value.*P90  + (1-int_value).*P0;
%     case 1
%         sum = int_value.*P180 + (1-int_value).*P90;
%     case 2
%         sum = int_value.*P270 + (1-int_value).*P90;
%     case 3
%         sum = int_value.*P0   + (1-int_value).*P270;
% end
% 
% %sum = sum./max(abs(sum)) %to make the amp always one
% sum = sum/(int_value^2 + (1-int_value)^2)^0.5; %to normalize it another way (preferred)
% 
% plot(t,P0,t,P90,t,P180,t,P270,t,sum,"black");
%-------------------PHASE INTERPOLATION FUNCTION--------------------------------
%plot(t,P0,t,P90,t,P180,t,P270);
sum = [];
code=[];
for ti = t
  code(end+1) = mod(10*f*ti,1024);
  sum(end+1) = interpolate(ti,code(end));
end
%plot(t,code);
plot(t,sum);
%plot(t,P0,t,P90,t,P180,t,P270,t,sum,"black");


function sum = interpolate(ti,code)
    
index = floor(N*mod(ti,T)/T)+1; %get the index for the signals
binary_mask1 = bin2dec('1100000000');
extract_bits = bitand(uint16(code), binary_mask1); % Cast code to uint16 before bitwise operation
phase_sel_bin = dec2bin(bitshift(extract_bits, -8), 2); % Shift extracted bits to the right by 8 positions
phase_sel = (bin2dec(phase_sel_bin));
int_val = double(uint8(mod(code,256))); %git the value of the 8bits
int_value = double(int_val/255.0); %make the value normalized (maximum 1)

switch phase_sel 
    case 0 
        sum = int_value*P90(index)  + (1-int_value)*P0(index);
    case 1
        sum = int_value*P180(index) + (1-int_value)*P90(index);
    case 2
        sum = int_value*P270(index) + (1-int_value)*P180(index);
    case 3
        sum = int_value*P0(index)   + (1-int_value)*P270(index);
end
%sum = sum./max(abs(sum)) %to make the amp always one
sum = sum/(int_value^2 + (1-int_value)^2)^0.5; %to normalize it another way (preferred)
end
%plot(t,P0,t,P90,t,P180,t,P270,t,sum,"black");

end




