function [output] = addFracTimingDelay(input, frac)

    if frac == 0
        output = input;
    else

        inputTime  = 1:length(input);
        outputTime = inputTime + frac;

        output = interp1(inputTime, input, outputTime, 'spline');
    end

end
