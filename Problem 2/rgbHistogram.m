function rgbHistogram()
   sourceImagePath = 'C:\Users\Daymon\Desktop\CSCI367\HW2\Problem2\Atlas-Mercury.png';
   targetImagePath = 'C:\Users\Daymon\Desktop\CSCI367\HW2\Problem2\techno-trousers.png';
   sourceImage = imread(sourceImagePath);
   targetImage = imread(targetImagePath);
   sourceImage = imresize(sourceImage, [size(targetImage, 1), size(targetImage, 2)]);
   matchedImage = customHistMatch(sourceImage, targetImage);
   
   % Display the images
   figure;
   subplot(1,3,1), imshow(sourceImage), title('Source Image');
   subplot(1,3,2), imshow(targetImage), title('Target Image');
   subplot(1,3,3), imshow(matchedImage), title('Matched Image');
   
   % Display histograms for source, target, and matched images
   displayHistograms(sourceImage, 'Source Image Histograms');
   displayHistograms(targetImage, 'Target Image Histograms');
   displayHistograms(matchedImage, 'Matched Image Histograms');
   
   % Calculate and display the MSE
   mseValue = calculateMSE(matchedImage, targetImage);
   disp(['MSE Value: ', num2str(mseValue)]);
end

function displayHistograms(image, figureTitle)
    % Calculate histograms for each channel
    redHist = imhist(image(:, :, 1));
    greenHist = imhist(image(:, :, 2));
    blueHist = imhist(image(:, :, 3));
    
    % Plot histograms
    figure('Name', figureTitle);
    subplot(3,1,1); bar(redHist, 'r'); title('Red Channel');
    subplot(3,1,2); bar(greenHist, 'g'); title('Green Channel');
    subplot(3,1,3); bar(blueHist, 'b'); title('Blue Channel');
end

function matchedImage = customHistMatch(sourceImage, targetImage)
   matchedImage = zeros(size(sourceImage), class(sourceImage));
   for channel = 1:3
       [sourceCDF, map] = histMatchMapping(sourceImage(:,:,channel), targetImage(:,:,channel));
       matchedImage(:,:,channel) = map(double(sourceImage(:,:,channel))+1);
   end
end

function [sourceCDF, map] = histMatchMapping(sourceChannel, targetChannel)
   sourceHist = imhist(sourceChannel);
   targetHist = imhist(targetChannel);
   sourceCDF = cumsum(sourceHist) / numel(sourceChannel);
   targetCDF = cumsum(targetHist) / numel(targetChannel);
   map = zeros(256,1,'uint8');
   for idx = 1:256
       [~, closest] = min(abs(sourceCDF(idx) - targetCDF));
       map(idx) = closest - 1;
   end
end

function hist = imhist(channel)
   hist = zeros(256,1);
   for pixelValue = 0:255
       hist(pixelValue+1) = sum(channel(:) == pixelValue);
   end
end

function mseValue = calculateMSE(image1, image2)
   if any(size(image1) ~= size(image2))
       error('Images must be of the same size.');
   end
   image1 = double(image1);
   image2 = double(image2);
   diffSquared = (image1 - image2).^2;
   mseValue = sum(diffSquared(:)) / numel(image1);
end
