% Numerically calculate fourier coefficients for h harmonics
% of SQUID response.  Shows that change in SQUID response phase is directly
% proportional to correspdoning harmonic phase shift.
%
% atan2(b_n, a_n) = n*delPhi
%
%

lambda = 0.3;   % SQUID parameter - sets harmonic content
n      = 1000;  % sweep delPhi over 1000 points
h      = 3;     % approximate with 3 harmonics

a     = zeros(h, n);
b     = zeros(h, n);
phase = zeros(h, n);


x = linspace(-pi, pi, 10000);

norm = n*pi*pi/2;

% sweep over delta phase
for i = 1:n
    
   p = (i/1000)*2*pi;
   f = lambda.*cos(x + p)./(1 + lambda.*cos(x + p));
   
   % calculated jth fourier coefficient
   for j = 1:h
      a(j, i) = trapz( f.*cos(j*x) )/norm;
      b(j, i) = trapz( f.*sin(j*x) )/norm;
   end
         
end

p  = (1:n)*2*pi/n;

% calculate phases

for j = 1:h
    phase(j,:) = unwrap(atan2(a(j,:), b(j,:)));
end

% show that atan2(b_n, a_n) = n*delPhi
p1     = polyfit(p, phase(1,:), 1);
p1(1)

p2     = polyfit(p, phase(2,:), 1);
p2(1)


p3     = polyfit(p, phase(3,:), 1);
p3(1)


figure
plot(p, phase(1,:))
xlabel('Delta phase')
ylabel('Delta phase 1st harmonic')

figure
plot(p, phase(2,:))
xlabel('Delta phase')
ylabel('Delta phase 2nd harmonic')


figure
plot(p, phase(3,:))
xlabel('Delta phase')
ylabel('Delta phase 3rd harmonic')


% plot 1 cycle and 3rd harmonic approximation


f_approx = zeros(size(x));
for j = 1:h
   f_approx = f_approx + a(j,end).*cos(j*x) +  b(j,end).*sin(j*x);
end

figure;
subplot(2,1,1)
plot(f - mean(f))
hold on;
plot(f_approx)
legend('SQUID response', '3rd harmonic approx')

subplot(2,1,2)
plot(f - mean(f) - f_approx)
legend('Error')
