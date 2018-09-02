path = 'D:/CSE 572 Data Mining/ProjectData/';
files = {"goout_FeatureMatrix.csv","find_FeatureMatrix.csv", "can_FeatureMatrix.csv"};
count = 1;
figure;
grid on;
hold on;
for j=1:1
    tempTB = readtable(strcat(path, files{j}));
    tempTB = tempTB(:,11 : 16);
%     tempTB = table2array(tempTB);
    tempTB.Properties.VariableNames = {'ORL' 'OPL' 'OYL' 'ORR' 'OPR' 'OYR'};
    temp = table2array(tempTB);
    hist(temp);
    legend('show');
    legend('ORL', 'OPL' ,'OYL' ,'ORR', 'OPR', 'OYR');
    title('GOOUT Histogram plot of STD of Orientation');
    %view(-45, 30);
end

% finalTB = array2table(finalTB);
% 
% finalTB.Properties.VariableNames = {'GyFFT'};
% 
% writetable(finalTB, 'AND_FFT.csv');