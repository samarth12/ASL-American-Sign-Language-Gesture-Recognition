gestures = ["and", "hearing","can", "about", "cop", "deaf", "decide", "father","find","goout"];
confusionMatrix = [];
for i=1:10
    
trainData = readtable(strcat(gestures{i},'_TrainData_P3.csv'));
testData = readtable(strcat(gestures{i},'_TrainData_P3.csv'));
X = trainData(:,2:end);
Y = trainData(:,[1]);
X = table2array(X);
Y = table2array(Y);
userTestData = table2array(testData(:,2:end));
userTestLabel = table2array(testData(:,[1]));
SVMModel = fitcsvm(X,Y);
figure;
gscatter(X(:,1),X(:,2),Y);
%h = gca;
%lims =[h.XLim h.YLim];
%figure;
%mdf = fitctree(X,Y,'CrossVal','on');
%mdf = fitctree(X,Y);
%view(mdf,'Mode', 'graph');
%view(mdf.Trained{1},'Mode','graph');
[predicted_label, score] = predict(SVMModel, userTestData);

    confusion = confusionmat(userTestLabel ,predicted_label );

    precision = confusion(1,1) ./ (confusion(1,1)+confusion(2,1));

    recall = confusion(1,1) ./ (confusion(1,1)+confusion(1,2));

    disp(precision);

    disp(recall);

    F1 = (2*recall*precision) ./ (recall+precision);
    newconfusionMatrix = [precision recall F1];
    if size(confusionMatrix) == 0
        confusionMatrix = newconfusionMatrix;
    else
        confusionMatrix = [confusionMatrix;newconfusionMatrix];
    end
end
gestures = gestures.';
confusionMatrix = [gestures confusionMatrix];
confusionMatrix = array2table(confusionMatrix);
confusionMatrix.Properties.VariableNames = {'Gestures' 'Precision' 'Recall' 'F1'};
writetable(confusionMatrix,'SVM_ConfusionMatrix.csv');