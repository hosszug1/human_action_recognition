function videoName = recordVideo(vid, videoName)
%RECORDVIDEO Function to record a new video file from the webcam.
%
%   NAME = recordVideo(VID, VIDEONAME) will return the name of the newly
%   created video file.
%
%       VIDEONAME is a string with the desired name
%       VID is the 'videoinput' handle for the webcamera
%
%   See also VIDEOINPUT, STARTGUI, VIDEOWRITER.

fprintf('Starting video recording...\n');

% Set the number of frames per trigger and the colorspace.
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb');
% Start the recording.
start(vid);

% Open a new 'VideoWriter' object.
writerObj = VideoWriter(videoName);
writerObj.FrameRate = 25;
writerObj.open();

% Get 200 frames from the webcam and resize them to match the resolution
% of the training data.
for iFrame = 1:120                    
  I = getsnapshot(vid);
  I = imresize(I, 0.25);
  F = im2frame(I);
  % Write the frame into the video file.
  writeVideo(writerObj, F);
end % for

% Close video file.
writerObj.close();
% Stop recording.
stop(vid);

fprintf('Video recording successful.\n');

end % function recordVideo
