function [freq] = lineTrackingFeedback( deltaF, controlReg, Finitial, dFmax, fpgaReset)
% Mcode function lineTrackingFeedback(deltaF, controlReg, fpgaReset)
% updates the transmission frequency for a resonant line
% presently only runs a single loop, FB0

persistent Df, Df = xl_state(0,{xlSigned, 24, 23});

%decode feedback bits from Control register
FBen = xfix({xlBoolean}, xl_slice(controlReg, 4, 4)); % overall FB enable (bit4) 
FBsign = xfix({xlBoolean}, xl_slice(controlReg, 5, 5)); %sign of feedback 
en0 = xfix({xlBoolean}, xl_slice(controlReg, 8, 8)); % enable FB 0 (bit 8)
en1 = xfix({xlBoolean}, xl_slice(controlReg, 9, 9)); % enable FB 1 (bit 9)
FBgain = xl_force(xl_slice(controlReg, 31, 16), xlUnsigned, 11); % feedback gain factor in 16_11
% e.g gain range is 2^-10 to 2^5

if  fpgaReset | ~FBen | ~en0 
    disp(FBgain)
    
    Df = 0; % in case of reset or FB not enabled
else
    %compute new freq
disp(deltaF)
        
    if FBsign
        newDf = Df - FBgain*deltaF; % inverted feedback polarity
    else
        newDf = Df + FBgain*deltaF; % normal feedback polarity
    end
    
    if newDf >  dFmax  %test for out-of-bounds
        newDf = dFmax;
    elseif newDf < -dFmax
        newDf =  - dFmax;
    end
    Df = newDf;
    disp(Df)
end

freq = Df + Finitial
disp(freq)