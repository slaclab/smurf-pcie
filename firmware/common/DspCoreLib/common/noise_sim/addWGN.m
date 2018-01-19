%  [output]        = addWGN(input, SNR)
%  [output, noise] = addWGN(input, SNR)
%
%  generates WGN with power level defined by input signal and SNR
%      returns complex WGN if input is complex
%
%
%  Example usage:
% 
%  t               = 1:1e6;
%  input           = exp(j*2*pi.*t./21);
%  SNR             = 50;  
%  [output, noise] = addWGN(input, SNR);
%
%  figure
%  pwelch(output)


function [output, noise] = addWGN(input, SNR)

    signalPower = (input*input')/(length(input));
    noisePower  = signalPower/(10^(SNR/10));

    if isreal(input)
        noise = sqrt(noisePower)*randn(size(input));
    else
        noise = sqrt(noisePower)*(sqrt(2)/2)* ...
	    ( randn(size(input)) + 1i*randn(size(input)) );  
    end

    output = input + noise;
end
