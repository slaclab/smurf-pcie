% Represent sytem as MIMO I/Q in I/Q out
%
% Notch   = 1 - H(s)
% H(s)    = H_re(s) + 1i*H_im(s)
% Notch   = 1 - H_re(s) - 1i*H_im(s) 

% G(s)    = [1-H_re(s), -(0-H_im(s));...
%            (0-H_im(s)), 1-H_re(s)];
% 
% u       = [x_re, x_im]';

function [notchMimo] = generateNotch(Qc, Qr, fNotch, fAdc)

% Represent sytem as MIMO I/Q in I/Q out
%
% Notch   = 1 - H(s)
% H(s)    = H_re(s) + 1i*H_im(s)
% Notch   = 1 - H_re(s) - 1i*H_im(s) 

% G(s)    = [1-H_re(s), -(0-H_im(s));...
%            (0-H_im(s)), 1-H_re(s)];
% u       = [x_re, x_im]';


% Fill in unset optional values.
switch nargin
    case 3
        fAdc = [];  % will return contnuous time model
end


wNotch = 2*pi*fNotch;

H_den  = [(2*Qr/wNotch)^2, (4*Qr/wNotch), 1+(2*Qr)^2];

H_re_num = (Qr/Qc)*[(2*Qr/wNotch), (1)];
H_im_num = (Qr/Qc)*[2*Qr];

H_re = tf(H_re_num, H_den);
H_im = tf(H_im_num, H_den);

G =  [(1-H_re), -(0-H_im);...
              (0-H_im),  (1-H_re)];

if isempty(fAdc)
    notchMimo = G;
else
    % discrete representation 
    discopts = c2dOptions('Method','tustin','PrewarpFrequency',wNotch);
    notchMimo = c2d(G, 1/fAdc, discopts);
end
notchMimo.InputName{1}  = 'I';
notchMimo.InputName{2}  = 'Q';
notchMimo.OutputName{1} = 'I';
notchMimo.OutputName{2} = 'Q';

if nargout == 0
   figure; bode(notchMimo); 
end


end