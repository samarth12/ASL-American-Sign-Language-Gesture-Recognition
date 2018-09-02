path = 'D:/CSE 572 Data Mining/ProjectData/Supporting Data/Old Feature Matrix Before PCA';
liste = dir(path);
gestures ={liste.name};
header = ["ALX","ALY","ALZ","ARX","ARY","ARZ","EMG0L","EMG1L","EMG2L","EMG3L","EMG4L","EMG5L","EMG6L","EMG7L","EMG0R","EMG1R","EMG2R","EMG3R","EMG4R","EMG5R","EMG6R","EMG7R","GLX","GLY","GLZ","GRX","GRY","GRZ","ORL","OPL","OYL","ORR","OPR","OYR"];
words = ["can","and", "about","cat", "cop", "cost", "day", "deaf", "decide", "father", "find", "gold", "goodnight", "goout", "hear", "hearing", "hospital", "if"];
for k=1:numel(words)
    finalMatrix = [];
    file{k} = strcat(path,'/',strcat(words{k},'_FeatureMatrix_Normalized.csv'));
    dataArray = readtable(file{k});
    dataArray = table2array(dataArray);
    [coeff, score, latent] = pca(dataArray);
    coeff = array2table(coeff);
    writetable(coeff, strcat(words{k}, '_PCA_Coefficients.csv'));
end