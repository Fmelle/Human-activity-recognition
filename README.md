Human-activity-recognition
==========================


Sliding Window

- length = 64
- overlap = 50%

Current Data: 
* all - All 30 sensors (10 x (x,y,z)) - raw data
* left - Only left arm sensors
* right - Only right arm sensors
Current features for each sensors: 
* Mean 
* Std

Pre-processing of data set:
> Run generateProcessedData

Resulting .mat-files:
* _data_raw.mat (contains all extracted data from data set for left, right and combined)
* _data_procd.mat (contains the preprocessed result of the raw data)

Current baseline score:
* kNN (10-fold Cross-Validation):
Both:     0.941187418574353
Left:     0.920018365472911
Right:    0.907796917497734

* SVM:
Both:	  x
Left:     x
Right:    x

