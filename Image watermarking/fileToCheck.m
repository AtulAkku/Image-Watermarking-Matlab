% Read the original image
originalImage = imread('your-image~1.jpg');

% Convert the image to grayscale if it's in color
if size(originalImage, 3) == 3
    originalImage = rgb2gray(originalImage);
end

% Display the original image
figure;
imshow(originalImage);
title('Original Image');

% Load the watermark image
watermarkImage = imread('watermark.png');

% Convert the watermark image to grayscale if it's in color
if size(watermarkImage, 3) == 3
    watermarkImage = rgb2gray(watermarkImage);
end

% Display the watermark image
figure;
imshow(watermarkImage);
title('Watermark Image');

% Apply DWT to the original image
wavelet = 'db1'; % You can choose a different wavelet
level = 2;       % Set the number of decomposition levels

[C, S] = wavedec2(originalImage, level, wavelet);

% Extract the approximation and detail coefficients
print(detcoef2('all', C, S, level));