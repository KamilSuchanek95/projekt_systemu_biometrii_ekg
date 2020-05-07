clc;
%% Tworzenie macierzy komorkowych
load('matlab_data\f r R load.mat');
numbers_of_persons = [1,2,9,36,52];
signals = {};
labels = {};
for person_number = 1:numel(numbers_of_persons)
    p = numbers_of_persons(person_number);
    per = sprintf('person_%i', p);
    % adding records to signals:
    for w = 1:size(f.(per), 2)
        signals{end+1, 1} = f.(per)(1:251, w)';
        labels{end+1, 1} = per;
    end
end % example output for [signals, labels]:
% 1937×2 cell array
% 
%     {1×251 double}    {'person_1' }
%     {1×251 double}    {'person_1' }
%     {1×251 double}    {'person_1' }
%      ...
clear per person_number numbers_of_persons w p
summary(categorical(labels))
% rozdzielenie na treningowy i testowy: sortowanie
per1X = signals(labels == "person_1");
per1Y =  labels(labels == "person_1");

per2X = signals(labels == "person_2");
per2Y =  labels(labels == "person_2");

per9X = signals(labels == "person_9");
per9Y =  labels(labels == "person_9");

per36X = signals(labels == "person_36");
per36Y =  labels(labels == "person_36");

per52X = signals(labels == "person_52");
per52Y =  labels(labels == "person_52");
% : losowe przyporzadkowanie do obu grup
clear XTrain1 XTrain2 XTrain9 XTrain36 XTrain52
clear YTrain1 YTrain2 YTrain9 YTrain36 YTrain52
[trainInd,~,testInd] = dividerand(size(per1X, 1),0.9,0.0,0.1);
XTrain1 = per1X(trainInd); YTrain1 = per1Y(trainInd);
XTest1  = per1X(testInd);  YTest1  = per1Y(testInd);

[trainInd,~,testInd] = dividerand(size(per2X, 1),0.9,0.0,0.1);
XTrain2 = per2X(trainInd); YTrain2 = per2Y(trainInd);
XTest2  = per2X(testInd);  YTest2  = per2Y(testInd);

[trainInd,~,testInd] = dividerand(size(per9X, 1),0.9,0.0,0.1);
XTrain9 = per9X(trainInd); YTrain9 = per9Y(trainInd);
XTest9  = per9X(testInd);  YTest9  = per9Y(testInd);

[trainInd,~,testInd] = dividerand(size(per36X, 1),0.9,0.0,0.1);
XTrain36 = per36X(trainInd); YTrain36 = per36Y(trainInd);
XTest36  = per36X(testInd);  YTest36  = per36Y(testInd);

[trainInd,~,testInd] = dividerand(size(per52X, 1),0.9,0.0,0.1);
XTrain52 = per52X(trainInd); YTrain52 = per52Y(trainInd);
XTest52  = per52X(testInd);  YTest52  = per52Y(testInd);
clear testInd trainInd
clear per1X per1Y per2X per2Y per9X per9Y per36X per36Y per52X per52Y
% max train = 531 max test = 59 Trzeba dopasowaæ rozmiary poprzez powielanie
XTrain1 = [XTrain1;XTrain1(1:85,:)];YTrain1 = [YTrain1;YTrain1(1:85,:)];
XTrain9 = [XTrain9;XTrain9(1:237,:)];YTrain9 = [YTrain9;YTrain9(1:237,:)];
XTrain36 = [XTrain36;XTrain36;XTrain36(1:163,:)];YTrain36 = [YTrain36;YTrain36;YTrain36(1:163,:)];
XTrain52 = [XTrain52;XTrain52(1:244,:)];YTrain52 = [YTrain52;YTrain52(1:244,:)];

XTest1 = [XTest1;XTest1(1:9,1)];YTest1 = [YTest1;YTest1(1:9,1)];
XTest9 = [XTest9;XTest9(1:26,1)]; YTest9 = [YTest9;YTest9(1:26,1)];
XTest36 = [XTest36;XTest36;XTest36(1:17,1)];YTest36 = [YTest36;YTest36;YTest36(1:17,1)];
XTest52 = [XTest52;XTest52(1:27,1)];YTest52 = [YTest52;YTest52(1:27,1)];

XTrain = [XTrain1;XTrain2;XTrain9;XTrain36;XTrain52];
YTrain = [YTrain1;YTrain2;YTrain9;YTrain36;YTrain52];
XTest = [XTest1;XTest2;XTest9;XTest36;XTest52];
YTest = [YTest1;YTest2;YTest9;YTest36;YTest52];
clear XTrain1 XTrain2 XTrain9 XTrain36 XTrain52
clear YTrain1 YTrain2 YTrain9 YTrain36 YTrain52
clear XTest1 XTest2 XTest9 XTest36 XTest52
clear YTest1 YTest2 YTest9 YTest36 YTest52
clear labels signals
%%  Create lstm nn
layers = [ ...
    sequenceInputLayer(1) % 1-D signal...
    bilstmLayer(100,'OutputMode','last')
    fullyConnectedLayer(5)
    softmaxLayer
    classificationLayer
    ];
%%
options = trainingOptions('adam', ...
    'MaxEpochs', 25, ...
    'MiniBatchSize', 2, ...
    'InitialLearnRate', 0.01, ...
    'SequenceLength', 251, ...
    'GradientThreshold', 1, ...
    'ExecutionEnvironment', 'gpu',...
    'plots', 'training-progress', ...
    'Verbose', true);
%  
clc;
net = trainNetwork(XTrain, categorical(YTrain), layers, options);

%%
trainPred = classify(net,XTrain,'SequenceLength',251);
%
LSTMAccuracy = sum(trainPred == YTrain)/numel(YTrain)*100
%
figure
confusionchart(categorical(YTrain),trainPred,'ColumnSummary','column-normalized','RowSummary','row-normalized','Title','Confusion Chart for LSTM');
%
testPred = classify(net,XTest,'SequenceLength',251);
LSTMAccuracy = sum(testPred == YTest)/numel(YTest)*100
figure
confusionchart(categorical(YTest),testPred,'ColumnSummary','column-normalized',...
              'RowSummary','row-normalized','Title','Confusion Chart for LSTM');


          