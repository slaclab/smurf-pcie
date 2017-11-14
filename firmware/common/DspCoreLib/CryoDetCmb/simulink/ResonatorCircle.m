%script ResonatorCircle
% The below code takes it from on of the simulink scopes
%
%
%
Sig = ScopeData2.signals(1).values; size(Sig)
Ref = ScopeData2.signals(2).values;
freq =ScopeData2.signals(3).values; %vector of frequency set for channel 0
time = ScopeData2.time;

%choose a start time to eliminate initial transient
start = 0.5e-6
first = find(time>=start,1);
last = length(time);
range = first:last;
figure(10),plot(time(range),Sig(range,:)); grid, title('Response')

cSig = 1i*Sig(:,1) + Sig(:,2);
cRef = 1i*Ref(:,1) + Ref(:,2);
S21 = cSig(range)./cRef(range);
figure(11), plot(S21), grid, title('S21 plot')
axis square
axis equal
 
%trim to range and create stimulus frequency vector
time = time(range);
Sig = Sig(range,:);
Ref = Ref(range,:);
cSig = 1i*Sig(:,1) + Sig(:,2);
cRef = 1i*Ref(:,1) + Ref(:,2);
S21 = cSig ./ cRef;
freq = freq(range);

%find minimum response
idx = find(abs(S21)==min(abs(S21)),1);
hold on, plot(S21(idx) ,'xr'), hold off

%Highlight S21 every 100 kHz
df = mean(diff(freq)); %frequency spacing of points
%delta = 10e6
delta = 10e6
n0 = round(delta/df)
n1 = floor(idx/n0);
ticks = idx + n0*(-n1:n1);
hold on, plot(S21(ticks),'g+', 'MarkerSize', 12), hold off
hold on, plot(S21(idx) ,'xr', 'MarkerSize', 12), hold off

figure(12), plot(freq/1e6, Sig(:,3)), grid, title('Response vs. Freq')
xlabel('Stimulus Frequency (MHz)')
hold on, plot(freq(idx)/1e6, Sig(idx,3) ,'xr'), hold off


% fit to S21 over narrow frequency range
dF = 0.250e6;
ixLo = idx - round(dF/df)
ixHi = idx + round(dF/df)
dS21 = S21(ixHi) - S21(ixLo);
deltaF = freq(ixHi) - freq(ixLo)
slope = deltaF/dS21
Ferr1 = real(S21*slope); %estimate frequency error
figure(23),plot(freq, freq-freq(idx), freq, Ferr1), grid, title('Est Freq Err vs. Freq')

%calc eta', the parameter, which gives frequency error via
%Ferr=real(eta'*Sig*conj(Ref))

etap = slope/abs(Ref(idx))^2/Fclk
Ferr = Fclk * real(etap*cSig.*conj(cRef));
figure(24),plot(freq, freq-freq(idx), freq, Ferr),grid
figure(25), plot(freq, Ferr-freq), grid, title('Residual')

