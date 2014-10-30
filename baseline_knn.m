function baseline_knn

% Load left arm data
load('features_left_train')
load('labels_left_train')
load('features_left_test')
load('labels_left_test')

voteKNN_left = kNearestNeighbor(features_left_train, ... 
    labels_left_train, features_left_test, labels_left_test);

% Load right arm data
load('features_right_train')
load('labels_right_train')
load('features_right_test')
load('labels_right_test')

voteKNN_right = kNearestNeighbor(features_right_train, ...
    labels_right_train, features_right_test, labels_right_test);

end


function vote=kNearestNeighbor(featuresTrain, labelsTrain, featuresTest, labelsTest)
% Create the kNN classifier
knn = ClassificationKNN.fit(featuresTrain, labelsTrain,...
    'NumNeighbors',1,'BreakTies','nearest');

% Validation [NumNeighbours Prediction], 15% validation data
% valid = [1 0.;2 0.;3 0.; 4 0.; 5 0.;6 0.;7 0.;8 0.9433; 9 0.;10 0.]


% Test on remaining data
predictedLetter = knn.predict(featuresTest);
% Establish prediction overview 1 - 57 classes (classes are 32-57)
m = max(labelsTrain);
[n d] = size(featuresTest);
vote=zeros(n,m);
for i=1:n
    vote(i,predictedLetter(i))=1;
end
% Calc and Post correctness percentage
sum(predictedLetter==labelsTest)/n % Print % score
% Final baseline score: %

% Create Confusion Matrix
conf = confusionmat(labelsTest, predictedLetter);
% Normalizing to the amount of each test letter
nConfkNN = conf./(sum(conf,2)*ones(1,m));
save('nConfkNN','nConfkNN');
end