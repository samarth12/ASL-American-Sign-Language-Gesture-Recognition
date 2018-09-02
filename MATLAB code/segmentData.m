path1 = 'C:/Users/sgrover9/Downloads/DM-Project/Matlab Code/Supporting Data/New Feature Matrix after PCA/and_PCA.csv';
path2 = 'C:/Users/sgrover9/Downloads/DM-Project/Matlab Code/Supporting Data/New Feature Matrix after PCA/';
strTemp = '_PCA.csv';
strTemp2 = '_UserCount.csv';
word = "and";
gestures = ["hearing", "can","about", "cop", "deaf", "decide", "father", "find","goout"];
str1 = 'and_UserCount.csv';
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
    newCol = ones([height(tempTrainData) 1]);
    newCol = array2table(newCol);
    tempTrainData = [newCol tempTrainData];
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
    newCol = ones([height(tempTestData) 1]);
    newCol = array2table(newCol);
    tempTestData = [newCol tempTestData];
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
        newCol = zeros([height(tempTrainData) 1]);
        newCol = array2table(newCol);
        tempTrainData = [newCol tempTrainData];
        trainData = [trainData;tempTrainData];
        rowCount = rowCount + trainRows;
        if rowCount+testRows-1 > height(featureMatrix2)
            tempTestData = featureMatrix2(rowCount:end,:);
        else
            tempTestData = featureMatrix2(rowCount:(rowCount+testRows-1),:);
        end
        newCol = zeros([height(tempTestData) 1]);
        newCol = array2table(newCol);
        tempTestData = [newCol tempTestData];
        testData = [testData;tempTestData];
        rowCount = rowCount + testRows;

    end
end

writetable(testData,strcat(word,'_TestData.csv'));
writetable(trainData,strcat(word,'_TrainData.csv'));

