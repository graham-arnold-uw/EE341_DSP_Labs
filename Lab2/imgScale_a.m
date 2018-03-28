function thumb_a = imgScale_a(S, image)
imgSize = size(image);
row_start = S;
col_start = S;
thumb_index = 1;

thumb_a = zeros(floor(imgSize(1)/S), floor(imgSize(2)/S));

% for row = row_start:S:imgSize(1)
%     for col = col_start:S:imgSize(2)
%         sqr = image(row-(S-1):row, col-(col-1):col);
%         thumb_a = mean(sqr);
%     end
% end

for col = col_start:S:imgSize(2)
    for row = row_start:S:imgSize(1)
        sqr = image(row-(S-1):row, col-(S-1):col);
        thumb_a(thumb_index) = mean2(sqr);
        thumb_index = thumb_index + 1;
    end
end

end