function winner = threeNNtest(dataSet, testData)

%finding normalized training data
x=dataSet.data1;
y=dataSet.data2;

x_mean=mean(x);
y_mean=mean(y);

x_std=std(x);
y_std=std(y);

x_norm=(x-x_mean)/x_std;
y_norm=(y-y_mean)/y_std;

%finding normalized test data
x_test=testData(1);
y_test=testData(2);

x_testNorm=(x_test-x_mean)/x_std;
y_testNorm=(y_test-y_mean)/y_std;

%finding distances between test data and all training data
distances=zeros(length(dataSet.data1));
for i=1:length(dataSet.data1)
    distances(i)=sqrt(((x_testNorm-x_norm(i))^2)+(y_testNorm-y_norm(i))^2);
end

%finding three closest data points
[~,sortIndices]=sort(distances);
point1=sortIndices(1);
point2=sortIndices(2);
point3=sortIndices(3);

%having neighbors vote
type1=string(dataSet.label(point1));
type2=string(dataSet.label(point2));
type3=string(dataSet.label(point3));


if type1==type2
    winner=dataSet.label(point1);
elseif type1==type3
    winner=dataSet.label(point1);
else
    winner=dataSet.label(point3);
end

%plotting dataset
x_firstType=[];
y_firstType=[];
x_secondType=[];
y_secondType=[];
for i=1:length(dataSet.data1)
    if string(dataSet.label(i)) == dataSet.name1
        x_firstType=[x_firstType,x_norm(i)];
        y_firstType=[y_firstType,y_norm(i)];
    else
        x_secondType=[x_secondType,x_norm(i)];
        y_secondType=[y_secondType,y_norm(i)];
    end
end

hold on
plot(x_firstType,y_firstType,'Marker','o','LineStyle','none','Color','b')
plot(x_secondType,y_secondType,'Marker','x','LineStyle','none','Color','r')

%plotting test data
plot(x_testNorm,y_testNorm,'Marker','*','LineStyle','none','Color','g');
plot([x_testNorm,x_norm(point1)],[y_testNorm,y_norm(point1)])
plot([x_testNorm,x_norm(point2)],[y_testNorm,y_norm(point2)])
plot([x_testNorm,x_norm(point3)],[y_testNorm,y_norm(point3)])
legend({string(dataSet.name1),string(dataSet.name2),'test data'}) 
end