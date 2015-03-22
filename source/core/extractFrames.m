function [videoFrames, numOfFrames, height, width] = extractFrames(pathToVid)
%EXTRACTFRAMES Function for extracting the frames from a video file.
%   
%   [VF, N, H, W] = extractFrames(PATH) returns a H x W x N matrix of
%   the decoded frames from the video file, where H is the height, W is
%   the width of the frames and N represents the total number of frames.
%
%       PATH is the path to the video file.
%
%   See also BUILDFEATUREVECTOR, TRAINSYSTEM.

% Create a 'VideoReader' class to decode the video.
myVideo = VideoReader(pathToVid);

% Get frames, their number, heigh and width.
videoFrames = read(myVideo);
numOfFrames = myVideo.NumberOfFrames;
height = myVideo.Height;
width = myVideo.Width;

end % function extractFrames

