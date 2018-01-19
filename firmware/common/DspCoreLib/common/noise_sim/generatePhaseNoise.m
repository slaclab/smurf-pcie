%  [phaseNoise, rmsPhaseNoise, freqOut, PxxOut, h] = generatePhaseNoise(freq, dBc, nSamples, Fs)
%  
%  generates nSample samples of phase noise at frequency Fs.  Phase noise 
%      is specified by freq and dBc.
%
%
%  Example usage:
%
%  phaseNoiseProfile.freq = [1e2   1e3  1e4  1e5  2e5  1e6];
%  phaseNoiseProfile.dBc  = [-83   -95 -100 -101 -100 -130];
%  Fs                     = 10e6;
%  nSamples               = 1e6;
%
%  phaseNoise = generatePhaseNoise(phaseNoiseProfile.freq,...
%      phaseNoiseProfile.dBc, nSamples, Fs);
%  
%  [Pxx, f] = pwelch(phaseNoise, [], 0, [], Fs);
%  figure;        
%  semilogx(f, 10*log10(Pxx))
%  hold on
%  semilogx(phaseNoiseProfile.freq, phaseNoiseProfile.dBc, 'r-')
%  title('Phase noise')
%  xlabel('Frequency (Hz)')
%  ylabel('Power dBc/Hz')
%  legend('Generated noise', 'Specified noise') 


 

function [phaseNoise, rmsPhaseNoise, freqOut, PxxOut, h] = generatePhaseNoise(freq, dBc, nSamples, Fs)

    % generate phase noise from freqStart to freqEnd
    freqStart = 0;
    freqStep  = 1e3;
    freqEnd   = 2e6;

    % produce samples at noiseFs = 2*freqEnd (Nyquist)
    noiseFs     = 2*freqEnd;
    sampleRatio = Fs/noiseFs;
    
    filtLength = 2000;
    
    % number of low rate samples to generate
    nGenSamples   = ceil(nSamples/sampleRatio) + filtLength;
    wNoise        = randn(1, nGenSamples);
    
    
    freqVec = [freqStart+1e-2     freq  freqEnd];
    dBcVec  = [dBc(1)                dBc     -200];

    freqVec_dB = 20*log10( freqVec );  % dB relative 1Hz
    

    % linear interpolate in loglog
    coarseFreqVec_dB  = ...
        floor( 20*log10(freqStart+1e-2) ):floor( 20*log10(freqEnd) );
    coarsePowerVec_dB = ...
        interp1(freqVec_dB, dBcVec, coarseFreqVec_dB, 'linear');


    % resample in linear scale - easier for int egration
    fineFreqVec     = ...
        freqStart:freqStep:freqEnd;
    finePowerVec_dB = ...
        interp1(10.^(coarseFreqVec_dB./20), coarsePowerVec_dB, ...
                fineFreqVec, 'linear', 'extrap');
    finePowerVec    = ...
        10.^(finePowerVec_dB./10);
    



    % noise power, use to normalizes noise after filtering
    ssbPower      = freqStep*cumtrapz(finePowerVec);
    rmsPhaseNoise = sqrt(2*ssbPower(end));
    
    fineFreqVec  = 10.^(coarseFreqVec_dB./20);
    finePowerVec = 10.^(coarsePowerVec_dB./10);
    
    freqPos  = (0:filtLength/2-1)*noiseFs/filtLength;
    freqNeg  = (-filtLength/2:-1)*noiseFs/filtLength;
    powerPos = interp1(fineFreqVec, finePowerVec, ...
                      freqPos, 'linear','extrap');
    powerNeg = interp1(fineFreqVec, finePowerVec, ...
                      abs(freqNeg), 'linear','extrap');
    
    power = [powerPos powerNeg];
    mag   = sqrt(power);
    
    
    h = fftshift(ifft(mag));
    window = kaiser(filtLength+2);
    h = h.*window(2:end-1)';
    
%     d = fdesign.arbmag('N,F,A',filtLength,[0 fineFreqVec(2:end)]./fineFreqVec(end),sqrt(finePowerVec));
%     Hd = design(d,'freqsamp', 'window' ,{@kaiser,20},'SystemObject',true);
%     h = Hd.Numerator;

    wFilt         = filter(h, 1, wNoise);
    wFilt         = wFilt(1, ceil(filtLength/2):end);
    genTime       = ( 1:length(wFilt) )*sampleRatio;
    
    outputTime    = 1:nSamples;
    
    phaseNoise    = interp1(genTime, wFilt, outputTime, 'spline');
    phaseNoise    = phaseNoise(1,1:nSamples);
    phaseNoise    = phaseNoise*( rmsPhaseNoise/std(phaseNoise) );
    
    freqOut = fineFreqVec;
    PxxOut  = finePowerVec;
    
    if nargout < 1
        [Pxx, f] = pwelch(phaseNoise, [], 0, [], Fs);
        figure;        
        semilogx(f, 10*log10(Pxx))
        hold on
        semilogx(freq, dBc, 'r-')
        title('Phase noise')
        xlabel('Frequency (Hz)')
        ylabel('Power dBc/Hz')
        legend('Generated noise', 'Specified noise')
        xlim([freq(1), freqEnd])
    end


end
