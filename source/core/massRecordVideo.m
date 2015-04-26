function massRecordVideo(vid, type)
%MASSRECORDVIDEO Function to mass record video data from the webcam.
%
%   NAME = massRecordVideo(VID) will return the name of the newly
%   created video file.
%
%       VIDEONAME is a string with the desired name
%
%   See also RECORDVIDEO, VIDEOINPUT, STARTGUI, VIDEOWRITER.

% Pause 6 seconds to give the performer time to get into position.
pause(6);

numberOfExamples = 10;
originalFileName = 'gabor_unknown_d';

switch type
    case ActionType.Boxing
        originalFileName = 'gabor_boxing_d';
    case ActionType.Handclapping
        originalFileName = 'gabor_handclapping_d';
    case ActionType.Handwaving
        originalFileName = 'gabor_handwaving_d';
    otherwise
end

for i = 1:numberOfExamples
    fileName = strcat(originalFileName, num2str(i));
    recordVideo(vid, fileName);
    % Pause for 3 seconds so the person can switch position if needed.
    pause(3);
end

fprintf('!!! MASS RECORDING FINISHED !!!\n');

end % function recordVideo
