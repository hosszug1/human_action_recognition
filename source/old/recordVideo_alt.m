function videoName = recordVideo_alt(vid, videoName)
%RECORDVIDEO Summary of this function goes here
%   Detailed explanation goes here

set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb');
vid.FrameGrabInterval = 1;
start(vid)

writerObj = VideoWriter(videoName);
writerObj.FrameRate = 25;
writerObj.open();


writerObj.close();
stop(vid);

end

