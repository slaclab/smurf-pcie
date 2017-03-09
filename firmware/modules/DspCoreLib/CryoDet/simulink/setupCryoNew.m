% script   setupCryoNew
% set up parameters for CryoDetNew.slx

%new as of Feb 3, 2016

format compact
setupVers = 21; % just a number that goes into a status register

Fadc = 370e6  % ADC clock  frequency
Ts = 1/Fadc  % ADC sample rate
Fclk = Fadc/2  % data to FPGA is brought out in 2 parallel channels at half the ADC rate
Tclk = 1/Fclk


% Simulate resonator notch in simulink
Fnotch = 70e6, BW = 1e6, Q = Fnotch/BW, wNotch = 2*pi*Fnotch
a = 0.1  % transmission at minimum
notch = tf( [1 a*wNotch/Q wNotch^2], [1 wNotch/Q wNotch^2])
figure(22), bode(notch); grid, title('Simulted resonator transfer function')

% Simulate another resonator notch in simulink
Fnotch2 = 70.3e6, BW = 1e6, Q = Fnotch2/BW, wNotch = 2*pi*Fnotch2
a = 0.2  % transmission at minimum
notch2 = tf( [1 a*wNotch/Q wNotch^2], [1 wNotch/Q wNotch^2])
figure(23), bode([notch; notch2]); grid, title('Simulted resonator transfer functions')

% Simulate more resonator notches in simulink
Fnotch3 = 80.0e6, BW = 1e6, Q = Fnotch3/BW, wNotch = 2*pi*Fnotch3
a = 0.1  % transmission at minimum
notch3 = tf( [1 a*wNotch/Q wNotch^2], [1 wNotch/Q wNotch^2])

Fnotch4 = 80.2e6, BW = 1e6, Q = Fnotch4/BW, wNotch = 2*pi*Fnotch4
a = 0.1  % transmission at minimum
notch4 = tf( [1 a*wNotch/Q wNotch^2], [1 wNotch/Q wNotch^2])

freqBits = 24  % number of bits for frequency
%freqBits = 20  % number of bits for frequency (20 bits gives ~180 Hz freq resolution)
IQbits = 16  %number of bits for DDS I&Q
%IQbits = 15  % number of bits for DDS I&Q (16 bits takes up too much BRAM)
Nlines = 12   % max number of resonator lines per ADC
freqBusAddrBits = 4  %number of bits of address space for a frequency bus

%white noise generator paramters
noiseLen = 128   % length of vector of random phases for white noise generator
noiseSteps = 32  %every noiseSteps clocks (of 185 MHz) change random phase shift (try 37 later)
noise = exp(2i*pi*rand(1, noiseLen)); %complex random phases

