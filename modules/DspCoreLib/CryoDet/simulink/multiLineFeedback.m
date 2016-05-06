function [freq, chanOut] = lineTrackingFeedback( channelNo, deltaF, FBen, FBsign, FBgain, Finitial, dFmax, fpgaReset)
% Mcode function lineTrackingFeedback(channelNo, deltaF, FBen, FBsign, FBgain, Finitial, dFmax, fpgaReset)
% updates the transmission frequency for a resonant line

dfType = {xlSigned, 32, 30, xlTruncate, xlSaturate};   % data type for frequency offset from no9minal center frequency

persistent Df, Df = xl_state(0, dfType);
persistent int1DF, int1DF = xl_state(zeros(1,12), dfType, 12);
persistent int2DF, int2DF = xl_state(zeros(1,12), dfType, 12);

chan = xfix({xlUnsigned, 4, 0}, channelNo);

%decode Finitial for this channel
en = xfix({xlBoolean}, xl_slice(Finitial, 24, 24)); % specific channel enable bit is 24th bit of Finitial word
F0 = xl_force(xl_slice(Finitial, 15, 0), xlUnsigned, 16); %low 16 bits are the initial frequency for the channel

if chan < 12  %valid channel number
    if chan ==0  %diagnostic
        disp('Finitial, F0')
        disp(Finitial)
        disp(F0)
    end

    if  fpgaReset | ~FBen | ~en 

        disp('FBgain'), disp(FBgain)
        Df = xfix(dfType, 0);   % in case of reset or FB not enabled output initial frequency
    else

        %compute new freq
        disp('deltaF'), disp(deltaF)

        Df = int1DF(chan);
        if FBsign
            newDf = xfix(dfType, Df - FBgain*deltaF); % inverted feedback polarity
        else
            newDf = xfix(dfType, Df + FBgain*deltaF); % normal feedback polarity
        end

        if newDf >  dFmax  %test for out-of-bounds
            newDf = xfix(dfType,   dFmax);    % saturate at maximum frequency for this line
        elseif newDf < -dFmax;
            newDf = xfix(dfType,  -dFmax);   %saturate at minimum frequency for this line
        end
        Df = newDf;

    end

    int1DF(chan) = Df
    freq = xfix({xlUnsigned, 24, 24, xlTruncate, xlSaturate}, Df + F0); 
    
else
    freq = xfix({xlUnsigned, 24, 24, xlTruncate, xlSaturate}, 0); % invalid cannel number
end

chanOut = xfix({xlUnsigned, 4, 0}, chan);  %bit width must match freqBusAddrBits
