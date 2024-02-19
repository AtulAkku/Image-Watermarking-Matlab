% Load the host image (the image you want to watermark)
hostImage = imread('your-image~1.jpg');

% Load the watermark image (grayscale)
watermark = imread('watermark.png');

% Resize the watermark to match the host image dimensions
watermark = imresize(watermark, [size(hostImage, 1), size(hostImage, 2)]);

% Convert the host image to double precision for DCT
hostImage = im2double(hostImage);

% Split the host image into its color channels
R = hostImage(:,:,1);
G = hostImage(:,:,2);
B = hostImage(:,:,3);

% Perform DCT on each color channel
dctR = dct2(R);
dctG = dct2(G);
dctB = dct2(B);

% Embed the watermark in the DCT coefficients of each channel
alpha = 0.01; % Watermark strength
dctR = dctR + alpha * dct2(watermark);
dctG = dctG + alpha * dct2(watermark);
dctB = dctB + alpha * dct2(watermark);

% Inverse DCT to obtain the watermarked image for each channel
watermarkedR = idct2(dctR);
watermarkedG = idct2(dctG);
watermarkedB = idct2(dctB);

% Combine the color channels to get the watermarked image
watermarkedImage = cat(3, watermarkedR, watermarkedG, watermarkedB);

% Display the watermarked image
imshow(watermarkedImage);

% Save the watermarked image
imwrite(watermarkedImage, 'watermarked_image.jpg');

% To extract the watermark later (assuming you have the original host image):
% Split the watermarked image into its color channels
watermarkedR = watermarkedImage(:,:,1);
watermarkedG = watermarkedImage(:,:,2);
watermarkedB = watermarkedImage(:,:,3);

% Perform DCT on each color channel of the watermarked image
dctWatermarkedR = dct2(watermarkedR);
dctWatermarkedG = dct2(watermarkedG);
dctWatermarkedB = dct2(watermarkedB);

% Extract the watermark from each channel
extractedWatermark = (dctWatermarkedR - dctR) / alpha;  % You can use any of the channels for extraction

% Display or save the extracted watermark as needed
imshow(extractedWatermark, []);
imwrite(extractedWatermark, 'extracted_watermark.png');
