% Load the original image
originalImage = imread('your-image~1.jpg');

% Load the embedded (watermarked) image
embeddedImage = imread('watermarked_image.jpg');

% Convert the images to double precision
originalImage = im2double(originalImage);
embeddedImage = im2double(embeddedImage);

% Extract RGB channels from both images
originalR = originalImage(:,:,1);
originalG = originalImage(:,:,2);
originalB = originalImage(:,:,3);

embeddedR = embeddedImage(:,:,1);
embeddedG = embeddedImage(:,:,2);
embeddedB = embeddedImage(:,:,3);

% Define the Haar wavelet transform
wavelet = 'db9';  % Change this to 'haar','dbN' or 'symN' where N is the Daubechies or Symlet level

% Apply the Haar wavelet transformation to each channel
[originalR_cA, originalR_cH, originalR_cV, originalR_cD] = dwt2(originalR, wavelet);
[originalG_cA, originalG_cH, originalG_cV, originalG_cD] = dwt2(originalG, wavelet);
[originalB_cA, originalB_cH, originalB_cV, originalB_cD] = dwt2(originalB, wavelet);

[embeddedR_cA, embeddedR_cH, embeddedR_cV, embeddedR_cD] = dwt2(embeddedR, wavelet);
[embeddedG_cA, embeddedG_cH, embeddedG_cV, embeddedG_cD] = dwt2(embeddedG, wavelet);
[embeddedB_cA, embeddedB_cH, embeddedB_cV, embeddedB_cD] = dwt2(embeddedB, wavelet);

% Calculate the Mean Squared Error (MSE) and Peak Signal-to-Noise Ratio (PSNR) for each channel
mseR = immse(originalR_cA, embeddedR_cA);
mseG = immse(originalG_cA, embeddedG_cA);
mseB = immse(originalB_cA, embeddedB_cA);

maxIntensity = 1.0;  % Assuming the images are in the [0, 1] range
psnrR = 10 * log10((maxIntensity^2) / mseR);
psnrG = 10 * log10((maxIntensity^2) / mseG);
psnrB = 10 * log10((maxIntensity^2) / mseB);

% Display or print the calculated values
fprintf('MSE (Red Channel): %f\n', mseR);
fprintf('PSNR (Red Channel): %f dB\n', psnrR);

fprintf('MSE (Green Channel): %f\n', mseG);
fprintf('PSNR (Green Channel): %f dB\n', psnrG);

fprintf('MSE (Blue Channel): %f\n', mseB);
fprintf('PSNR (Blue Channel): %f dB\n', psnrB);
