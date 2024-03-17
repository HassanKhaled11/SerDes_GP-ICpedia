function sd=Channel(Ts)   %TS 25G - c 0.02PF
num =[1];
den =[1/(2*pi*2.5e9/3) 1];
sys=tf(num,den)
sd=c2d(sys,Ts)

bode(sd)
grid on
end