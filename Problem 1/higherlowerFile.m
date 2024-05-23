imagePath = 'C:\Users\MGSummer1\Desktop\MATLAB\HW2\LENNA.jpg';
I = imread(imagePath);
if size(I, 3) == 3
   I = rgb2gray(I);
end
I_low = I;
for k = [1, 2]
   I_low = bitand(I_low, bitcmp(2^(k-1), 'uint8'));
end
I_high = I;
for k = [7, 8]
   I_high = bitand(I_high, bitcmp(2^(k-1), 'uint8'));
end
figure;
subplot(3,2,1);
imshow(I);
title('Original');
subplot(3,2,2);
counts_original = hist(double(I(:)), 0:255);
bar(0:255, counts_original, 'k');
xlim([0 255]);
title('Original');
subplot(3,2,3);
imshow(I_low);
title('Lower Order Bits Zeroed');
subplot(3,2,4);
counts_low = hist(double(I_low(:)), 0:255);
bar(0:255, counts_low, 'k');
xlim([0 255]);
title('Lower Bits Zeroed Histogram');
subplot(3,2,5);
imshow(I_high);
title('Higher Order Bits Zeroed');
subplot(3,2,6);
counts_high = hist(double(I_high(:)), 0:255);
bar(0:255, counts_high, 'k');
xlim([0 255]);
title('Higher Bits Zeroed Histogram');
