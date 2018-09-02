path1 = 'C:/Users/sgrover9/Downloads/DM-Project/Matlab Code/Supporting Data/New Feature Matrix after PCA/hearing_PCA.csv';
path2 = 'C:/Users/sgrover9/Downloads/DM-Project/Matlab Code/Supporting Data/New Feature Matrix after PCA/';
strTemp = '_PCA.csv';
strTemp2 = '_UserCount.csv';
word = "hearing";
gestures = ["and", "can","about", "cop", "deaf", "decide", "father", "find","goout"];
str1 = 'hearing_UserCount.csv';
finalData = [];
testData = [];
trainData = [];
userCount1 = readtable(str1);
featureMatrix1 = readtable(path1);
ht = height(userCount1);
rowCount = 1;
for i=1:ht
    count = userCount1{i,2};
    trainRows = round(.7 * count);
    testRows = count - trainRows;
    if rowCount+trainRows-1 > height(featureMatrix1)
        tempTrainData = featureMatrix1(rowCount:end,:);
    else
        tempTrainData = featureMatrix1(rowCount:(rowCount+trainRows-1),:);
    end
    lable1 = ones([height(tempTrainData) 1]);
    lable1 = array2table(lable1);
    lable2 = zeros([height(tempTrainData) 1]);
    lable2 = array2table(lable2);
    tempTrainData = [lable1 lable2 tempTrainData];
    if size(trainData) == 0
        trainData = tempTrainData;
    else
        trainData = [trainData;tempTrainData];
    end
    rowCount = rowCount + trainRows;
    if rowCount+testRows-1 > height(featureMatrix1)
        tempTestData = featureMatrix1(rowCount:end,:);
    else
        tempTestData = featureMatrix1(rowCount:(rowCount+testRows-1),:);
    end
    lable1 = ones([height(tempTestData) 1]);
    lable1 = array2table(lable1);
    lable2 = zeros([height(tempTestData) 1]);
    lable2 = array2table(lable2);
    tempTestData = [lable1  lable2 tempTestData];
    if size(testData) == 0
        testData = tempTestData;
    else
        testData = [testData;tempTestData];
    end
    rowCount = rowCount + testRows;
    
end
for k=1:numel(gestures)
    userCount2 = readtable(strcat(gestures{k},strTemp2));
    featureMatrix2 = readtable(strcat(path2,gestures{k},strTemp));
    ht = height(userCount2);
    rowCount = 1;
for i=1:ht
    count = userCount2{i,2};
    trainRows = round(.7 * count);
    testRows = count - trainRows;
     if rowCount+trainRows-1 > height(featureMatrix2)
        tempTrainData = featureMatrix2(rowCount:end,:);
    else
        tempTrainData = featureMatrix2(rowCount:(rowCount+trainRows-1),:);
    end
    lable1 = zeros([height(tempTrainData) 1]);
    lable1 = array2table(lable1);
    lable2 = ones([height(tempTrainData) 1]);
    lable2 = array2table(lable2);
    tempTrainData = [lable1 lable2 tempTrainData];
    trainData = [trainData;tempTrainData];
    rowCount = rowCount + trainRows;
    if rowCount+testRows-1 > height(featureMatrix2)
        tempTestData = featureMatrix2(rowCount:end,:);
    else
        tempTestData = featureMatrix2(rowCount:(rowCount+testRows-1),:);
    end
    lable1 = zeros([height(tempTestData) 1]);
    lable1 = array2table(lable1);
    lable2 = ones([height(tempTestData) 1]);
    lable2 = array2table(lable2);
    tempTestData = [lable1 lable2 tempTestData];
    testData = [testData;tempTestData];
    rowCount = rowCount + testRows;
    
end
end

targetTestData = testData(:,1:2);
targetTrainData = trainData(:,1:2);
testData = testData(:,3:end);
trainData = trainData(:,3:end);
testData = table2array(testData);
testData = array2table(testData.');
trainData = table2array(trainData);
trainData = array2table(trainData.');
targetTestData = table2array(targetTestData);
targetTestData = array2table(targetTestData.');
targetTrainData = table2array(targetTrainData);
targetTrainData = array2table(targetTrainData.');
writetable(testData,strcat(word,'_InputTestDataNN.csv'));
writetable(trainData,strcat(word,'_InputTrainDataNN.csv'));
writetable(targetTestData,strcat(word,'_TargetTestDataNN.csv'));
writetable(targetTrainData,strcat(word,'_TargetTrainDataNN.csv'));

