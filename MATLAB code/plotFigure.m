path = 'D:/CSE 572 Data Mining/ProjectData';
liste = dir(path);
gestures ={liste.name};
header = ["ALX","ALY","ALZ","ARX","ARY","ARZ","EMG0L","EMG1L","EMG2L","EMG3L","EMG4L","EMG5L","EMG6L","EMG7L","EMG0R","EMG1R","EMG2R","EMG3R","EMG4R","EMG5R","EMG6R","EMG7R","GLX","GLY","GLZ","GRX","GRY","GRZ","ORL","OPL","OYL","ORR","OPR","OYR"];
words = ["can","and", "about","cat", "cop", "cost", "day", "deaf", "decide", "father", "find", "gold", "goodnight", "goout", "hear", "hearing", "hospital", "if"];
for k=1:numel(words)
    finalMatrix = [];
    file{k} = strcat(path,'/',strcat(words{k},'_PCA.csv'));
    featureMatrix = readtable(file{k});
    names = {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'F10', 'F11', 'F12', 'F13', 'F14', 'F15', 'F16'};
    featureMatrix = table2array(featureMatrix);
    f1 = figure('DefaultTextFontSize', 3);
    grid on;
    plot(featureMatrix);
%     axis([0 18 -1 4]);
    xlabel(strcat('Number of Instances of ',upper(words{k})));
    ylabel('Values');
    legend('show');
    leg = legend(names);
%     leg.FontSize(5);
    axis([0 600 -2 6]);
    title(upper(words{k}));
    saveas(f1, strcat(words{k}, '_LinePlot.jpeg'));
end