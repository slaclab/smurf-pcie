function [freq, chanOut] = lineTrackingFeedback( channelNo, deltaF, FBen, FBsign, FBgain, Finitial, dFmax, fpgaReset)
% Mcode function lineTrackingFeedback(channelNo, deltaF, FBen, FBsign, FBgain, Finitial, dFmax, fpgaReset)
% updates the transmission frequency for a resonant line

dfType = {xlSigned, 32, 30, xlTruncate, xlSaturate};   % data type for frequency offset from no9minal center frequency

%%% persistent Df, Df = xl_state(0, dfType); %not used as state variable anymore
persistent int1DF, int1DF = xl_state(zeros(1,12), dfType, 12);
persistent int2DF, int2DF = xl_state(zeros(1,12), dfType, 12);
persistent chan, chan = xl_state(0, {xlUnsigned, 4, 0})
%chan = xfix({xlUnsigned, 4, 0}, channelNo);
chan = channelNo;

%decode Finitial for this channel
en = xfix({xlBoolean}, xl_slice(Finitial, 24, 24)); % specific channel enable bit is 24th bit of Finitial word
F0 = xl_force(xl_slice(Finitial, 15, 0), xlUnsigned, 16); %low 16 bits are the initial frequency for the channel

if channelNo < 12  %valid channel number
    
    if channelNo == 0  %diagnostic
        disp('Finitial, F0')
        disp(Finitial)
        disp(F0)
    end

    if  fpgaReset | ~FBen | ~en 

        disp('FBgain'), disp(FBgain)
        newDf = xfix(dfType, 0);   % in case of reset or FB not enabled output initial frequency
    else

        %compute new freq
        disp('deltaF'), disp(deltaF)
        prevDf = int1DF(chan);

        if FBsign
            provisDf = xfix(dfType, prevDf - FBgain*deltaF); % inverted feedback polarity
        else
            provisDf = xfix(dfType, prevDf + FBgain*deltaF); % normal feedback polarity
        end

        if provisDf >  dFmax  %test for out-of-bounds
            newDf = xfix(dfType,   dFmax);    % saturate at maximum frequency for this line
        elseif provisDf < -dFmax;
            newDf = xfix(dfType,  -dFmax);   %saturate at minimum frequency for this line
        else
            newDf = provisDf;   % within bounds
        end


    end

    int1DF(chan) = newDf;
    freq = xfix({xlUnsigned, 24, 24, xlTruncate, xlSaturate}, newDf + F0); 
    
else
    freq = xfix({xlUnsigned, 24, 24, xlTruncate, xlSaturate}, 0); % invalid cannel number
end

chanOut = xfix({xlUnsigned, 4, 0}, channelNo);  %bit width must match freqBusAddrBits
