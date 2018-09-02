path1 = 'C:/Users/sgrover9/Downloads/DM-Project_P3/DM-Project/Matlab Code/Supporting Data/New Feature Matrix after PCA/cop_PCA.csv';
path2 = 'C:/Users/sgrover9/Downloads/DM-Project_P3/DM-Project/Matlab Code/Supporting Data/New Feature Matrix after PCA/';
strTemp = '_PCA.csv';
strTemp2 = '_UserCount.csv';
word = "cop";
gestures = ["and", "hearing","can", "goout", "about", "deaf", "decide", "father","find"];
str1 = 'cop_UserCount.csv';
finalData = [];
testData = [];
trainData = [];
userCount1 = readtable(str1);
featureMatrix1 = readtable(path1);
ht = height(userCount1);
trainHt = round(.7 * ht);
rowCount = 1;
for i=1:trainHt
    count = userCount1{i,2};
    trainRows = count;
%     testRows = count - trainRows;
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
%     if rowCount+testRows-1 > height(featureMatrix1)
%         tempTestData = featureMatrix1(rowCount:end,:);
%     else
%         tempTestData = featureMatrix1(rowCount:(rowCount+testRows-1),:);
%     end
%     newCol = ones([height(tempTestData) 1]);
%     newCol = array2table(newCol);
%     tempTestData = [newCol tempTestData];
%     if size(testData) == 0
%         testData = tempTestData;
%     else
%         testData = [testData;tempTestData];
%     end
%     rowCount = rowCount + testRows;
    
end
for i=trainHt:ht
    count = userCount1{i,2};
    testRows = count;
%     testRows = count - trainRows;
%     if rowCount+trainRows-1 > height(featureMatrix1)
%         tempTrainData = featureMatrix1(rowCount:end,:);
%     else
%         tempTrainData = featureMatrix1(rowCount:(rowCount+trainRows-1),:);
%     end
%     newCol = ones([height(tempTrainData) 1]);
%     newCol = array2table(newCol);
%     tempTrainData = [newCol tempTrainData];
%     if size(trainData) == 0
%         trainData = tempTrainData;
%     else
%         trainData = [trainData;tempTrainData];
%     end
%     rowCount = rowCount + trainRows;
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
    trainHt = round(.7 * ht);
    rowCount = 1;
    for i=1:trainHt
        count = userCount2{i,2};
        trainRows = count;
        testRows = count - trainRows;
         if rowCount+trainRows-1 > height(featureMatrix2)
            tempTrainData = featureMatrix2(rowCount:end,:);
            tempTrainData = table2array(tempTrainData);
            tempTrainData = mean(tempTrainData,1);
            tempTrainData = array2table(tempTrainData);
        else
            tempTrainData = featureMatrix2(rowCount:(rowCount+trainRows-1),:);
            tempTrainData = table2array(tempTrainData);
            tempTrainData = mean(tempTrainData,1);
            tempTrainData = array2table(tempTrainData);
        end
        newCol = zeros([height(tempTrainData) 1]);
        newCol = array2table(newCol);
        tempTrainData = [newCol tempTrainData];
        tempTrainData = table2array(tempTrainData);
        trainData = table2array(trainData);
        trainData = [trainData;tempTrainData];
        trainData = array2table(trainData);
        rowCount = rowCount + trainRows;
%         if rowCount+testRows-1 > height(featureMatrix2)
%             tempTestData = featureMatrix2(rowCount:end,:);
%         else
%             tempTestData = featureMatrix2(rowCount:(rowCount+testRows-1),:);
%         end
%         newCol = zeros([height(tempTestData) 1]);
%         newCol = array2table(newCol);
%         tempTestData = [newCol tempTestData];
%         testData = [testData;tempTestData];
%         rowCount = rowCount + testRows;

    end
    
    for i=trainHt+1:ht
        count = userCount2{i,2};
        testRows = count;
%         testRows = count - trainRows;
%          if rowCount+trainRows-1 > height(featureMatrix2)
%             tempTrainData = mean(featureMatrix2(rowCount:end,:));
%         else
%             tempTrainData = mean(featureMatrix2(rowCount:(rowCount+trainRows-1),:));
%         end
%         newCol = zeros([height(tempTrainData) 1]);
%         newCol = array2table(newCol);
%         tempTrainData = [newCol tempTrainData];
%         trainData = [trainData;tempTrainData];
%         rowCount = rowCount + trainRows;
        if rowCount+testRows-1 > height(featureMatrix2)
            tempTestData = featureMatrix2(rowCount:end,:);
            tempTestData = table2array(tempTestData);
            tempTestData = mean(tempTestData,1);
            tempTestData = array2table(tempTestData);
        else
            tempTestData = featureMatrix2(rowCount:(rowCount+testRows-1),:);
            tempTestData = table2array(tempTestData);
            tempTestData = mean(tempTestData,1);
            tempTestData = array2table(tempTestData);
        end
        newCol = zeros([height(tempTestData) 1]);
        newCol = array2table(newCol);
        tempTestData = [newCol tempTestData];
        tempTestData = table2array(tempTestData);
        testData = table2array(testData);
        testData = [testData;tempTestData];
        testData = array2table(testData);
        rowCount = rowCount + testRows;

    end
end

writetable(testData,strcat(word,'_TestData_P3.csv'));
writetable(trainData,strcat(word,'_TrainData_P3.csv'));

