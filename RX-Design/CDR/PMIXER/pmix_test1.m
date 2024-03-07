function pmix_test1
global x1
global x2
global x3
global x4
global N
global T
f=10e9;T=1/f;
np=100;
N=1000;
t=linspace(0,np*T,N);
x1=sin(2*pi*f*t+0*pi/2);
x2=sin(2*pi*f*t+1*pi/2);
x3=sin(2*pi*f*t+2*pi/2);
x4=sin(2*pi*f*t+3*pi/2);
% plot(t,x1,t,x2,t,x3,t,x4);

% B=linspace(0,1,100);
% ph=atan2(B,1-B)*180/pi;
% plot(B,ph,B,B*90);

% ph=360;

%  y=y./max(abs(y));
%  plot(t,x1,t,x2,t,x3,t,y,'black')
y=[];
pht=[];
for ti=t
    pht(end+1)=mod(2*pi*f*10*ti,360);
    y(end+1)=get_p(ti,pht(end));
end
% y=sign(y);
% plot(t,y)
plot(t,pht)

function y=get_p(ti,ph)
% ti=T/2;
global x1
global x2
global x3
global x4
global N
global T
index=floor(N*mod(ti,T)/T)+1;
ph_bit=1023*ph/360;
int_v=double(uint8(mod(ph_bit,256)));
ph_sel=floor(ph_bit/256);
B=double(int_v/255.0);
A=1-B;
switch ph_sel
    case 0
        y=x1(index)*A+x2(index)*B;
    case 1
        y=x2(index)*A+x3(index)*B;
    case 2
        y=x3(index)*A+x4(index)*B;
    case 3
        y=x4(index)*A+x1(index)*B;
end
y=y/((A^2+B^2)^0.5);
