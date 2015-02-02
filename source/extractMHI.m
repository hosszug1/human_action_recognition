function resultingMHI = extractMHI(frames, numOfFrames)
%EXTRACTMHI Summary of this function goes here
%   Detailed explanation goes here

resultingMHI = zeros(height, width, numOfFrames);

% Constants.
tau = 20;
delta = 0;
ksi = 0;

for x = 1:height
    for y = 1:width
        for t = 1:(numOfFrames - 1)
            
            resultingMHI(x, y, t) = H(x, y, t, tau, delta, ksi);
            
            if (psi(x, y, t) == 1)
                resultingMHI(x, y) = tau;
            else
                resultingMHI(x, y) = 0;
            end
        end
    end
end


end

function hValue = H(x, y, t, tau, delta, ksi)

if (psi(x, y, t, ksi) == 1)
    hValue = tau;
else
    hValue = max(0, H(x, y, t-1) - delta);
end

end



%%% Use something else instead, but same principle, return 1 or 0.
% Motion Energy Image value (binary).
function psiValue = psi(x, y, t, ksi)

if (D(x, y, t) >= ksi)
    psiValue = 1;
else
    psiValue = 0;
end

end

function dValue = D(x, y, t)

end

