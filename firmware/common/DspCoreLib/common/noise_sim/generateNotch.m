% Represent sytem as MIMO I/Q in I/Q out
%
% Notch   = 1 - H(s)
% H(s)    = H_re(s) + 1i*H_im(s)
% Notch   = 1 - H_re(s) - 1i*H_im(s) 
% G(s)    = [1-H_re(s), -(0-H_im(s));...
%            (0-H_im(s)), 1-H_re(s)];
% 
% u       = [x_re, x_im]';
%
% function [notchMimo, complexNotch] = generateNotch(Qc, Qr, fNotchRf, fNotchBaseband, fAdc)
function [notchMimo, complexNotch] = generateNotch(Qc, Qr, fNotchRf, varargin)

% Fill in unset optional values.
numvarargs             = length(varargin);
optargs                = {fNotchRf, []};  % default continuous system with fNotchBaseband = fNotchRf
optargs(1:numvarargs)  = varargin;

[fNotchBaseband, fAdc] = optargs{:};


wNotchRf       = 2*pi*fNotchRf;
wNotchBaseband = 2*pi*fNotchBaseband;

H_den  = [(2*Qr/wNotchRf)^2, (4*Qr/wNotchRf), 1+(2*Qr*fNotchBaseband./fNotchRf)^2];

H_re_num = (Qr/Qc)*[(2*Qr/wNotchRf), (1)];
H_im_num = (Qr/Qc)*[2*Qr*fNotchBaseband./fNotchRf];

H_re = tf(H_re_num, H_den);
H_im = tf(H_im_num, H_den);

G =  [(1-H_re), -(0-H_im);...
              (0-H_im),  (1-H_re)];

if isempty(fAdc)
    notchMimo = G;
else
    % discrete representation 
    discopts = c2dOptions('Method','tustin','PrewarpFrequency',wNotchBaseband);
    notchMimo = c2d(G, 1/fAdc, discopts);
end
notchMimo.InputName{1}  = 'I';
notchMimo.InputName{2}  = 'Q';
notchMimo.OutputName{1} = 'I';
notchMimo.OutputName{2} = 'Q';

complexNotch = 1 - H_re -1i*H_im;

% with not output arguments plot complex and mimo response
if nargout == 0
   opts = bodeoptions;
   opts.FreqUnits = 'Hz';
   figure; bode(notchMimo, opts);
   figure; bode(complexNotch, opts);
   figure; nyquist(complexNotch); grid on; xlim([0 1]);
end


end
