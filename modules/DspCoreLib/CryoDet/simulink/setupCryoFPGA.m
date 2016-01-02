% script   setupCryoDet
% set up parameters for CryoDet.slx
format compact
setupVers = 5; % just a number that goes into a status register

Fadc = 370e6  % ADC clock  frequency
Ts = 1/Fadc  % ADC sample rate
Fclk = Fadc/2  % data to FPGA is brought out in 2 parallel channels at half the ADC rate
Tclk = 1/Fclk

% Cryo Mux transfer function simulatation parameters

%FIR1length = 30
%FIR1BW = 0.25

%single channel downconverter FIR
%FIR2len = 320
%FIR2BW = 0.25e6;
%FIR2 = fir1(FIR2len, FIR2BW/2/Fclk*8);  %factor of 8 since data rate at this point is Fclk/8

%simple filter ~700kHz BW (should optimize later for given bandwidth and
%sideband separation
% Notches (suitable for sidband suppression) at:
%  185/64   = 2.89 MHz
%  185/32/3 = 1.93 MHz
%  185/64/2 = 1.445 MHz
%  185/64/3 = 0.964 MHz
%FIR2 = conv([1 2 3 4 5 6 7 8 7 6 5 4 3 2 1]/64, conv(ones(1,16)/16, ones(1,24)/24)); %notches @ 2.89 MHz, 1.445 MHz, 0.964 MHz
FIR2 = conv([1 2 3 4 5 6 7 8 7 6 5 4 3 2 1]/64, ones(1,16)/16); %notches @ 2.89 MHz & 1.445 MHz
figure(20),plot(FIR2),grid
y =FIR2; Nx=4; y(185*Nx) = 0; Nfir = length(y); nfir=1:Nfir; ffir = (nfir-1)/8/Nx;
figure(21), plot(ffir, 20*log10(abs(fft(y)))),grid

%white noise generator paramters
noiseLen = 128
noiseBW = 2e6
noiseSteps = 32
%noise = ifft(exp(2i*pi*rand(1, noiseLen)) .* fft(fir1(noiseLen-1, noiseBW/Fclk*noiseSteps)));
%rmsnoise = sqrt(mean(abs(noise.*noise)));
%noise = noise/1.4/rmsnoise;
%for n=1:noiseLen
%    if abs(noise(n)) > 1
%        noise(n) = noise(n)/abs(noise(n)); %Clip noise peaks
%    end
%end
dt = noiseSteps/Fclk; % time increment for noise phase modulation

for n=1:noiseLen
    if n <= (noiseLen/2)
        f(n) = noiseBW*(4*n/noiseLen - 1); %rising chirp
    else
        f(n) = f(noiseLen + 1 - n); % descending chirp
    end
    if n==1
        phi(n) = 2*pi*f(1)*dt;
    else
        phi(n) = phi(n-1) + 2*pi*f(n)*dt; %integrate freq to get phase
    end
end
noise = exp(1i*phi);

% Simulate resonator notch in simulink
Fnotch = 70e6, BW = 1e6, Q = Fnotch/BW, wNotch = 2*pi*Fnotch
a = 0.05  % transmission at minimum
notch = tf( [1 a*wNotch/Q wNotch^2], [1 wNotch/Q wNotch^2])
figure(22), bode(notch); grid, title('Simulted resonator transfer function')


