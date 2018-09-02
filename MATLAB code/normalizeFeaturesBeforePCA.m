path = 'D:/CSE 572 Data Mining/ProjectData';
featureDataAbout = [];
words = ["can","and", "about","cat", "cop", "cost", "day", "deaf", "decide", "father", "find", "gold", "goodnight", "goout", "hear", "hearing", "hospital", "if"];

for k=1:numel(words)
    finalData = [];
    count = 0;
    file{k} = strcat(path,'/',words{k},'_FeatureMatrix.csv');
    arrayT = readtable(file{k});
    arrayT = table2array(arrayT); 
    scaledData = [];
    for i = 1 : 16
        scaledData(:,[i]) = (arrayT(:,[i]) - min(arrayT(:,[i])))./(max(arrayT(:,[i])) - min(arrayT(:,[i])));
    end
    scaledData = array2table(scaledData);
    scaledData.Properties.VariableNames = {'Var_ALX' 'Var_ALY' 'Var_ALZ' 'Var_ARX' 'Var_ARY' 'Var_ARZ' 'RMS_EMGL' 'RMS_EMGR' 'FFT_GYL' 'FFT_GYR' 'STD_ORL' 'STD_OPL' 'STD_OYL' 'STD_ORR' 'STD_OPR' 'STD_OYR'};
    writetable(scaledData,strcat(words{k}, '_FeatureMatrix_Normalized.csv'));
end
% variance = var(arrayT);
% csvwrite('Var_Can.csv', variance);
