function resultingMHI = extractMHI(binaryFrames, height, width, numOfFrames)
%EXTRACTMHI Summary of this function goes here
%   Detailed explanation goes here

resultingMHI = cast(zeros(height, width), 'uint8');

% Constants. Can be changed for calibration.
% Temporal extent of the movement.
tau = 255;
% Decay parameter.
delta = Constants.decayParameter;
% Treshold for the binerized image.
% ksi = 0;

for x = 1:height
    % fprintf('x = %d', x);
    for y = 1:width
        % fprintf('y = %d\n', y);
        % Set the recursion limit to the number of frames.
        % set(0, 'RecursionLimit', numOfFrames + 2)
        resultingMHI(x, y) = calculateH_alt(x, y, numOfFrames, binaryFrames, tau, delta);
    end
end

    
end


%%% THE UPDATE FUNCTION %%%
%%% Use something else instead, but same principle, return 1 or 0.
function hValue = calculateH_alt(x, y, t, binaryFrames, tau, delta)

if (tau <= delta)
    hValue = 0;
elseif (t <= 1 || binaryFrames(x, y, t) == 1)
    hValue = tau;
else
    hValue = calculateH_alt(x, y, t-1, binaryFrames, tau - delta, delta);
end

end
