% script   setupCryoDet
% set up parameters for CryoDet.slx
format compact

Fadc = 370e6  % ADC clock  frequency
Ts = 1/Fadc  % ADC sample rate
Fclk = Fadc/2  % data to FPGA is brought out in 2 parallel cahnnels at half the ADC rate
Tclk = 1/Fclk

% Cryo Mux transfer function simulatation parameters

FIR1length = 30
FIR1BW = 0.25

%single channel downconverter FIR
FIR2len = 256
FIR2BW = 0.5e6;
FIR2 = fir1(FIR2len, FIR2BW/Fclk*8);  %factor of 8 since data rate at this point is Fclk/8
figure(20),plot(FIR2),grid
y =FIR2; y(370) = 0;
figure(21), semilogy(abs(fft(y))),grid

%white noise generator paramters
noiseLen = 128
noiseBW = 2e6
noiseSteps = 32
noise = ifft(exp(2i*pi*rand(1, noiseLen)) .* fft(fir1(noiseLen-1, noiseBW/Fclk*noiseSteps)));


