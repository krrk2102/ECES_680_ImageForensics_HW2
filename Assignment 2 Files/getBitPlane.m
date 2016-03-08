function bitPlane = getBitPlane(image, n)
% Input:
%     image: original image with 8 bit planes.
%     n: the nth least significant bit to process.
% Return:
%     bitPlane: the corresponding bit plane of input image.

    bitPlane = uint8(zeros(size(image)));
    % Use this mask to filt unrelated bits. 
    mask = uint8(bitshift(1, n - 1));
    for i = 1 : size(image, 1)
        for j = 1 : size(image, 2);
            bitPlane(i, j) =  bitand(image(i, j), mask);
            % If this bit is set to 1, modify the pixel value to 255,
            % so that the output image could be easier for visual examine. 
            if bitPlane(i, j) > 0
                bitPlane(i, j) = 255;
            end
        end
    end

end

