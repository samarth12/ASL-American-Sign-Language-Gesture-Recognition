path = 'D:/CSE 572 Data Mining/ProjectData/NormalizedData';
liste = dir(path);
gestures ={liste.name};
header = ["ALX","ALY","ALZ","ARX","ARY","ARZ","EMG0L","EMG1L","EMG2L","EMG3L","EMG4L","EMG5L","EMG6L","EMG7L","EMG0R","EMG1R","EMG2R","EMG3R","EMG4R","EMG5R","EMG6R","EMG7R","GLX","GLY","GLZ","GRX","GRY","GRZ","ORL","OPL","OYL","ORR","OPR","OYR"];
words = ["can","and", "about","cat", "cop", "cost", "day", "deaf", "decide", "father", "find", "gold", "goodnight", "goout", "hear", "hearing", "hospital", "if"];

for k=1:numel(words)
    finalMatrix = [];
    file{k} = strcat(path,'/',strcat(words{k},'Normalized.csv'));
    dataArray = readtable(file{k});
    ht = height(dataArray);
    dataArray = table2array(dataArray);
    accData = dataArray(:,1:6);
    emgLeft = dataArray(:, 7:14);
    emgRight = dataArray(:,15:22);
    gyrLeft = dataArray(:,[23]);
    gyrRight = dataArray(:,[26]);
    or = dataArray(:,29:34);
    j = 1;
    while j <= ht-44
        newMatrix = [];
        last = j + 44;
        varAcc = var(accData(j : last, :));
        emgL = mean(emgLeft(j : last, :), 2);
        emgL = rms(emgL);
        emgR = mean(emgRight(j : last, :), 2);
        emgR = rms(emgR);
        gyLeft = fftshift(gyrLeft(j : last, :));
        gyLeft = gyLeft(:) .^2;
        gyLeft = sum(gyLeft);
        gyRight = fftshift(gyrRight(j : last, :));
        gyRight = gyRight(:) .^2;
        gyRight = sum(gyRight);
        orient = std(or(j : last, :));
        newMatrix = [varAcc emgL emgR gyLeft gyRight orient];
        if(size(finalMatrix) == 0)
            finalMatrix = newMatrix;
        else
            finalMatrix = [finalMatrix; newMatrix];
        end
        j = last + 1;
    end
    finalTable = array2table(finalMatrix);
    finalTable.Properties.VariableNames = {'Var_ALX' 'Var_ALY' 'Var_ALZ' 'Var_ARX' 'Var_ARY' 'Var_ARZ' 'RMS_EMGL' 'RMS_EMGR' 'FFT_GYL' 'FFT_GYR' 'STD_ORL' 'STD_OPL' 'STD_OYL' 'STD_ORR' 'STD_OPR' 'STD_OYR'};
    writetable(finalTable,strcat(words{k}, '_FeatureMatrix.csv'));
end
% variance = var(arrayT);
% csvwrite('Var_Can.csv', variance);
