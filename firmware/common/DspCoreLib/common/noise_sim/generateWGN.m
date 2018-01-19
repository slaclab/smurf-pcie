%  [noise]         = generateWGN(input, SNR)
%  [noise, output] = generateWGN(input, SNR)
%
%  generates WGN with power level defined by input signal and SNR
%      returns complex WGN if input is complex
%
%  Example usage
% 
%  t               = 1:1e6;
%  input           = exp(-j*2*pi.*t./21)
%  SNR             = 50;  
%  [noise, output] = generateWGN(input, SNR) 
%
%  figure
%  pwelch(output)
%

function [noise, output] = addWGN(input, SNR)

%     signalPower = sum(input.^2)/(length(input));
    signalPower = (input*input')/(length(input));
    noisePower  = signalPower/(10^(SNR/10));


    noise = zeros(size(input));
    if isreal(input)
        noise = sqrt(noisePower)*randn(size(input));
    else
        noise = sqrt(noisePower)*(sqrt(2)/2)* ...
	    ( randn(size(input)) + j*randn(size(input)) );  
    end

    output = input + noise;
end
