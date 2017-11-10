function [synch, minmax] = synchronize(adc0, adc1, thresh, reset)
% mcode function synchronize(adc0, adc1, thresh)
% counts clock ticks since last threshold-crossing event on ADC channel

persistent deadTimeCount, deadTimeCount = xl_state(0, {xlUnsigned, 8, 0, xlTruncate, xlSaturate});
persistent synchCount, synchCount = xl_state(0, {xlUnsigned, 32, 0, xlTruncate, xlSaturate});
persistent min, min = xl_state(0, {xlSigned, 16, 15, xlTruncate, xlSaturate});
persistent max, max = xl_state(0, {xlSigned, 16, 15, xlTruncate, xlSaturate});

synch = synchCount;

if deadTimeCount == 255  % only look for trigger after deadtime counter has timed-out
    if adc0 > thresh
        synchCount = 0;  %reset synch counter   
        deadTimeCount = 0;
    elseif adc1 > thresh
        synchCount = 1;  %reset synch counter      
        deadTimeCount = 0;
    else
        synchCount = synchCount + 2;
    end
else
    synchCount = synchCount + 2; %synch counter counts at ticks of 370 MSPS
    deadTimeCount = deadTimeCount + 1;
end

if reset
    min = xfix({xlSigned, 16, 15, xlTruncate, xlSaturate}, 0);
    max = xfix({xlSigned, 16, 15, xlTruncate, xlSaturate}, 0);
end

if adc0 > max 
    max = adc0
end

if adc1 > max
    max = adc1
end

if adc0 < min
    min = adc0
end

if adc1 < min
    min = adc1
end


minmax = xl_concat(xl_force(min, xlUnsigned, 0), xl_force(max, xlUnsigned, 0));
end