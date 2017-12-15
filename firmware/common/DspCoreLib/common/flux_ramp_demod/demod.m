close all



% Readout setup
Fs = 600e3;               % downsampled rate
resetRate = 1e3;          % flux ramp reset rate
frameSize = Fs/resetRate; % number of samples per frame
freqNorm  = 2.6e3/Fs;     % normalized frequency, 2.6kHz with 1kHz reset rate corresponds to 2.6 phi0 

% build observation model
freqOff = 0;                         % frequency offset Hz
freqObs = freqNorm + freqOff/Fs;     % observation matrix frequency
H = [];
modelOrder = 3;  % include 3rd order harmonics
for i = 1:modelOrder
    cs      = cos(i*2*pi*freqObs*[0:1:frameSize-1]);
    sn      = sin(i*2*pi*freqObs*[0:1:frameSize-1]);
    H       = [H, sn', cs']; % build observation matrix
end
H = [H, ones(length(cs),1)]; % add DC component


% look at estiamted phase error vs phase offset 1-360 deg
err = zeros(360,1);
err1 = zeros(360,1);
disp_n = 130;  % display the 130 degree phase offset case
for d = 1:360    
    % flux ramp
    lambda = 0.33;
    noise = 0.01;
    poff = 2*pi*(d/360);
    sig = sin(2*pi*freqNorm*[0:1:frameSize-1] + poff);  % ideal sin
    obs = (lambda*sig')./(1+lambda*sig');               % flux ramp mod
    obs_n = obs + noise*randn(size(obs));               % noisy measurement
    
    if d == disp_n
        figure;
        plot(sig)
        hold on
        plot(obs)
        plot(obs_n)
        legend('pure sinewave','flux ramp response','noise corrupted flux ramp')
    end


    alpha = H\obs_n;  % least square estimate
    est = atan2(alpha(2),alpha(1));  % use 1st harmonic phase for estiamte
%     disp(['Estimated phase ', num2str(est), ' actual phase: ' num2str(poff), ' error ', num2str(poff-est)])
    err(d) = (poff - est)*180/pi;




    % rebuild signal estimate
    sig_est = alpha(end)*ones(size(obs)); % DC component
    for i = 1:modelOrder
       amp =  sqrt(alpha(2*i).^2 + alpha((2*i)-1).^2);
       phase = atan2(alpha(2*i), alpha((2*i)-1));
       sig_est = sig_est + amp*sin(i*2*pi*freqNorm*[0:1:frameSize-1] + phase)';
    end
    
    % compare to 1st order estimate
    H1 = [H(:,1:2), H(:,end)];
    alpha1 = H1\obs_n;
    amp1 = sqrt(alpha1(1)^2 + alpha1(2)^2);
    phase1 = atan2(alpha1(2), alpha1(1));
    sig_est1 = amp1*sin(2*pi*freqNorm*[0:1:frameSize-1] + phase1)' + alpha1(end);
    err1(d) = (poff - phase1)*180/pi;
    
    
    if d == disp_n
        figure
        plot(sig_est)
        hold on
        plot(sig_est1)
        plot(obs)
        
        legend([num2str(modelOrder) ' order, estimate error: ',num2str(err(d)), ' deg'],...
            ['1 order, estimate error: ',num2str(err1(d)), ' deg'],...
            'original signal')
    end


end

err_unwrap = unwrap(err*pi/180)*180/pi;
err1_unwrap = unwrap(err1*pi/180)*180/pi;

figure;
plot(err_unwrap)
hold on
plot(err1_unwrap)
title('Error vs phase offset')
ylabel('Error (deg)')
xlabel('Phase offset (degree)')
legend([num2str(modelOrder) ' order'],...
    '1 order')

disp([num2str(modelOrder), ' order RMS:' num2str(std(err_unwrap))])
disp(['1 order RMS: ', num2str(std(err1_unwrap))])