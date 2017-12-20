%% RLS flux ramp estimation and demodulation

% Readout setup
Fs = 600e3;               % downsampled rate
resetRate = 1e3;          % flux ramp reset rate
frameSize = Fs/resetRate; % number of samples per frame
freqNorm  = 2.6e3/Fs;     % normalized frequency, 2.6kHz with 1kHz reset rate corresponds to 2.6 phi0 

% build observation model
freqOff = 0;                         % frequency offset Hz
freqObs = freqNorm + freqOff/Fs;     % observation matrix frequency
H = [];
modelOrder = 3;  % include 3rd order harmonics
for i = 1:modelOrder
    cs      = cos(i*2*pi*freqObs*[0:1:frameSize-1]);
    sn      = sin(i*2*pi*freqObs*[0:1:frameSize-1]);
    H       = [H, sn', cs']; % build observation matrix
end
H = [H, ones(length(cs),1)]; % add DC component

lambda = 0.33;
noise = 0.01;
poff = pi/3;
sig = sin(2*pi*freqNorm*[0:1:frameSize-1] + poff);  % ideal sin
obs = (lambda*sig')./(1+lambda*sig');               % flux ramp mod
obs_n = obs + noise*randn(size(obs));               % noisy measurement

t = 1:10000;
fif = 2*pi*1/21;
f = 0.3*cos(fif.*t)./(1+0.6*cos(fif.*t));
f0 = 1/21;
alpha = 0.1*ones(7,1);
delta = 0.005;
u = 0.999;
R     = (1/delta)*eye(7);
phase = [];

% Frame processing resets at flux ramp strobe
for i = 1:frameSize
   % observation i.e. DDS LUT
   h = H(i,:);
   % prediction
   y_hat = h*alpha;
   % error
   err = obs_n(i) - y_hat;
   % autocorrelation update
   R = (1/u)*(R - R*h'*h*R./(u + h*R*h'));
   % estimate update
   alpha = alpha + R*h'*err;
   
   % save phase estimate vs # samples
   phase(i+1) = atan2(alpha(2), alpha(1));
end

figure;
subplot(3,1,1)
plot(obs)
hold on
plot(obs_n)
title('Measurement')
xlabel('sample')
legend('Flux ramp signal','noise corrupted measurement')
xlim([0 frameSize])
subplot(3,1,2)
plot(phase*180/pi)
hold on
plot([0 frameSize],[poff*180/pi poff*180/pi],'-r')
title('Phase esitimate')
xlabel('sample')
ylabel('Phase (degree)')
legend('Phase estimate','Phase')
xlim([0 frameSize])
subplot(3,1,3)
plot((phase-poff)*180/pi)
title('Phase error')
xlabel('sample')
ylabel('Phase (degree)')
xlim([0 frameSize])
ylim([-1 1])

