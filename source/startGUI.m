% Script assumes the system is trained and ready to predict new data.

close all;

switch classifMethod
    case ClassifierType.KNN
        model = modelKNN;
    case ClassifierType.SVM
        model = svmArray;
    otherwise
        error('asd');
end

imaqmem(imaqmem('FrameMemoryLimit') * 10);

% Name of the video input file.
newInputName = 'D:\Gabor\Workspace\Third Year Project\new_video.avi';

figure('Name', 'My Custom Preview Window'); 
closeButton = uicontrol('Position', [20 20 40 20], 'String', 'Close', 'Callback', 'close(gcf)');
startButton = uicontrol('Position', [60 20 40 20], 'String', 'Start', 'Callback', 'recordVideo(webcamVideo, newInputName)');
predictButton  = uicontrol('Position', [100 20 40 20], 'String', 'Predict', 'Callback', 'predictNewData(newInputName, classifMethod, model)');

webcamVideo = videoinput('winvideo', 2, 'YUY2_640x480');
webcamVideo.TriggerRepeat = 2;

vidRes = webcamVideo.VideoResolution; 
nBands = webcamVideo.NumberOfBands; 
hImage = image(zeros(vidRes(2), vidRes(1), nBands));
preview(webcamVideo, hImage);

% videoName = recordVideo(webcamVideo, newInputName);

% error();

% stop(webcamVideo);