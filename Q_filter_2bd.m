clear all
close all
%% Q figure;
Fs = 800;
Ts = 1/Fs;

bode_opt            = bodeoptions;
bode_opt.FreqUnits  = 'Hz';
bode_opt.FreqScale  = 'Linear';
bode_opt.xlim       = {[0 400]};
bode_opt.PhaseWrapping = 'On';

while 1
    alpha = input('Choose value of alpha:\n   0.865 (default, press ENTER) \n');
    if isempty(alpha)
        alpha        = 0.865;   
    end
    break;
end

omega1 = 2*pi*60*Ts;  % disturbance frequency at 60 Hz
omega2 = 2*pi*200*Ts;  % disturbance frequency at 200 Hz

num = [-2*(alpha-1)*(cos(omega1)+cos(omega2)),(2+4*cos(omega1)*cos(omega2))*(alpha^2 - 1), ...
    -2*(alpha^3-1)*(cos(omega1)+cos(omega2)),alpha^4 - 1];
den = [1,-2*alpha*(cos(omega1)+cos(omega2)),(2+4*cos(omega1)*cos(omega2))*alpha^2, ...
    -2*alpha^3*(cos(omega1)+cos(omega2)),alpha^4];

Q = tf(num,den,Ts,'variable','z^-1');
figure;
bodeplot(Q,bode_opt)
grid on,zoom on

% num = [2*cos(omega0),-1];
% den = [1];
% 
% FIR_Q = tf(num,den,Ts,'variable','z^-1');
% figure;
% bodeplot(FIR_Q,bode_opt)
% grid on,zoom on

z = tf('z',Ts);
Q1 = 1 - z^(-1)*Q;
figure;
bodeplot(Q1,bode_opt)
grid on,zoom on