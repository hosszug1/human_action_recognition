function resultingMHI = extractMHI(binaryFrames, height, width, numOfFrames)
%EXTRACTMHI Function used the extract the Motion History Image (MHI) from
%   a video file (i.e. a matrix of already decoded frames).
%   
%   MHI = extractMHI(BF, H, W, N) returns the MHI from the supplied frames.
%
%       BF is the H x W x N matrix of frames
%       H is the height of the frames
%       W is the width of the frames
%       N represents the number of frames
%
%   See also FEATUREVECTOR, FEATUREVECTORTYPE, EXTRACTFRAMES.

resultingMHI = cast(zeros(height, width), 'uint8');

% Constants. Can be changed for calibration.
% Temporal extent of the movement.
tau = 255;
% Decay parameter.
delta = Constants.decayParameter;

for x = 1:height
    for y = 1:width
        % fprintf('y = %d\n', y);
        % Set the recursion limit to the number of frames.
        % set(0, 'RecursionLimit', numOfFrames + 2)
        resultingMHI(x, y) = calculateH(x, y, numOfFrames, binaryFrames, tau, delta);
    end % for
end % for

    
end % function extractMHI

% The update function for the MHI.
function hValue = calculateH(x, y, t, binaryFrames, tau, delta)

if (tau <= delta)
    hValue = 0;
elseif (t <= 1 || binaryFrames(x, y, t) == 1)
    hValue = tau;
else
    hValue = calculateH(x, y, t-1, binaryFrames, tau - delta, delta);
end % if

end % function calculateH
