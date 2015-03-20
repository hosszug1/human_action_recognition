function [videoFrames, numOfFrames, height, width] = extractFrames(pathToVid)
%READ Summary of this function goes here
%   Detailed explanation goes here
myVideo = VideoReader(pathToVid);

videoFrames = read(myVideo);
numOfFrames = myVideo.NumberOfFrames;
height = myVideo.Height;
width = myVideo.Width;

end

