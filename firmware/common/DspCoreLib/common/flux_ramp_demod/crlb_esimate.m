% Look at demodulation performance vs measurement (frequency) noise

Fs           = 2.4e6;    % processing rate
Fc           = 30e3;     % flux ramp carrier rate
Fr           = 10e3;     % flux ramp reset rate
frameSize    = Fs/Fr;  
numberFrames = 10000;
filterNoise  = 1;        % filter noise spectrum?.
a            = 0.01;     % noise filter rolloff

i = 0:(frameSize-1);
i = i(:);


A = 0.5;
theta = pi/3;

noiseSigma = 0.05;

% generate signal for 1 frame

s = A.*cos(2*pi*i*Fc/Fs + theta);

% extend to numberFrames, add noise
y = repmat(s, numberFrames, 1);


noise = noiseSigma.*randn(size(y));
if filterNoise == 1
    noise = filter(a, [-1 1-a], noise);     % filter noise
    noise = (noiseSigma./std(noise))*noise; % normalize to have same integrated power
end
y = y + noise;

% measurement model
H = [cos(2*pi*i*Fc./Fs), sin(2*pi*i*Fc./Fs)];


% frame processing
theta = zeros(numberFrames, 1);
for k = 0:numberFrames-1
    alpha = H\y( (k*frameSize+1):((k+1)*frameSize) );
    theta(k+1) = atan2(alpha(2), alpha(1));
end

snr = (A.^2)./(2*noiseSigma.^2);
rms = std(theta);

% CRLB estimate var(theta_hat) >= (2*sigma^2)/(N*A^2)
crlb_var = (2*noiseSigma.^2)/(frameSize*A.^2);
crlb_rms = sqrt(crlb_var);


disp([' ' ])
disp([' ' ])
disp(['Pure sine wave results:'])
disp(['    Measurement noise: ', num2str(noiseSigma), ' RMS'])
disp(['    amplitude: ', num2str(A)])
disp(['    SNR: ' num2str(snr), ' dB'])
disp(['    CRLB: ' num2str(crlb_rms), ' radians RMS'])
disp(['    achieved: ', num2str(rms), ' radians RMS'])
disp([' ' ])
disp([' ' ])


figure;
plot(s)
hold on
plot(y(1:length(s),:))
xlabel('Sample number')
ylabel('Frequency (Hz)')
legend('Noiseless response','Noise corrupted')
title('Pure sinewave demodulation')

figure;
[pxx, f] = pwelch(noise, [], [], [], 2.4e6);
semilogx(f,10*log10(pxx))
ylabel('Power/frequency (Hz/Hz)')
title('Measurement noise spectrum')
xlabel('Frequency (Hz)')

figure
[pxx, f] = pwelch(theta-mean(theta), [], [], [], 2.4e6);
semilogx(f,10*log10(pxx))
ylabel('Power/frequency (rad/Hz)')
title('Demodulated noise spectrum')
xlabel('Frequency (Hz)')

pause()

%% lets try with SQUID like signal non white noise
noiseSigma = 2000;  % Hz RMS
modDepth = 150e3; % Hz
lambda    = 0.3;



A = modDepth;
theta = pi/3;



% generate signal for 1 frame

s = lambda.*cos(2*pi*i*Fc/Fs + theta);
s = s./(1+s);
s = s*modDepth./0.65;



% extend to numberFrames, add noise
y = repmat(s, numberFrames, 1);

noise = noiseSigma.*randn(size(y));
if filterNoise == 1
    noise = filter(a, [-1 1-a], noise);      % filter noise
    noise = (noiseSigma./std(noise))*noise;  % normalize to have same integrated power
end
y = y + noise;

% measurement model
H = [cos(2*pi*i*Fc./Fs), sin(2*pi*i*Fc./Fs),...
    cos(2*2*pi*i*Fc./Fs), sin(2*2*pi*i*Fc./Fs),...
    cos(3*2*pi*i*Fc./Fs), sin(3*2*pi*i*Fc./Fs),...
    ones(frameSize,1)];




% frame processing
theta1 = zeros(numberFrames, 1);
theta2 = zeros(numberFrames, 1);
theta3 = zeros(numberFrames, 1);

amp1 = zeros(numberFrames, 1);
amp2 = zeros(numberFrames, 1);
amp3 = zeros(numberFrames, 1);

for k = 0:numberFrames-1
    alpha = H\y( (k*frameSize+1):((k+1)*frameSize) );
    theta1(k+1) = atan2(alpha(2),     alpha(1));
    amp1(k+1)   = sqrt( alpha(2).^2 + alpha(1).^2);
    theta2(k+1) = atan2(alpha(4),     alpha(3));
    amp2(k+1)   = sqrt( alpha(4).^2 + alpha(3).^2);
    theta3(k+1) = atan2(alpha(6),     alpha(5));
    amp3(k+1)   = sqrt( alpha(6).^2 + alpha(5).^2);
end

% We need to look at amplitude of 1st harmonic for CRLB
A = mean(amp1);
snr = (A.^2)./(2*noiseSigma.^2);

rms = std(theta1);

% Note this is bound on variance of phase estimate for 1st harmonic
%   not necessarily bound on variance of demodulated SQUID response

% CRLB estimate var(theta_hat) >= (2*sigma^2)/(N*A^2)
crlb_var = (2*noiseSigma.^2)/(frameSize*A.^2);
crlb_rms = sqrt(crlb_var);


disp(['Flux ramp demod results:'])
disp(['    Measurement noise: ', num2str(noiseSigma), ' Hz RMS'])
disp(['    amplitude: ', num2str(A), ' Hz'])
disp(['    SNR: ' num2str(snr), ' dB'])
disp(['    CRLB: ' num2str(crlb_rms), ' radians RMS'])
disp(['    achieved: ', num2str(rms), ' radians RMS'])
disp([' ' ])
disp([' ' ])

figure;
plot(s)
hold on
plot(y(1:length(s),:))
xlabel('Sample number')
ylabel('Frequency (Hz)')
legend('Noiseless response','Noise corrupted')


figure;
[pxx, f] = pwelch(noise, [], [], [], 2.4e6);
semilogx(f,10*log10(pxx))
ylabel('Power/frequency (Hz/Hz)')
title('Measurement noise spectrum')
xlabel('Frequency (Hz)')

figure
[pxx, f] = pwelch(theta1-mean(theta1), [], [], [], 2.4e6);
semilogx(f,10*log10(pxx))
ylabel('Power/frequency (rad/Hz)')
title('Demodulated noise spectrum')
xlabel('Frequency (Hz)')