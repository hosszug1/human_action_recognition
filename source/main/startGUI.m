%STARTGUI Script to start the GUI of the system.
%   Script assumes the system is trained and ready to predict new data.

close all;

switch classifMethod
    case ClassifierType.KNN
        model = modelKNN;
    case ClassifierType.SVM
        model = svmArray;
    otherwise
        error('asd');
end % switch

% Set the frame memory limit.
imaqmem(imaqmem('FrameMemoryLimit') * 10);
% Name of the video input file.
newInputName = 'D:\Gabor\Workspace\Third Year Project\human_action_recognition\new_video.avi';

% Create the figure controls and register the callbacks.
hFig = figure('Toolbar','none',...
    'Menubar', 'none',...
    'NumberTitle','Off',...
    'Name','Automatic Human Action Recognition GUI');
startButton = uicontrol('Position', [20 20 120 40],...
    'String', 'Start Recording',...
    'Callback', 'recordVideo(webcamVideo, newInputName)');
predictButton = uicontrol('Position', [140 20 120 40],...
    'String', 'Predict Action',...
    'Callback', 'predictNewData(newInputName, classifMethod, model, classesInUse)');
massRecordButton1 = uicontrol('Position', [20 100 180 40],...
    'String', 'Mass Record Boxing',...
    'Callback', 'massRecordVideo(webcamVideo, ActionType.Boxing)');
massRecordButton2 = uicontrol('Position', [20 140 180 40],...
    'String', 'Mass Record Handclapping',...
    'Callback', 'massRecordVideo(webcamVideo, ActionType.Handclapping)');
massRecordButton3 = uicontrol('Position', [20 180 180 40],...
    'String', 'Mass Record Handwaving',...
    'Callback', 'massRecordVideo(webcamVideo, ActionType.Handwaving)');
closeButton = uicontrol('Position', [860 20 120 40],...
    'String', 'Close',...
    'Callback', 'close(gcf)');

% Create the webcam handle.
try
    webcamVideo = videoinput('winvideo', 2, 'YUY2_640x480');
catch err
    webcamVideo = videoinput('winvideo', 1, 'YUY2_640x480');
end

% Set the size of the figure based on the resolution of the webcam.
vidRes = webcamVideo.VideoResolution; 
imWidth = vidRes(1);
imHeight = vidRes(1);
nBands = webcamVideo.NumberOfBands; 
hImage = image(zeros(imHeight, imWidth, nBands));
% Create the 'preview' window for the webcam.
preview(webcamVideo, hImage);
set(hFig, 'Position', [500 200 1000 850]);
