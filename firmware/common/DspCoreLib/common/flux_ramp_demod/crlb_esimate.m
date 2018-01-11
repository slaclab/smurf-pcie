% Look at demodulation performance vs measurement (frequency) noise

Fs = 2.4e6;              % processing rate
Fc = 30e3;               % flux ramp carrier rate
Fr = 10e3;               % flux ramp reset rate
frameSize = Fs/Fr;  
numberFrames = 10000;

i = 0:(frameSize-1);
i = i(:);


A = 0.25;
theta = pi/3;

noiseSigma = 0.1;

% generate signal for 1 frame

s = A.*cos(2*pi*i*Fc/Fs + theta);

% extend to numberFrames, add noise
y = repmat(s, numberFrames, 1);

noise = noiseSigma.*randn(size(y));
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

pause()

%% lets try with SQUID like signal non white noise
noiseSigma = 200;  % Hz RMS
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

alpha = 0.9;
noise = noiseSigma.*randn(size(y));
noise = filter(alpha, [1 -alpha], noise);
y = y + noise;

% measurement model
H = [cos(2*pi*i*Fc./Fs), sin(2*pi*i*Fc./Fs),...
    cos(2*2*pi*i*Fc./Fs), sin(2*2*pi*i*Fc./Fs),...
    cos(3*2*pi*i*Fc./Fs), sin(3*2*pi*i*Fc./Fs),...
    ones(frameSize,1)];


% frame processing
theta = zeros(numberFrames, 1);
for i = 0:numberFrames-1
    alpha = H\y( (i*frameSize+1):((i+1)*frameSize) );
    theta(i+1) = atan2(alpha(2), alpha(1));
end

snr = (A.^2)./(2*noiseSigma.^2);
rms = std(theta);

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
plot(y)
xlabel('Sample number')
ylabel('Frequency (Hz)')
legend('Noiseless response','Noise corrupted')
xlim([1 frameSize*2])

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