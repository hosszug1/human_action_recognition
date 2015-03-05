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

% Set the frame memory limit.
imaqmem(imaqmem('FrameMemoryLimit') * 10);

% Name of the video input file.
newInputName = 'D:\Gabor\Workspace\Third Year Project\human_action_recognition\new_video.avi';

hFig = figure('Toolbar','none',...
    'Menubar', 'none',...
    'NumberTitle','Off',...
    'Name','Automatic Human Action Recognition GUI');
closeButton = uicontrol('Position', [20 20 80 40],...
    'String', 'Close',...
    'Callback', 'close(gcf)');
startButton = uicontrol('Position', [100 20 80 40],...
    'String', 'Start',...
    'Callback', 'recordVideo(webcamVideo, newInputName)');
% predictionText = uicontrol('Position', [300 20 320 40],...
%     'style', 'text');
predictButton  = uicontrol('Position', [180 20 80 40],...
    'String', 'Predict',...
    'Callback', 'predictNewData(newInputName, classifMethod, model, classesInUse)');

% Create the text label for the timestamp
% hTextLabel = uicontrol('style','text','String','Timestamp', ...
%     'Units','normalized',...
%     'Position',[0.85 -.04 .15 .08]);

% webcamVideo.TriggerRepeat = 2;

webcamVideo = videoinput('winvideo', 2, 'YUY2_640x480');

vidRes = webcamVideo.VideoResolution; 
imWidth = vidRes(1);
imHeight = vidRes(1);
nBands = webcamVideo.NumberOfBands; 
hImage = image(zeros(imHeight, imWidth, nBands));
preview(webcamVideo, hImage);

% Enlarge figure to full screen.
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

% Specify the size of the axes that contains the image object
% so that it displays the image at the right resolution and
% centers it in the figure window.
% figSize = get(hFig,'Position');
% figWidth = figSize(3);
% figHeight = figSize(4);
% gca.unit = 'pixels' ,...
%     'position',[ ((figWidth - imWidth)/2)... 
%                  ((figHeight - imHeight)/2)...
%                    imWidth imHeight ]);
               
% Make handle to text label available to update function.
% setappdata(hImage, 'HandleToTimestampLabel', hTextLabel);

% Turn on the live video.
% webcamVideo = videoinput('winvideo', 2, 'YUY2_640x480');
% preview(webcamVideo, hImage);
% hold on
% thisBB = [28.5 27.5 311 381];
% rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)], 'EdgeColor','r','LineWidth',2 )

% preview(webcamVideo, hImage);