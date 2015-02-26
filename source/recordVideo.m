function videoName = recordVideo(vid, videoName)
%RECORDVIDEO Summary of this function goes here
%   Detailed explanation goes here

set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb');
vid.FrameGrabInterval = 1;
start(vid)

writerObj = VideoWriter(videoName);
writerObj.FrameRate = 25;
writerObj.open();

for iFrame = 1:360                    

  I = getsnapshot(vid);
  I = imresize(I, 0.25);
  F = im2frame(I);                     
  writeVideo(writerObj, F);
end

writerObj.close();
stop(vid);

end

