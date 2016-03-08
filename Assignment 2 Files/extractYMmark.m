function waterMark = extractYMmark(markedImage, key)
% Input:
%     markedImage: the image contains water mark
%     key: the key to generate random look up table
% Return:
%     waterMark: extracted binary water mark

    % Seed the random number generator with the user specified key
    rng(key);
    % Generate look up table values
    LUTvals = rand(1, 256) > .5;
    waterMark = zeros(size(markedImage));
    
    for i = 1 : size(markedImage, 1)
        for j = 1 : size(markedImage, 2)
            % Get binary value by look up table. 
            waterMark(i, j) = LUTvals(markedImage(i, j) + 1);
        end
    end

end

