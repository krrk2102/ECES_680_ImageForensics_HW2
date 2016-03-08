clear;

% Read the image. 
baboonImage = uint8(imread('baboon.tif'));

% Set configurations.
N = 1000;
alpha = 0.1;
key = 1;
% Embed water mark by spectrum. 
baboonWMK = spectrumWaterMark(baboonImage, key, N, alpha);
figure, imshow(baboonWMK);
% Calculate PSNR between original and marked image. 
baboonPSNR = getPSNR(baboonImage, baboonWMK);
% Extract water mark and get similarity score. 
baboonwaterSimilarity = extractSpectrumWaterMark(baboonWMK, ...
                                    baboonImage, N, alpha, key);

% Try 5 different random watermarks and observe similarity score.
similarityTests = zeros(1, 5);
for i = 1 : 5
    rng(key);
    % Original key, 1, is excluded. 
    key = randi([2, 2^30], 1, 1);
    similarityTests(i) = extractSpectrumWaterMark(baboonWMK, ...
                                        baboonImage, N, alpha, key);
end

% Perform JPEG compression and comparing to original watermark. 
key = 1;
imwrite(baboonWMK, 'baboonWMK90.jpg', 'jpg', 'Quality', 90);
baboonWMK90 = imread('baboonWMK90.jpg');
similarityTests90 = zeros(1, 6);
similarityTests90(1) = extractSpectrumWaterMark(baboonWMK90, ...
                                        baboonImage, N, alpha, key);
for i = 1 : 5
    rng(key);
    key = randi([2, 2^30], 1, 1);
    similarityTests90(i+1) = extractSpectrumWaterMark(baboonWMK90, ...
                                        baboonImage, N, alpha, key);
end
key = 1;
imwrite(baboonWMK, 'baboonWMK75.jpg', 'jpg', 'Quality', 75);
baboonWMK75 = imread('baboonWMK75.jpg');
similarityTests75 = zeros(1, 6);
similarityTests75(1) = extractSpectrumWaterMark(baboonWMK75, ...
                                        baboonImage, N, alpha, key);
for i = 1 : 5
    rng(key);
    key = randi([2, 2^30], 1, 1);
    similarityTests75(i+1) = extractSpectrumWaterMark(baboonWMK75, ...
                                        baboonImage, N, alpha, key);
end
key = 1;
imwrite(baboonWMK, 'baboonWMK50.jpg', 'jpg', 'Quality', 50);
baboonWMK50 = imread('baboonWMK50.jpg');
similarityTests50 = zeros(1, 6);
similarityTests50(1) = extractSpectrumWaterMark(baboonWMK50, ...
                                        baboonImage, N, alpha, key);
for i = 1 : 5
    rng(key);
    key = randi([2, 2^30], 1, 1);
    similarityTests50(i+1) = extractSpectrumWaterMark(baboonWMK50, ...
                                        baboonImage, N, alpha, key);
end

% Perform image smoothing and comparing to original watermark.
key = 1;
avgFilter = fspecial('average', 3);
baboonWMKAvg = imfilter(baboonWMK, avgFilter);
similarityTestsAvg = zeros(1, 6);
similarityTestsAvg(1) = extractSpectrumWaterMark(baboonWMKAvg, ...
                                        baboonImage, N, alpha, key);
for i = 1 : 5
    rng(key);
    key = randi([2, 2^30], 1, 1);
    similarityTestsAvg(i+1) = extractSpectrumWaterMark(baboonWMKAvg, ...
                                        baboonImage, N, alpha, key);
end
key = 1;
baboonWMKMed = medfilt2(baboonWMK, [3 3]);
similarityTestsMed = zeros(1, 6);
similarityTestsMed(1) = extractSpectrumWaterMark(baboonWMKMed, ...
                                        baboonImage, N, alpha, key);
for i = 1 : 5
    rng(key);
    key = randi([2, 2^30], 1, 1);
    similarityTestsMed(i+1) = extractSpectrumWaterMark(baboonWMKMed, ...
                                        baboonImage, N, alpha, key);
end

% Add noise to image and comparing to original watermark.
key = 1;
baboonWMKNoise1 = imnoise(baboonWMK, 'gaussian', 0, 1);
similarityTestsNoise1 = zeros(1, 6);
similarityTestsNoise1(1) = extractSpectrumWaterMark(baboonWMKNoise1, ...
                                        baboonImage, N, alpha, key);
for i = 1 : 5
    rng(key);
    key = randi([2, 2^30], 1, 1);
    similarityTestsNoise1(i+1) = extractSpectrumWaterMark(...
                            baboonWMKNoise1, baboonImage, N, alpha, key);
end
key = 1;
baboonWMKNoise5 = imnoise(baboonWMK, 'gaussian', 0, 5);
similarityTestsNoise5 = zeros(1, 6);
similarityTestsNoise5(1) = extractSpectrumWaterMark(baboonWMKNoise5, ...
                                        baboonImage, N, alpha, key);
for i = 1 : 5
    rng(key);
    key = randi([2, 2^30], 1, 1);
    similarityTestsNoise5(i+1) = extractSpectrumWaterMark(...
                            baboonWMKNoise5, baboonImage, N, alpha, key);
end
key = 1;
baboonWMKNoise10 = imnoise(baboonWMK, 'gaussian', 0, 10);
similarityTestsNoise10 = zeros(1, 6);
similarityTestsNoise10(1) = extractSpectrumWaterMark(baboonWMKNoise10, ...
                                        baboonImage, N, alpha, key);
for i = 1 : 5
    rng(key);
    key = randi([2, 2^30], 1, 1);
    similarityTestsNoise10(i+1) = extractSpectrumWaterMark(...
                            baboonWMKNoise10, baboonImage, N, alpha, key);
end

% Replace bottom half of the watermarked image with bottom half of 
% original image.
key = 1;
baboonWMKHalf = baboonWMK;
for i = floor(size(baboonWMK, 1)) + 1 : size(baboonWMK, 1)
    for j = 1 : size(baboonWMK, 2)
        baboonWMKHalf(i, j) = baboonImage(i, j);
    end
end
similarityTestsHalf = zeros(1, 6);
similarityTestsHalf(1) = extractSpectrumWaterMark(baboonWMKHalf, ...
                                        baboonImage, N, alpha, key);
for i = 1 : 5
    rng(key);
    key = randi([2, 2^30], 1, 1);
    similarityTestsHalf(i+1) = extractSpectrumWaterMark(...
                            baboonWMKHalf, baboonImage, N, alpha, key);
end

% Read marked image and reference image, and try 100 different keys
% to find the most fit key to this water mark. 
ssMarkedImage = uint8(imread('streamSSWmked.tiff'));
ssOriImage = uint8(imread('stream.tiff'));
maxSimilarity = -inf;
bestKey = 0;
for i = 1 : 100
    key = i;
    similarity = extractSpectrumWaterMark(ssMarkedImage, ...
                                        ssOriImage, N, alpha, key);
    if similarity > maxSimilarity
        maxSimilarity = similarity;
        bestKey = key;
    end
end
