function [freq, chanOut] = lineTrackingFeedback( channelNo, deltaF, FBen, Finitial, dFmax, FBclr, Dvalid)
%function [freq, chanOut, debug] = lineTrackingFeedback( channelNo, deltaF, FBen, Finitial, dFmax)
% Mcode function lineTrackingFeedback(channelNo, deltaF, FBen,  Finitial, dFmax)
% updates the transmission frequency for a resonant line

%Latency 2(?)
%
% --Change Historty / Notes:
%   
%   <09-27-2017 JED>: -Fixed bug in channelNo CASE block
%                     -Expanded to 16 channels (int1 Mux & df2 demux)
%                     -chan(x) vars expanded to 5-bits
%                     -Removed items that were commented out
%


maxNumChans = 16;

dfType = {xlSigned, 32, 30, xlTruncate, xlSaturate};   % data type for frequency offset from no9minal center frequency

persistent Df1, Df1 = xl_state(0, dfType); % provisional freq offset in pipeline stage 1
persistent Df2, Df2 = xl_state(0, dfType); % provisional freq offset in pipeline stage 2

persistent chan1, chan1 = xl_state(15, {xlUnsigned, 5, 0}); % channel # state vars
persistent chan2, chan2 = xl_state(15, {xlUnsigned, 5, 0});

persistent Fp1, Fp1 = xl_state(0, {xlUnsigned, 24, 24});
persistent Fp2, Fp2 = xl_state(0, {xlUnsigned, 24, 24});


%can't seem to make vector state work, try scalar states for offset
%frequencies
persistent intdf0, intdf0 = xl_state(0, dfType);
persistent intdf1, intdf1 = xl_state(0, dfType);
persistent intdf2, intdf2 = xl_state(0, dfType);
persistent intdf3, intdf3 = xl_state(0, dfType);
persistent intdf4, intdf4 = xl_state(0, dfType);
persistent intdf5, intdf5 = xl_state(0, dfType);
persistent intdf6, intdf6 = xl_state(0, dfType);
persistent intdf7, intdf7 = xl_state(0, dfType);
persistent intdf8, intdf8 = xl_state(0, dfType);
persistent intdf9, intdf9 = xl_state(0, dfType);
persistent intdf10, intdf10 = xl_state(0, dfType);
persistent intdf11, intdf11 = xl_state(0, dfType);
persistent intdf12, intdf12 = xl_state(0, dfType);
persistent intdf13, intdf13 = xl_state(0, dfType);
persistent intdf14, intdf14 = xl_state(0, dfType);
persistent intdf15, intdf15 = xl_state(0, dfType);


% query the state variables
c1 = chan1;
c2 = chan2;
df1 = Df1;
df2 = Df2;
fp1 = Fp1;
fp2 = Fp2;

if channelNo == 1  % unused conditional just for debugging breakpoint
    a=c1; %dummy code to hold a breakpoint
end


switch channelNo    %can't seem to make vector states work so punt to a few scalar states
    case 0  
        int1 = intdf0;
    case 1
        int1 = intdf1;
    case 2
        int1 = intdf2;
    case 3
        int1 = intdf3;
    case 4
        int1 = intdf4;
    case 5
        int1 = intdf5;
    case 6  
        int1 = intdf6;
    case 7
        int1 = intdf7;
    case 8
        int1 = intdf8;
    case 9
        int1 = intdf9;
    case 10
        int1 = intdf10;
    case 11
        int1 = intdf11;
    case 12
        int1 = intdf12;
    case 13
        int1 = intdf13;
    case 14
        int1 = intdf14;
    case 15
        int1 = intdf15;
        
    otherwise
        int1 = xfix(dfType, 0);
end  % end punting

%pipeline stage 1 ______________________________________________________________________________________________
%decode Finitial for this channel
en = xfix({xlBoolean}, xl_slice(Finitial, 24, 24)); % specific channel enable bit is 24th bit of Finitial word
F0 = xl_force(xl_slice(Finitial, 23, 0), xlUnsigned, 24); %low 24 bits are the initial frequency for the channel
% in fraction of FPGA clock rate of 307.2 MHz

if channelNo <= 1  %diagnostic
    disp('channelNo, F0');disp(channelNo); disp(F0);
end

if channelNo == 0  %diagnostic
    disp('Finitial, F0')
    disp(Finitial)
    disp(F0)
end

%if  ~FBen | ~en | channelNo >=16  % feedback disabled or invalid cahnnel number
if  (~FBen | ~en | channelNo >= maxNumChans | ~Dvalid)  % feedback disabled or invalid cahnnel number
    Df1 = xfix(dfType, 0);   % in case of reset or FB not enabled output initial frequency
else
    %compute new freq offset
%                                                disp('deltaF'), disp(deltaF)
    Df1 = xfix(dfType, int1 + deltaF);
end

%---reset operation
if FBclr
    intdf0 = 0;
    intdf1 = 0;
    intdf2 = 0;
    intdf3 = 0;
    intdf4 = 0;
    intdf5 = 0;
    intdf6 = 0;
    intdf7 = 0;
    intdf8 = 0;
    intdf9 = 0;
    intdf10 = 0;
    intdf11 = 0;
    intdf12 = 0;
    intdf13 = 0;
    intdf14 = 0;
    intdf15 = 0;
else
    intdf0 = intdf0;
    intdf1 = intdf1;
    intdf2 = intdf2;
    intdf3 = intdf3;
    intdf4 = intdf4;
    intdf5 = intdf5;
    intdf6 = intdf6;
    intdf7 = intdf7;
    intdf8 = intdf8;
    intdf9 = intdf9;
    intdf10 = intdf10;
    intdf11 = intdf11;
    intdf12 = intdf12;
    intdf13 = intdf13;
    intdf14 = intdf14;
    intdf15 = intdf15;
end


%pipeline stage 2 _________________________________________________________
if df1 >  dFmax  %test for out-of-bounds
    Df2 = xfix(dfType,   dFmax);    % saturate at maximum frequency for this line
elseif df1 < -dFmax;
    Df2 = xfix(dfType,  -dFmax);   %saturate at minimum frequency for this line
else
    Df2 = df1;   % within bounds
end

% pipeline stage 3 ________________________________________________________
%if c2 < 16    % test for valid channel number
if c2 < maxNumChans
        
    switch c2    %can't seem to make vector states work so punt to a few scalar states
        case 0  
            intdf0 = df2;
        case 1
            intdf1 = df2;
        case 2
            intdf2 = df2;
        case 3
            intdf3 = df2;
        case 4
            intdf4 = df2;
        case 5
            intdf5 = df2;
        case 6
            intdf6 = df2;
        case 7
            intdf7 = df2;
        case 8
            intdf8 = df2;
        case 9
            intdf9 = df2;
        case 10
            intdf10 = df2;
        case 11
            intdf11 = df2;
        case 12
            intdf12 = df2;
        case 13
            intdf13 = df2;
        case 14
            intdf14 = df2;
        case 15
            intdf15 = df2;
        otherwise  % unused channel number
    end  % end punting

    freq = xfix({xlUnsigned, 24, 24, xlTruncate, xlSaturate}, df2 + fp2);
    %debug = xfix(dfType, int2);
else
    freq = xfix({xlUnsigned, 24, 24, xlTruncate, xlSaturate}, 0); % invalid cannel number
    %debug = xfix(dfType, 0);
end

% update function outputs and state variables
chanOut = chan2;
chan1 = channelNo;
chan2 = c1;
Fp1 = F0;
Fp2 = fp1;


