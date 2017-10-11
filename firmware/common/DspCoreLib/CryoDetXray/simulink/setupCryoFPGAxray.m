%Fs--------------------------------------------------------------------
%
%script   setupCryoNew
% set up parameters for CryoDet<xyz>.slx
% Original 2-3-2016 / SSmith
% Copied & Modlfied for new AMC HW Alg / JED May 2017
%
% Update History:

%   <07-31-2017 JED>: added simulink_period var
%   <09-22-2017 SRS>: change notch BW to 4 MHz, Nlines = 16
%  <10-07-2017 SRS>;   remove notch filter transfer functions, parameterize
%  these in a simulink block instead
%
%--------------------------------------------------------------------

format compact
setupVers = 21; % just a number that goes into a status register

Fadc = 307.2e6  % ADC clock  frequency / NEW AMC System
Ts = 1/Fadc  % ADC sample rate

Fclk = Fadc  % same rate for new HW (non-Demo HW)
Tclk = 1/Fclk
%add rate divider for AXI bus
Naxi = 8;

%--added simulink_period var in order to make clock probe work / JED 07-31-2017
simulink_period = Ts;

%--pass-thru signal (sin/cos) generator freq parametee / added JED 08-08-2017
Fgen = 20e6;

% Simulate resonator notches in simulink
BW = 4e6  % Notch bandwidth in Hz

freqBits = 24  % number of bits for frequency (24 bits ==> 18 Hz LSB freq resolution)
IQbits = 16  %number of bits for DDS I&Q
%IQbits = 15  % number of bits for DDS I&Q (16 bits takes up too much BRAM)
Nlines = 16   % max number of resonator lines per ADC
freqBusAddrBits = 4  %number of bits of address space for a frequency bus

%white noise generator paramters
noiseLen = 128   % length of vector of random phases for white noise generator
noiseSteps = 32  %every noiseSteps clocks (of 185 MHz) change random phase shift (try 37 later)
noise = exp(2i*pi*rand(1, noiseLen)); %complex random phases