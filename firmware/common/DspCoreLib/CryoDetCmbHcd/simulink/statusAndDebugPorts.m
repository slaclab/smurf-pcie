function [debugStream, fmon,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11] = statusAndDebugPorts(Chan, f, statusMux, debugMux)
% SSmith 22July2016

% f is a 32 bit signed representing either of :
%   1   present tracking frequency of each resonator
%       expressed as a fraction of 185 MHz 
%       expected to be format Signed_32_31
%   or
%   2   estimated frequency error e.g. the frequency difference between
%       tracking frequency and the center of the resonance
%       expressed as a fraction of 185 MHz/16 expected to be of format Signed_32_32


% statusMux (Unsigned 4_0) selects which channel's f is output to monitor port 

% debugMux (Unsigned 4_0) selects which channel(s) are sent to the debug stream
% debugMux = 0..11 selects this one channel
% debugMux = 15 selects all channels interleaved

persistent Fram, Fram = xl_state(zeros(1,12), {xlSigned, 32, 31}, 12);
persistent chanOut, chanOut = xl_state(0, {xlUnsigned, 4, 0, xlTruncate, xlWrap});

%Update status register outputs

f0 = Fram(0);   
f1 = Fram(1);   
f2 = Fram(2);   
f3 = Fram(3);   
f4 = Fram(4);   
f5 = Fram(5);   
f6 = Fram(6);  
f7 = Fram(7);   
f8 = Fram(8);   
f9 = Fram(9);   
f10 = Fram(10); 
f11 = Fram(11); 

%fmon = Fram(statusMux); %oops,"can't map to hardware..."
if statusMux == 0
        fmon = f0;
elseif statusMux == 1
        fmon = f1;
elseif statusMux == 2
        fmon = f2;
elseif statusMux == 3
        fmon = f3;
elseif statusMux == 4
        fmon = f4;
elseif statusMux == 5
        fmon = f5;
elseif statusMux == 6
        fmon = f6;
elseif statusMux == 7
        fmon = f7;
elseif statusMux == 8
        fmon = f8;
elseif statusMux == 9
        fmon = f9;
elseif statusMux == 10
        fmon = f10;
elseif statusMux == 11
        fmon = f11; 
else
        fmon = xfix({xlSigned, 32 , 31}, 0);
end  
        

%generate debug stream
%if debugMux <= 11  % single channel debug stream
%    debugStream = Fram(debugMux);
if debugMux == 0  
    debugStream = Fram(0);
elseif debugMux == 1
    debugStream = Fram(1);
elseif debugMux == 2
    debugStream = Fram(2);
elseif debugMux == 3
    debugStream = Fram(3);
elseif debugMux == 4
    debugStream = Fram(4);
elseif debugMux == 5
    debugStream = Fram(5);
elseif debugMux == 6
    debugStream = Fram(6);
elseif debugMux == 7
    debugStream = Fram(7);
elseif debugMux == 8
    debugStream = Fram(8);
elseif debugMux == 9
    debugStream = Fram(9);
elseif debugMux == 10
    debugStream = Fram(10);
elseif debugMux == 11
    debugStream = Fram(11);
else               % interleave all channels in debug stream with low 4 bits set to channel number
    if chanOut == 0
        debugStream = xl_force(xl_concat(xl_slice(Fram(0), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 1
        debugStream = xl_force(xl_concat(xl_slice(Fram(1), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 2
        debugStream = xl_force(xl_concat(xl_slice(Fram(2), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 3
        debugStream = xl_force(xl_concat(xl_slice(Fram(3), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 4
        debugStream = xl_force(xl_concat(xl_slice(Fram(4), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 5
        debugStream = xl_force(xl_concat(xl_slice(Fram(5), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 6
        debugStream = xl_force(xl_concat(xl_slice(Fram(6), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 7
        debugStream = xl_force(xl_concat(xl_slice(Fram(7), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 8
        debugStream = xl_force(xl_concat(xl_slice(Fram(8), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 9
        debugStream = xl_force(xl_concat(xl_slice(Fram(9), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 10
        debugStream = xl_force(xl_concat(xl_slice(Fram(10), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    elseif  chanOut == 11
        debugStream = xl_force(xl_concat(xl_slice(Fram(11), 31, 4), chanOut), xlSigned, 31);  %replace low 4 bits with channel number)
    else
        debugStream = xfix({xlSigned, 32 , 31}, 0);
    end
end

if Chan == 0
    Fram(0) = xl_force(f, xlSigned, 31);    %update RAM 0
elseif Chan == 1
    Fram(1) = xl_force(f, xlSigned, 31);    %update RAM 1
elseif Chan == 2
    Fram(2) = xl_force(f, xlSigned, 31);    %update RAM 2 
elseif Chan == 3
    Fram(3) = xl_force(f, xlSigned, 31);    %update RAM 3
elseif Chan == 4
    Fram(4) = xl_force(f, xlSigned, 31);    %update RAM 4
elseif Chan == 5
    Fram(5) = xl_force(f, xlSigned, 31);    %update RAM 5
elseif Chan == 6
    Fram(6) = xl_force(f, xlSigned, 31);    %update RAM 6
elseif Chan == 7
    Fram(7) = xl_force(f, xlSigned, 31);    %update RAM 7
elseif Chan == 8
    Fram(8) = xl_force(f, xlSigned, 31);    %update RAM 8
elseif Chan == 9
    Fram(9) = xl_force(f, xlSigned, 31);    %update RAM 9
elseif Chan == 10
    Fram(10) = xl_force(f, xlSigned, 31);    %update RAM 10
elseif Chan == 11
    Fram(11) = xl_force(f, xlSigned, 31);    %update RAM 11
end

if chanOut < 11
    chanOut = 1 + chanOut;    %interleaved channel counter
else
    chanOut = 0;
end