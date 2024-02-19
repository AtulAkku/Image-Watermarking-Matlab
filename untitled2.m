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

% Define the wavelet transform to use (Haar, Daubechies, and Symlet)
wavelet = 'haar';  % Change this to 'dbN' or 'symN' where N is the Daubechies or Symlet level

% Calculate the Mean Squared Error (MSE) and Peak Signal-to-Noise Ratio (PSNR) for each channel
mseR = immse(originalR, embeddedR);
mseG = immse(originalG, embeddedG);
mseB = immse(originalB, embeddedB);

maxIntensity = 1.0;  % Assuming the images are in the [0, 1] range

psnrR = psnr(embeddedR, originalR, maxIntensity);
psnrG = psnr(embeddedG, originalG, maxIntensity);
psnrB = psnr(embeddedB, originalB, maxIntensity);

% Display or print the calculated values
fprintf('MSE (Red Channel): %f\n', mseR);
fprintf('PSNR (Red Channel): %f dB\n', psnrR);

fprintf('MSE (Green Channel): %f\n', mseG);
fprintf('PSNR (Green Channel): %f dB\n', psnrG);

fprintf('MSE (Blue Channel): %f\n', mseB);
fprintf('PSNR (Blue Channel): %f dB\n', psnrB);
