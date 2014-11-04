Human-activity-recognition
==========================


Sliding Window

-length = 64
-overlap = 50%

Current Data: All 30 sensors (10 x (x,y,z)) - raw data
Current features: Mean and Std Deviation for each sensor

Pre-processing of data set:
> Run generateProcessedData

Resulting .mat-files:
	- 	features(/labels)_all_proces.mat - complete dataset
	-	features(/labels)_train.mat - 80% training data
	-	features(/labels)_test.mat - 20% test data
	-	features(/labels)_validation.mat - 10% independent validation data
