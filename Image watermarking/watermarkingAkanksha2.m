% Image Watermarking using DWT

% Load the original image
originalImage = imread('your-image~1.jpg'); % Replace 'your_image.jpg' with the filename of your image
figure; imshow(originalImage); title('Original Image');

% Load the watermark image (must be a binary image)
watermark = imread('watermark.png'); % Replace 'your_watermark.bmp' with the filename of your watermark
figure; imshow(watermark); title('Watermark');

% Perform DWT on the original image
level = 1; % Choose the level of decomposition
[LL, LH, HL, HH] = dwt2(originalImage, 'haar');

% Embed the watermark into the LL subband
LL_watermarked = LL + alpha * watermark;

% Reconstruct the watermarked image
watermarkedImage = idwt2(LL_watermarked, LH, HL, HH, 'haar');

% Display the watermarked image
figure; imshow(uint8(watermarkedImage)); title('Watermarked Image');

% Save the watermarked image
imwrite(uint8(watermarkedImage), 'watermarked_image.jpg'); % Replace 'watermarked_image.jpg' with the desired output filename
