function [freq, chanOut] = lineTrackingFeedback( channelNo, deltaF, FBen, Finitial, dFmax)
% Mcode function lineTrackingFeedback(channelNo, deltaF, FBen,  Finitial, dFmax)
% updates the transmission frequency for a resonant line

%Latency 2(?)

dfType = {xlSigned, 32, 30, xlTruncate, xlSaturate};   % data type for frequency offset from no9minal center frequency

persistent Df1, Df1 = xl_state(0, dfType); % provisional freq offset in pipeline stage 1
persistent Df2, Df2 = xl_state(0, dfType); % provisional freq offset in pipeline stage 2

persistent chan1, chan1 = xl_state(15, {xlUnsigned, 4, 0});
persistent chan2, chan2 = xl_state(15, {xlUnsigned, 4, 0});

persistent Fp1, Fp1 = xl_state(0, {xlUnsigned, 24, 24});
persistent Fp2, Fp2 = xl_state(0, {xlUnsigned, 24, 24});

persistent int1DF, int1DF = xl_state(zeros(1,12), dfType, 12); %first integrator
persistent int2DF, int2DF = xl_state(zeros(1,12), dfType, 12); %second integrator )not yet used)

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


% query the state variables
c1 = chan1;
c2 = chan2;
df1 = Df1;
df2 = Df2;
fp1 = Fp1;
fp2 = Fp2;

if channelNo ==1  % unused conditional just for debugging breakpoint
    a=c1;%dummy code to hold a breakpoint
end

%if channelNo <12  %%%% vector states don't appear to work
%%next try chan = xfix({xlUnsigned, 4, 0}, channelNo); %then use as index,is Matlab confused about types?
%    int1 = int1DF(channelNo);
%    int2 = int2DF(channelNo);
%else
%    int1 = xfix(dfType, 0);
%    int2 = xfix(dfType, 0);
%end

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
    otherwise
        int1 = xfix(dfType, 0);
end  % end punting

%pipeline stage 1 ______________________________________________________________________________________________
%decode Finitial for this channel
en = xfix({xlBoolean}, xl_slice(Finitial, 24, 24)); % specific channel enable bit is 24th bit of Finitial word
F0 = xl_force(xl_slice(Finitial, 23, 0), xlUnsigned, 24); %low 24 bits are the initial frequency for the channel
% in fraction of FPGA clock rate of 185 MHz

if channelNo <=1  %diagnostic
    disp('channelNo, F0');disp(channelNo); disp(F0);
end

if channelNo == 0  %diagnostic
    disp('Finitial, F0')
    disp(Finitial)
    disp(F0)
end

if  ~FBen | ~en | channelNo >=12  % feedback disabled or invalid cahnnel number
    Df1 = xfix(dfType, 0);   % in case of reset or FB not enabled output initial frequency
else
    %compute new freq offset
%                                                disp('deltaF'), disp(deltaF)
    Df1 = xfix(dfType, int1 + deltaF);
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
if c2 < 12    % test for valid channel number   
%    int1DF(c2) = df2;
        
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
        otherwise  % unused channel number
    end  % end punting

    freq = xfix({xlUnsigned, 24, 24, xlTruncate, xlSaturate}, df2 + fp2);  
else
    freq = xfix({xlUnsigned, 24, 24, xlTruncate, xlSaturate}, 0); % invalid cannel number
end

% update function outputs and state variables
chanOut = chan2;
chan1 = channelNo;
chan2 = c1;
Fp1 = F0;
Fp2 = fp1;


