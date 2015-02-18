%%% Main script for automatic human action recognition

% Global sort of parameters. Change to tweak testing script.
% Folder for getting videos.
INPUT_FOLDER = 'human_action_recognition\data\';
BOXING = 1;
HANDCLAPPING = 2;
HANDWAVING = 3;
JOGGING = 4;
RUNNING = 5;
WALKING = 6;

classDict = containers.Map;
classDict('boxing') = BOXING;
classDict('handclapping') = HANDCLAPPING;
classDict('handwaving') = HANDWAVING;

% Get each subfolder (will represent a class each).
subfolders = dir(INPUT_FOLDER);
trainingFiles = [];
trainingLabels = [];
testingFiles = [];
x = 0;

for i=3:length(subfolders)
    if (subfolders(i).isdir)
        files = dir(strcat(INPUT_FOLDER, subfolders(i).name));
        files = files(3:end);
        trainingSize = length(files) / 2;
        
        trainingFiles = [trainingFiles zeros(trainingSize, 1)];
        trainingLabels = [trainingLabels zeros(trainingSize, 1)];
        testingFiles = [testingFiles zeros(length(files) - trainingSize), 1];
        
        for j=(x+1):(x+trainingSize)
            trainingFiles(j) = files(j).name;
            trainingLabels(j) = classDict(files(i).name);
        end
        for j=(x+trainingSize+1):(x+length(files))
            testingFiles(j) = files(j).name;
        end
        
        x = x + length(files);
    end
end

