path2 = 'C:/Users/sgrover9/Downloads/DM-Project_P3/DM-Project/Matlab Code/';
gestures = ["and", "hearing","can", "about", "cop", "deaf", "decide", "father","find","goout"];
str1 = '_TestData_P3.csv';
str2 = '_TrainData_P3.csv';
for i=1:10
    newCol1 = [];
    newCol2 = [];
    word = gestures{i};
    testData = readtable(strcat(gestures{i},str1));
    trainData = readtable(strcat(gestures{i},str2));
    trainDataArray = table2array(trainData);
    testDataArray = table2array(testData);
    for j=1:height(testData)
        if testDataArray(j,1) == 1
            if size(newCol1) == 0
                newCol1 = [0];
            else
                temp = [0];
                newCol1 = [newCol1;temp];
            end
        else
            if size(newCol1) == 0
                newCol1 = [1];
            else
                temp = [1];
                newCol1 = [newCol1;temp];
            end
        end
    end
    for j=1:height(trainData)
        if trainDataArray(j,1) == 1
            if size(newCol2) == 0
                newCol2 = [0];
            else
                temp = [0];
                newCol2 = [newCol2;temp];
            end
        else
            if size(newCol2) == 0
                newCol2 = [1];
            else
                temp = [1];
                newCol2 = [newCol2;temp];
            end
        end
    end
    targetTestData = testData(:,1:1);
    newCol1 = array2table(newCol1);
    newCol2 = array2table(newCol2);
    targetTestData = [targetTestData newCol1];
    targetTrainData = trainData(:,1:1);
    targetTrainData = [targetTrainData newCol2];
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
    writetable(testData,strcat(word,'_InputTestDataNN_P3.csv'));
    writetable(trainData,strcat(word,'_InputTrainDataNN_P3.csv'));
    writetable(targetTestData,strcat(word,'_TargetTestDataNN_P3.csv'));
    writetable(targetTrainData,strcat(word,'_TargetTrainDataNN_P3.csv'));
end
