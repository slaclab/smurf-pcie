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


 

function [phaseNoise, rmsPhaseNoise, freqOut, PxxOut, h] = generatePhaseNoise(freq, dBc, nSamples, Fs, varargin)

    numvarargs            = length(varargin);
    optargs               = {freq(end) + 1, 2000};     % optionally pass freqEnd, filter length
    optargs(1:numvarargs) = varargin;

    % generate phase noise from freqStart to freqEnd
    freqStart                 = 1e-2;
    [freqEnd, filtLength]     = optargs{:};

    % produce samples at noiseFs = 2*freqEnd (Nyquist)
    noiseFs     = 2*freqEnd;
    sampleRatio = Fs/noiseFs;
    
    % number of low rate samples to generate
    nGenSamples   = ceil(nSamples/sampleRatio) + filtLength;
    wNoise        = randn(1, nGenSamples);
    
    % calculate noise power, use to normalizes noise after filtering
    ssbPower = 0;
    % integrate power in log log
    for i = 1:length(dBc)-1
        p        = 0.5*(dBc(i+1) + dBc(i)) + 10*log10(freq(i+1) - freq(i));
        ssbPower = ssbPower + 10.^(p./10)
    end
    rmsPhaseNoise = sqrt(2*ssbPower)
    
    linearFreqVec = [freqStart            freq  freqEnd];
    logPowerVec   = [dBc(1)                dBc     -200];
    logFreqVec    = 20*log10( linearFreqVec );
    
    % linear interpolate in loglog
    logFreqVecInterp  = ...
        floor( 20*log10(freqStart) ):floor( 20*log10(freqEnd) );
    logPowerVecInterp = ...
        interp1(logFreqVec, logPowerVec, logFreqVecInterp, 'linear');

    linearFreqVecInterp  = 10.^(logFreqVecInterp./20);
    linearPowerVecInterp = 10.^(logPowerVecInterp./10);

    % build filter in frequency domain
    % resample freq, power in linear scale
    power         = zeros(1, filtLength);
    n             = 0:(filtLength/2-1);
    freqResample  = n.*noiseFs/filtLength;
    powerResample = interp1(linearFreqVecInterp, linearPowerVecInterp, ...
                      freqResample, 'linear','extrap');

    % make symmetric filter (real coefficients)
    power( n + 1 )              = powerResample;
    power( filtLength - n )     = power( 2 + n );
    power( filtLength/2 +1 )    = 0;

    mag   = sqrt(power);
    h = fftshift(ifft(mag));
    window = kaiser(filtLength+2);
    h = real(h).*window(2:end-1)';

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
    
    freqOut = linearFreqVecInterp;
    PxxOut  = linearPowerVecInterp;
    
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
