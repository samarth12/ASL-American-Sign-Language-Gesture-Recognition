path = 'D:/CSE 572 Data Mining/CSE572_A2_data/';
liste = dir(path);
folders ={liste.name};
header = ["ALX","ALY","ALZ","ARX","ARY","ARZ","EMG0L","EMG1L","EMG2L","EMG3L","EMG4L","EMG5L","EMG6L","EMG7L","EMG0R","EMG1R","EMG2R","EMG3R","EMG4R","EMG5R","EMG6R","EMG7R","GLX","GLY","GLZ","GRX","GRY","GRZ","ORL","OPL","OYL","ORR","OPR","OYR"];
featureDataAbout = [];
gestures = ["can","and", "about","cat", "cop", "cost", "day", "deaf", "decide", "father", "find", "gold", "goodnight", "goout", "hear", "hearing", "hospital", "if"];

for k=1:numel(gestures)
    finalData = [];
    count = 0;
    for i=4:40
        folder{i} = strcat(path,'/',folders{i});
        filesList = dir(folder{i});
        files = {filesList.name};
        for j=1:numel(files)
            if startsWith(lower(files{j}), gestures{k})   
                file{j} = strcat(path,'/',folders{i}, '/',files{j});
                try
                    dataArray = readtable(file{j});
                    ht = height(dataArray);
                    if(ht == 45)
                        count = count + 1;
                        scaledData = dataArray(:,1:34);
                        if size(finalData) == 0
                            finalData = scaledData;
                        else
                            finalData = [finalData;scaledData];
                        end
                    end
                catch
                end
            end
        end
    end
    X = sprintf("%s : %d", gestures{k}, count);
    disp(X);
    arrayT = table2array(finalData);
    scaledData = [];
    for i = 1 : 34
        scaledData(:,[i]) = (arrayT(:,[i]) - min(arrayT(:,[i])))./(max(arrayT(:,[i])) - min(arrayT(:,[i])));
    end
    scaledData = array2table(scaledData);
    scaledData.Properties.VariableNames = {'ALX' 'ALY' 'ALZ' 'ARX' 'ARY' 'ARZ' 'EMG0L' 'EMG1L' 'EMG2L' 'EMG3L' 'EMG4L' 'EMG5L' 'EMG6L' 'EMG7L' 'EMG0R' 'EMG1R' 'EMG2R' 'EMG3R' 'EMG4R' 'EMG5R' 'EMG6R' 'EMG7R' 'GLX' 'GLY' 'GLZ' 'GRX' 'GRY' 'GRZ' 'ORL' 'OPL' 'OYL' 'ORR' 'OPR' 'OYR'};
    writetable(scaledData,strcat(gestures{k}, 'Normalized.csv'));
end
% variance = var(arrayT);
% csvwrite('Var_Can.csv', variance);
