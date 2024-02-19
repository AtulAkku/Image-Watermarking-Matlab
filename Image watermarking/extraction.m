% Load the watermarked image
watermarked_image = imread('watermarked_image.jpg');

% If the image is not in grayscale, you can convert it to double
if size(watermarked_image, 3) == 3
    watermarked_image = im2double(rgb2gray(watermarked_image));
else
    watermarked_image = im2double(watermarked_image);
end

% Apply DWT to the watermarked image
[cA1, cH1, cV1, cD1] = dwt2(watermarked_image, 'haar');

% Extract the watermark from the LL subband
alpha = 0.5;
cA2_extracted = (cA1 - cA1) / alpha;

% Resize cA2_extracted to match the size of watermarked_image
%cA2_extracted_resized = imresize(cA2_extracted, size(watermarked_image));

% Ensure cA2_extracted_resized is of the same data type as watermarked_image
cA2_extracted = cast(cA2_extracted, class(watermarked_image));

% Extract the original image from the watermarked image
original_image_extracted = watermarked_image - alpha * cA2_extracted;

% Reconstruct the original image using IDWT
original_image_extracted = idwt2(original_image_extracted, cH1, cV1, cD1, 'haar', size(watermarked_image));

% Convert the original image to uint8
original_image_extracted = uint8(original_image_extracted * 255);

% Display the extracted original image and watermark image
figure;

subplot(1, 2, 1);
imshow(original_image_extracted);
title('Extracted Original Image');

subplot(1, 2, 2);
imshow(cA2_extracted_resized);
title('Extracted Watermark Image');
