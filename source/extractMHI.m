function resultingMHI = extractMHI(binaryFrames, height, width, numOfFrames)
%EXTRACTMHI Summary of this function goes here
%   Detailed explanation goes here

resultingMHI = cast(zeros(height, width, numOfFrames), 'uint8');

% Constants. Can be changed for calibration.
% Temporal extent of the movement.
tau = 10;
% Decay parameter.
delta = 1;
% Treshold for the binerized image.
% ksi = 0;

for x = 1:height
    for y = 1:width
        for t = 1:(numOfFrames - 1)
            resultingMHI(x, y, t) = H(x, y, t, binaryFrames, tau, delta);
        end
    end
end


end

function hValue = H(x, y, t, binaryFrames, tau, delta)

% if (psi(x, y, t, ksi) == 1)
if (binaryFrames(x, y, t) == 1 || t == 1)
    hValue = tau;
else
    hValue = max(0, H(x, y, t-1, binaryFrames, tau, delta) - delta);
end

end


%%% THE UPDATE FUNCTION %%%
%%% Use something else instead, but same principle, return 1 or 0.
% Motion Energy Image value (binary).
function binaryValue = mei(x, y, t)



end

function psiValue = psi(x, y, t, ksi)

if (D(x, y, t) >= ksi)
    psiValue = 1;
else
    psiValue = 0;
end

end

function dValue = D(x, y, t)

end

