function [winner] = nearestNeighbor(dataSet, testData)
x = dataSet.data1; 
y = dataSet.data2; 
xMean = mean(x); 
yMean = mean(y); 
xStd = std(x); 
yStd = std(y); 
xNorm = (x - xMean)/ xStd; 
yNorm = (y - yMean)/ yStd; 
xTest = testData(1); 
yTest = testData(2); 
xTestNorm = (xTest - xMean)/ xStd;
yTestNorm = (yTest - yMean)/ yStd; 

euclidDist = zeros(length(dataSet.data1));
for i = 1:length(dataSet.data1)
    euclidDist(i) = sqrt(((xTestNorm-xNorm(i))^2)+(yTestNorm-yNorm(i))^2);
end
[~,sortedIndices] = sort(euclidDist); 
p1 = sortedIndices(1); 
p2 = sortedIndices(2); 
p3 = sortedIndices(3); 

vote1=string(dataSet.label(p1));
vote2=string(dataSet.label(p2));
vote3=string(dataSet.label(p3));

if vote1==vote2
    winner=dataSet.label(p1);
elseif vote1==vote3
    winner=dataSet.label(p1);
else
    winner=dataSet.label(p3);
end

%plotting dataset
xFirstType=[];
yFirstType=[];
xSecondType=[];
ySecondType=[];
for i=1:length(dataSet.data1)
    if string(dataSet.label(i)) == dataSet.name1
        xFirstType=[xFirstType,xNorm(i)];
        yFirstType=[yFirstType,yNorm(i)];
    else
        xSecondType=[xSecondType,xNorm(i)];
        ySecondType=[ySecondType,yNorm(i)];
    end
end

hold on
plot(xFirstType,yFirstType,'Marker','o','LineStyle','none','Color','b')
plot(xSecondType,ySecondType,'Marker','x','LineStyle','none','Color','r')

%plotting test data
plot(xTestNorm,yTestNorm,'Marker','*','LineStyle','none','Color','g');
plot([xTestNorm,xNorm(p1)],[yTestNorm,yNorm(p1)], 'Color', 'k')
plot([xTestNorm,xNorm(p2)],[yTestNorm,yNorm(p2)], 'Color', 'k')
plot([xTestNorm,xNorm(p3)],[yTestNorm,yNorm(p3)], 'Color', 'k')
legend({string(dataSet.name1),string(dataSet.name2),'test data', 'Nearest Neighbor'}) 
end
