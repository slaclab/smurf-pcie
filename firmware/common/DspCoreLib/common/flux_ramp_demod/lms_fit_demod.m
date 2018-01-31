%% NLMS flux ramp estimation and demodulation

% Readout setup
Fs = 2.4e6;               % downsampled rate
resetRate = 1e4;          % flux ramp reset rate
frameSize = Fs/resetRate; % number of samples per frame
freqNorm  = 2.9e4/Fs;     % normalized frequency, 2.6kHz with 1kHz reset rate corresponds to 2.6 phi0 
numberFrames = 1000;

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

obs_n = [];
obs_ = [];
poff_inc = 0.01;
poff = pi/3;
for i = 1:numberFrames
    lambda = 0.33;
    noise = 0.01;
    poff = sin(2*pi*1/1000*i);
%     if(i < numberFrames/2)
%         poff = pi/3;
%     else
%         poff = pi/6;
%     end
    sig = sin(2*pi*freqNorm*[0:1:frameSize-1] + poff);  % ideal sin
    
    obs = (lambda*sig')./(1+lambda*sig');               % flux ramp mod
    obs = obs;
    obs_ = [obs_; obs];
    obs_n =[obs_n; (obs + noise*randn(size(obs)))];               % noisy measurement
    ph(i) = poff;
end
obs_  = (obs_+0.1)./38.4;
obs_n = (obs_n+0.1)./38.4;


alpha = 0.1*ones(2*modelOrder+1,1);
y_hat = zeros(frameSize*numberFrames,1);


phase1 = zeros(frameSize*numberFrames,1);
phase2 = zeros(frameSize*numberFrames,1);
phase3 = zeros(frameSize*numberFrames,1);

% Frame processing resets at flux ramp strobe
u = 1/32; % feedback gain (constant for all variables?)

for i = 1:frameSize*numberFrames-1
   % observation i.e. DDS LUT
   h = H(mod(i+frameSize-1,frameSize)+1,:);
   % prediction
   y_hat(i) = h*alpha;
   % error
   err = obs_n(i) - y_hat(i);

   % feedback (normalized)
   alpha = alpha + u*err*h'./(sum(h.^2));

   
   
   % save phase estimate vs # samples
   % we could combine weighted by magnitdue
   phase1(i) = atan2(alpha(2), alpha(1));
   phase2(i) = atan2(alpha(4), alpha(3));
   phase3(i) = atan2(alpha(6), alpha(5));
   
end



figure;
subplot(2,1,1)
plot(obs_)
hold on
plot(obs_n)
plot(y_hat)
title('Measurement')
xlabel('sample')
legend('Flux ramp signal','noise corrupted measurement','estimated signal')
subplot(2,1,2)
plot(phase1*180/pi)
hold on
plot([0:numberFrames-1]*frameSize,ph*180/pi,'-r')
title('Phase esitimate')
xlabel('sample')
ylabel('Phase (degree)')
legend('Phase estimate','Phase')

figure
subplot(2,1,1)
plot(obs_)
hold on
plot(y_hat)
xlabel('sample')
legend('Flux ramp signal (noiseless)', 'Estiamted signal')
subplot(2,1,2)
plot(obs_-y_hat)
xlabel('sample')
legend('error')


figure;
subplot(3,1,1)
plot(unwrap(phase1))
subplot(3,1,2)
plot(unwrap(phase2))
subplot(3,1,3)
plot(unwrap(phase3))

