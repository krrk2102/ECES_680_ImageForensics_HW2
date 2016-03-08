function newImage = YMWaterMark(image, waterMark, key)
% Input:
%     image: original image waiting for water mark
%     waterMark: water mark image
%     key: the key to generate random look up table
% Return:
%     newImage: marked image

    % Seed the random number generator with the user specified key.
    rng(key);
    % Generate look up table values.
    LUTvals = rand(1, 256) > .5;
    % Convert water mark image into binary.
    waterMark = waterMark > .5;
    
    newImage = uint8(zeros(size(image)));
    
    for i = 1 : size(image, 1)
        for j = 1 : size(image, 2)
            % Comparing with look up table, if illuminance of water mark 
            % region matches look up table.
            if LUTvals(image(i, j)+1) == waterMark(i, j)
                newImage(i, j) = image(i, j);
            % If the water mark region doesn't match, find the matching 
            % nearest neighbor. 
            else
                newImage(i, j) = nearestNeighbor(LUTvals, ...
                                    image(i, j)+1, waterMark(i, j)) - 1;
            end
        end
    end

end

