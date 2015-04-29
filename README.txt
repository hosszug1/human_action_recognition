Requirements:

1) Windows Machine with preferably windows 7/8 Operating System
2) Matlab R2012a (7.14.0.739) - preferably x64 bit (might work on slightly different versions as well)
3) Webcam connected to the computer


Installation instructions:

1) Unzip the "gabor_hosszu_project.zip" archive to a desired location.


Instructions to setting up the environment:

1) Launch Matlab
2) Change current working folder (top-left corner) to folder where the archive was extracted
3) Right-click on the "human_action_recognition" folder > Add to Path > Selected folders and subfolders.
3) Change current working folder (top-left corner) to the "human_action_recognition" folder.


Real-time recognition instructions:

In the Matlab command window:
	1) type "trainSystem" and press enter - wait for the training to finish (should only take a couple of seconds)
	2) type "startGUI" and press enter
	3) In the GUI window, press "Record Video" to record a new video sequence. The application
	will start recording about 8 seconds of video from the moment of pressing the button. First
	3 - 4 seconds will be discarded to give the person executing the action enough time to get
	into position.
	4) Once the recording is over, a message will be displayed in the command window.
	5) Press "Predict Action" and in a few seconds, the prediction will be displayed
	in the command window.

Parameters that can be changed in the "trainSystem" script:

1) loadFromFile (default = 1)
	- if 1, will load pre-existing features from ".mat" files to save time
	- if 0, will create new training and testing features for the system (average duration 20 minutes)


Feature Extraction testing instructions:

In the Matlab command window:
	1) type "testFeatureExtraction"

Parameters that can be changed in the "testFeatureExtraction" script:

1) featureMethod (default = FeatureVectorType.ConvMHI) - Recommended not to change
	- FeatureVectorType.MHI - Will generate the Motion History Image for an arbitrary video sequence
	- FeatureVectorType.MEI - Motion Energy Image
	- FeatureVectorType.ConvMHI - Edge-Strength Motion History Image (best results)
	- FeatureVectorType.Histogram - Histogram of the MHI

For additional information, matlab documentation has been created for the project, so type "help" followed by the name of
the function, class or script to see what it does!

There are some other experimental functions of the system, 
but they are in no way user-friendly as they are not meant to be used by anyone else besides me.
Extensive understanding of the implementation would be required to work with them.

For questions, e-mail gaborhosszu@yahoo.com!
