function [newFreq] = lineTrackingFeedback( deltaF, controlReg, Finitial, dFmax, fpgaReset)
% Mcode function lineTrackingFeedback(deltaF, controlReg, fpgaReset)
% updates the transmission frequency for a resonant line
% presently only runs a single loop, FB0

persistent freq, freq = xl_state(0,{xlUnsigned, 16, 16});

%decode feedback bits from Control register
FBen = xfix({xlBoolean}, xl_slice(controlReg, 4, 4)); % overall FB enable (bit4) 
FBsign = xfix({xlBoolean}, xl_slice(controlReg, 5, 5)); %sign of feedback 
en0 = xfix({xlBoolean}, xl_slice(controlReg, 8, 8)); % enable FB 0 (bit 8)
en1 = xfix({xlBoolean}, xl_slice(controlReg, 9, 9)); % enable FB 1 (bit 9)
FBgain = xl_lsh(xl_slice(controlReg, 31, 16), 8); % feedback gain factor in 16_8

if  fpgaReset | ~FBen | ~en0 
    newFreq = Finitial; % in case of reset or FB not enabled
else
    %compute new freq
    if FBsign
        newFreq = freq - FBgain*deltaF; % inverted feedback polarity
    else
        newFreq = freq + FBgain*deltaF; % normal feedback polarity
    end
    if newFreq > Finitial + dFmax  %test for out-of-bounds
        newFreq = Finitial + dFmax;
    elseif newFreq < Finitial - dFmax
        newFreq = Finitial - dFmax;
    end
end
freq = newFreq;