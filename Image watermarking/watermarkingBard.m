% Load the image and watermark
[imageData, imageMap] = imread('your-image~1.jpg');
[watermarkData, watermarkMap] = imread('watermark.png');

% Convert both images to grayscale if necessary
if size(imageData, 3) > 1
  imageData = rgb2gray(imageData);
end
if size(watermarkData, 3) > 1
  watermarkData = rgb2gray(watermarkData);
end

% Resize watermark to match image dimensions (optional)
watermarkData = imresize(watermarkData, size(imageData));

% Choose wavelet type and decomposition level
waveletType = 'haar';  % Options: 'haar', 'bior', 'coif', etc.
decompositionLevel = 2;  % Adjust for desired sensitivity and robustness

% Perform DWT on image and watermark
[imageCoeffs, imageLo, imageHi] = dwt2(imageData, waveletType, decompositionLevel);
[watermarkCoeffs, watermarkLo, watermarkHi] = dwt2(watermarkData, waveletType, decompositionLevel);

% Modify image coefficients to embed watermark
alpha = 0.3;  % Adjust for watermark visibility and imperceptibility
imageCoeffs(1:end-decompositionLevel, 1:end-decompositionLevel) = ...
    imageCoeffs(1:end-decompositionLevel, 1:end-decompositionLevel) + alpha * watermarkCoeffs(1:end-decompositionLevel, 1:end-decompositionLevel);

% Perform inverse DWT to obtain watermarked image
watermarkedImage = idwt2(imageCoeffs, imageLo, imageHi, waveletType);

% Save the watermarked image
imwrite(watermarkedImage, 'watermarked_image.jpg', imageMap);

% Show original, watermark, and watermarked images (optional)
figure, imshow(imageData, imageMap), title('Original Image');
figure, imshow(watermarkData, watermarkMap), title('Watermark Image');
figure, imshow(watermarkedImage, imageMap), title('Watermarked Image');

% PSNR and MSE calculations (optional)
psnrValue = psnr(imageData, watermarkedImage);
mseValue = immse(imageData, watermarkedImage);
fprintf('PSNR: %f, MSE: %f\n', psnrValue, mseValue);

disp('Watermark embedding completed!');
