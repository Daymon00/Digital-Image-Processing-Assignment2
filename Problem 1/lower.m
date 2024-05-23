imagePath = 'C:\Users\MGSummer1\Desktop\MATLAB\HW2\LENNA.jpg';
I = imread(imagePath);
if size(I, 3) == 3
   I = rgb2gray(I);
end
I_low = I;
for k = [1, 2]
   I_low = bitand(I_low, bitcmp(2^(k-1), 'uint8'));
end
subplot(1,2,1);
imshow(I_low);
title('Lower-Order Bits Zeroed');
counts = hist(double(I_low(:)), 0:255);
subplot(1,2,2);
bar(0:255, counts, 'k');
xlim([0 255]);
title('Histogram with Lower Bits Zeroed');
xlabel('Intensity Value');
ylabel('Pixel Count');
