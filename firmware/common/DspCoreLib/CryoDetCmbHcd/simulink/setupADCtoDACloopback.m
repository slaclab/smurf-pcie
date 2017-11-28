%setupADCtoDACloopback

% script to define variables used by ADCtoDACloopback.slx
% SS 17Nov2015
format compact
 Fs = 307.2e6;  
 Ts = 1/Fs; 
 Fgen = 20e6
 
Fadc = 307.2e6  % ADC clock  frequency
Ts = 1/Fadc  % ADC sample rate
Fclk = Fadc/2  % data to FPGA is brought out in 2 parallel channels at half the ADC rate
Tclk = 1/Fclk