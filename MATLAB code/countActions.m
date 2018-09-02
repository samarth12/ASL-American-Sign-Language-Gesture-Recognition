path = 'C:/Users/sgrover9/Downloads/Matlab Code/CSE572_A2_data/';
liste = dir(path);
folders ={liste.name};
header = ["ALX","ALY","ALZ","ARX","ARY","ARZ","EMG0L","EMG1L","EMG2L","EMG3L","EMG4L","EMG5L","EMG6L","EMG7L","EMG0R","EMG1R","EMG2R","EMG3R","EMG4R","EMG5R","EMG6R","EMG7R","GLX","GLY","GLZ","GRX","GRY","GRZ","ORL","OPL","OYL","ORR","OPR","OYR"];
featureDataAbout = [];
gestures = ["can","and", "about","cat", "cop", "cost", "day", "deaf", "decide", "father", "find", "gold", "goodnight", "goout", "hear", "hearing", "hospital", "if"];

for k=1:numel(gestures)
    finalData = [];
    for i=3:39
        folder{i} = strcat(path,folders{i});
        filesList = dir(folder{i});
        files = {filesList.name};
        count = 0;
        tempArray = [];
        for j=1:numel(files)  
            if startsWith(lower(files{j}), gestures{k})   
                file{j} = strcat(path,'/',folders{i}, '/',files{j});
                try
                    dataArray = readtable(file{j});
                    ht = height(dataArray);
%                     dataArray = table2array(dataArray);
                    if(ht == 45)
                        count = count + 1;
                    end
                catch
                end
            end
        end
       if count ~=0 
           tempArray = array2table(tempArray);
           tempArray{end+1,:} = {folders{i},count};
           if size(finalData) == 0
                finalData = tempArray;
            else
                finalData = [finalData; tempArray];
           end
       end
    end
    writetable(finalData,strcat(gestures{k}, '_UserCount.csv'));
end
% variance = var(arrayT);
% csvwrite('Var_Can.csv', variance);
