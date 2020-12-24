setosa = zeros(50, 1); 
versicolor = zeros(50, 1); 
for i = 1: length(d.label)/2
    if d.label(i) == "setosa" 
        setosa(i) = d.data1(i);
    end
    if d.label(i+50) == "versicolor"
        versicolor(i) = d.data1(i+50); 
    end
end

meanSetosa = mean(setosa); 
stdSetosa = std(setosa); 
meanVersicolor = mean(versicolor); 
stdVersicolor = std(versicolor); 

pdfSetosa = zeros(length(setosa), 1); 
for i = 1:length(setosa) 
    pdfSetosa(i) = (1 / (stdSetosa * sqrt(2 * pi))) * exp(-((i-meanSetosa)^2)/(2*stdSetosa^2)); 
end

pdfVersicolor = zeros(length(versicolor), 1); 
for i = 1:length(versicolor) 
    pdfVersicolor(i) = (1 / (stdVersicolor * sqrt(2 * pi))) * exp(-((i-meanVersicolor))^2/(2*stdVersicolor^2)); 
end

plot(setosa, pdfSetosa, 'Marker', 'o', 'LineStyle', 'none')
hold on
plot(versicolor, pdfVersicolor, 'Marker', 'o', 'LineStyle', 'none')
