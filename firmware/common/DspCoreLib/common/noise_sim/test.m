close all 
clear

fAdc                   = 614.4e6;
fNotch                 = 5e6;
probeOffset            = 5e3;
nSamples               = 10e6;
bw                     = 100e3;    
SNR                    = 70;      
timeDelay              = 100e-9; 
timeDelaySamples       = floor(timeDelay*fAdc); 
timeDelayFrac          = timeDelay*fAdc - timeDelaySamples;
phaseNoiseProfile.freq = [1e2   1e3  1e4  1e5  2e5  1e6];
phaseNoiseProfile.dBc  = [-83   -95 -100 -101 -100 -130]-30;

% Notch
Qc = 20000;
Qr = 17000;
trim = 1e4;

[notch, notchComplex] = generateNotch(Qc, Qr, 5e9, fNotch, fAdc);

opts = bodeoptions;
opts.FreqUnits = 'Hz';
figure;
bode(notchComplex, opts);
title('Notch response')
grid minor;

figure;
nyquist(notchComplex);
title('Notch response');
xlim([0 1]); 
grid minor;


% Probe tone is offset from notch by probeOffset
probeTone  = exp(j*2*pi*(0:nSamples+timeDelaySamples-1)*(fNotch+probeOffset)/fAdc);

% Genearte defects WGN and phase noise
[noisyTone, noise]          = addWGN(probeTone, SNR);

[phaseNoise, rmsPhaseNoise] = generatePhaseNoise(phaseNoiseProfile.freq,...
    phaseNoiseProfile.dBc, nSamples + timeDelaySamples, fAdc);

phaseNoisePhasor            = exp(j*phaseNoise);


%  
%
% Send tone through system
txTone    = (probeTone + noise).*phaseNoisePhasor;
txTone    = txTone(1:nSamples);


% complex tone through complex notch
% notchTone   = filter(h, 1, txTone);
simout = lsim(notch, [real(txTone); imag(txTone)]);
notchTone = simout(:,1)' + 1i*simout(:,2)';


% let's convert to baseband and send through DC block instead
% notchTone   = filter(num,den, exp(-j*2*pi*(0:length(txTone)-1)*fNotch/fAdc));

notchTone_d = addFracTimingDelay(notchTone, timeDelayFrac);

% rxTone      = notchTone_d.*conj(phaseNoisePhasor(1+timeDelaySamples:end));
rxTone  = notchTone_d;

baseband    = rxTone.*conj(probeTone(1+timeDelaySamples:end));

baseband    = baseband(trim+1:end); % trim by FIR length

% baseband = txTone.*conj(probeTone(1:nSamples));

%% Plot results

figure;
subplot(3,1,1)
w = hanning(floor(length(noisyTone)/8));
pwelch(probeTone, w, 0, [], fAdc, 'centered')
title('Noiseless probe tone')
xlim([fNotch/1e6-2 fNotch/1e6+2])

subplot(3,1,2)
pwelch(noisyTone, w, 0, [], fAdc, 'centered')
title('100 SNR tone')
xlim([fNotch/1e6-2 fNotch/1e6+2])

subplot(3,1,3)
pwelch(txTone, w, 0, [], fAdc, 'centered')
title('Tx tone with phase noise')
xlim([fNotch/1e6-2 fNotch/1e6+2])

figure;
[pnPxx, pnF] = pwelch(phaseNoise, [], [], [], fAdc);
semilogx(pnF, 10*log10(pnPxx))
title('Input phase noise')
xlabel('Frequency (Hz)')
ylabel('Power density dBc/Hz')

figure;
pwelch(rxTone, w, [], [], fAdc, 'centered')
title('Rx tone with downmix phase noise')
xlim( [ (fNotch - 2e6) (fNotch + 2e6) ]./1e6 )


t = 1:length(baseband);
t = t./fAdc;
I = mean(real(baseband));
Q = mean(imag(baseband));
aa = atan2(Q,I);
% baseband = baseband*exp(-j*aa);
figure;
plot(t, real(baseband))
hold on
plot(t, imag(baseband))
title('Downmix IQ')
xlabel('Time (sec)')
legend('I','Q')


[ddcPxxR, ddcFR] = pwelch(real(baseband)-mean(real(baseband)), [], [], [], fAdc);
[ddcPxxI, ddcFI] = pwelch(imag(baseband)-mean(imag(baseband)), [], [], [], fAdc);

figure;
semilogx(ddcFR, 10*log10(ddcPxxR))
hold on
semilogx(ddcFI, 10*log10(ddcPxxI))
title('Downmix IQ PSD')
legend('I','Q')

rise = 20e3;
run = 2/0.02043;
slope = rise/run;
slope = 1;

phaseNoiseOut = angle(baseband);
phaseNoiseOut = phaseNoiseOut - mean(phaseNoiseOut);
freqError = phaseNoiseOut*slope;

figure;
plot(t, freqError)
title('Frequency error')
xlabel('Time (sec)')

figure;
[pxxF, fF] = pwelch(freqError,[],0,[],fAdc);
semilogx(fF, 10*log10(pxxF))
title('Frequency error PSD')




% pause()

%% Let's try IQ vs freq (complex plot)

nSamples = 2e4;
freqScanRange = -0.5e6:10e3:0.5e6;
l = length(freqScanRange);
I = zeros(1, l);
Q = zeros(1, l);
trim = 10000;

for i = 1:l
    probeTone  = exp(j*2*pi*(0:nSamples+timeDelaySamples-1)*(fNotch+freqScanRange(i))/fAdc);
    txTone    = (probeTone + noise(1:nSamples+timeDelaySamples)).*phaseNoisePhasor(1:nSamples+timeDelaySamples);
    txTone    = txTone(1:nSamples);

    simout = lsim(notch, [real(txTone); imag(txTone)]);
    notchTone = simout(:,1)' + 1i*simout(:,2)';

    notchTone_d = addFracTimingDelay(notchTone, timeDelayFrac);

    % rxTone      = notchTone_d.*conj(phaseNoisePhasor(1+timeDelaySamples:end));
    rxTone  = notchTone_d;

    baseband    = rxTone.*conj(probeTone(1+timeDelaySamples:nSamples+timeDelaySamples))*exp(j*pi);

%     baseband    = rxTone.*conj(probeTone(1+timeDelaySamples:nSamples+timeDelaySamples));
    
    baseband    = baseband(trim+1:end); % trim by FIR length
    
    
    I(i) = mean(real(baseband));
    Q(i) = mean(imag(baseband));
    
end

figure;
plot(I + j*Q,'.')
title('Complex response (IQ)')

% from plot -0.02043 is -10kHz
%            0.02043 is +10kHz
%
% rise  = 20e3;
% run   = 2/0.02043;
% slope = rise/run;
