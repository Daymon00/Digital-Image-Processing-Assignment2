img = imread('LENNA.JPG');
if size(img, 3) == 3
    img = rgb2gray(img);
end

avgFilter = (1/9) * ones(3, 3);

lapFilter = [0 -1 0; -1 4 -1; 0 -1 0];
smoothed = applyFilterManual(img, avgFilter);
avgLap = applyFilterManual(smoothed, lapFilter);

enhanced = applyFilterManual(img, lapFilter);
lapAvg = applyFilterManual(enhanced, avgFilter);

figure, imshow(img), title('Original Image');
figure, imshow(avgLap), title('Averaging then Laplacian');
figure, imshow(lapAvg), title('Laplacian then Averaging');

function output = applyFilterManual(img, filter)
    [rows, cols] = size(img);
    [fRows, fCols] = size(filter);
    output = zeros(rows, cols, 'like', img);
    padRow = floor(fRows / 2);
    padCol = floor(fCols / 2);
    
    for i = (1+padRow):(rows-padRow)
        for j = (1+padCol):(cols-padCol)
            segment = double(img((i-padRow):(i+padRow), (j-padCol):(j+padCol)));
            filteredValue = sum(sum(segment .* filter));
            output(i, j) = filteredValue;
        end
    end
   
    if isinteger(img)
        output = uint8(output);
    end
end
