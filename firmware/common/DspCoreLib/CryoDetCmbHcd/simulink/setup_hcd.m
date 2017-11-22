addpath('../../common')

Fadc = 614e6;  % MHz
axi_clk = 156.25e6;

taps_per_chan   = 16;
number_channels = 32;
number_subband  = number_channels/2; % really will generate 2 overlapping PFB
filt_len        = taps_per_chan*number_subband;
pass_band       =  1;
stop_band       = 80;


pass_band_freq  = (1/2)/(number_channels);
stop_band_freq  = (3/2)/(number_channels);

% filt = cfirpm(filt_len-1,[0,pass_band_freq,stop_band_freq,1],@lowpass,[pass_band,stop_band]);


F= (0:(taps_per_chan*number_subband-1))/(taps_per_chan*number_subband);


x = 5.856*(2*number_subband*F-0.5);
A = sqrt(0.5*erfc(x));

N = length(A);

n = 0:(N/2-1);
A(N-n)   = conj(A(2+n));
A(1+N/2) = 0;

filt = ifft(A);
filt = fftshift(filt);
filt = filt/sum(filt);


filts = reshape(filt,number_subband,taps_per_chan);

% fvtool(filt)

samples_per_channel = 4096*10;
% generate complex chrip
t=(0:samples_per_channel*number_channels-1)/(samples_per_channel*number_channels);
phi = cumsum(t);
chirp = exp(-j*2*pi*phi);

simin.signals.dimensions = 1;
simin.signals.values = chirp';
simin.time = [];

% figure
% spectrogram(chirp,256)
% title('Chirp spectogram')


% rearrange to process 2 samples/clock
synthesis_coefficients1 = [];
synthesis_coefficients2 = [];
for i = 1:number_subband/2
    synthesis_coefficients1 = [synthesis_coefficients1, filts(i*2-1,:)];
    synthesis_coefficients2 = [synthesis_coefficients2, filts(i*2,:)];
end

analysis_coefficients1 = [];
analysis_coefficients2 = [];
for i = 1:number_subband/2
    analysis_coefficients1 = [analysis_coefficients1, fliplr(filts(i*2-1,:))];
    analysis_coefficients2 = [analysis_coefficients2, fliplr(filts(i*2,:))];
end

freqRomData = zeros(1,128);
freqRomData(1) = floor((1/38.8)*2^24) + 15*2^24;

etaRomData = zeros(1,128);
etaRomData(1) = 2^10 + (2^10)*(2^16);

freqRomData1 = zeros(1,128);
freqRomData1(1) = floor((1/38.8)*2^24) + 15*2^24;




