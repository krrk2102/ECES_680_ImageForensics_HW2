clear;
% Read 2 images.
pepperImage = uint8(imread('peppers.tif'));
baboonImage = uint8(imread('baboon.tif'));

% Get and show each bit plane of 2 images.
for i = 8 : -1 : 1
    pepperBitPlane = getBitPlane(pepperImage, i);
    figure, imshow(pepperBitPlane);
end
for i = 8 : -1 : 1
    baboonBitPlane = getBitPlane(baboonImage, i);
    figure, imshow(baboonBitPlane);
end

% Examine each bit plane of each LSBwmk file, to
% see which bit plane has hidden content. 
for i = 1 : 3
    wmkImage = uint8(imread(['LSBwmk' num2str(i) '.tiff']));
    for j = 8 : -1 : 1
        wmkBitPlane = getBitPlane(wmkImage, j);
        figure, imshow(wmkBitPlane);
    end
end

% Use my bit embedding function to hide top N layers of barbara image
% into least N significant bits of pepper and baboon image.
barImage = imread('Barbara.bmp');
for i = 1 : 8
    embeddedImage = embedBit(pepperImage, barImage, i);
    figure, imshow(embeddedImage);
end
for i = 1 : 8
    embeddedImage = embedBit(baboonImage, barImage, i);
    figure, imshow(embeddedImage);
end
