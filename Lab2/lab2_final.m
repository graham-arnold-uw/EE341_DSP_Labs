%Lab2 EE341
%Group members: Graham Arnold, Ting-Yu(Jacky) Wang
%Group member contribution: Each group member contributed equally to this
%script, the script was written collaboratively with both members working
%on the same task. However, part 5 is an individual work.

%% Part 1

% 5x5 smoother
hs = (1/25)*[1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1];

egg = (imread('egg_g.jpg'));
wanda = (imread('wanda_g.jpg'));

% convert to unsigned 8 bit int
egg_smooth = uint8(conv2(egg, hs, 'same'));
wanda_smooth = uint8(conv2(wanda, hs, 'same'));

% imshow(uint8(egg));
% imshow(egg_smooth);
% imshow(wanda_smooth);
% imwrite(wanda_smooth, 'wanda_smooth.jpg');
% imwrite(egg_smooth, 'egg_smooth.jpg');

% Sobel vertical edge detection convolution kernel
h1 = [-1 0 1; -2 0 2; -1 0 1];

%  Sobel horizontal edge detection convolution kernel
h2 = [1 2 1; 0 0 0; -1 -2 -1];

egg = double(egg);
wanda = double(wanda);

%  row gradient of the grayscale image
M1 = conv2(egg, h1, 'same');

%  column gradient of the grayscale image
M2 = conv2(egg, h2, 'same');

row_gradient = uint8(abs(M1));
column_gradient = uint8(abs(M2));
overall_gradient = uint8((M1.^2 + M2.^2).^0.5);

% imshow(row_gradient);
% imwrite(row_gradient, 'row_grad.jpg');
% 
% imshow(column_gradient);
% imwrite(column_gradient, 'col_grad.jpg');
% 
% imshow(overall_gradient);
% imwrite(overall_gradient, 'all_grad.jpg');

% reversed egg
% eggdge_reverse = 255 .* ones(501, 401) - double(overall_gradient);

% imshow(uint8(eggdge_reverse));
% imwrite(eggdge_reverse, 'eggdge_reverse.jpg');

%% Part 2

% image scaling function imgScale - Simple

thumb = imgScale(10, wanda);
thumb_s = size(thumb);

if (thumb_s(2) < 100)
    col = thumb_s(2);
else
    col = 100;
end

if (thumb_s(1) < 100)
    row = thumb_s(1);
else
    row = 100;
end

thumbnail = thumb(1:row, 1:col);

% imshow(uint8(egg));

% imshow(uint8(thumbnail));

% image scaling function imgScale_a - Advanced

thumb_a = imgScale_a(10, wanda);
% imshow(uint8(thumb_a));

%% Part 3

% (i)
egg_ud = flipud(egg);
%imshow(uint8(egg_ud));

% (ii)
egg_lr = fliplr(egg);
% imshow(uint8(egg_lr));

% (iii)
egg_udlr = rot90(egg, 2);
% imshow(uint8(egg_udlr));


%% Part 4

% imshow(uint8(egg));


% sample doubling 
egg_s = size(egg);

egg_double_row = [];
egg_doubled = [];

for rows = 1:1:egg_s(1)
    egg_double_row = vertcat(egg_double_row, egg(rows, :), egg(rows, :));
end

for col = 1:1:egg_s(2)
    egg_doubled = horzcat(egg_doubled, egg_double_row(:, col), egg_double_row(:, col));
end

% imshow(uint8(egg_doubled));
% imwrite(uint8(egg_doubled), 'egg_doubled.jpg');


% two tap linear interpolation
egg_doubled_interp = imgInterp(wanda);

% imshow(uint8(egg_doubled_interp));
% imwrite(uint8(egg_doubled_interp), 'egg_doubled_interp.jpg');


%% Part 5

hummingbird_img = (imread('hummingbird.jpg'));
hummingbird_bw = rgb2gray(hummingbird_img);

hummingbird = imgScale_a(2, hummingbird_bw);
 imwrite(uint8(hummingbird), 'hummingbird_orgin.jpg');


% 1 apply edge detection + reversion
hummingbird = double(hummingbird);

% row gradient of darth
row = conv2(hummingbird, h1, 'same');

% col gradient of darth
col = conv2(hummingbird, h2, 'same');

% overall gradient of darth
hummingbird_row = uint8(abs(row));
hummingbird_col = uint8(abs(col));

hummingbird_edge = uint8((row.^2 + col.^2).^0.5);

% reversed version
hummingbird_edge_rev = 255 .* ones(217, 300) - double(hummingbird_edge);
 imwrite(uint8(hummingbird_edge_rev), 'hummingbird_edge_rev.jpg');

% 2 up down left right flip
hummingbird_flip = fliplr(hummingbird_edge);
 imwrite(uint8(hummingbird_flip), 'hummingbird_flip.jpg');

% 3 up scaling with sample doubling
hummingbird_s = size(hummingbird);

hummingbird_double_row = [];
hummingbird_big = [];

for rows = 1:1:hummingbird_s(1)
    hummingbird_double_row = vertcat(hummingbird_double_row, hummingbird(rows, :), hummingbird(rows, :));
end

for col = 1:1:hummingbird_s(2)
    hummingbird_big = horzcat(hummingbird_big, hummingbird_double_row(:, col), hummingbird_double_row(:, col));
end

 imwrite(uint8(hummingbird_big), 'hummingbird_big.jpg');

% combine all three versions of image
hummingbird2 = horzcat(hummingbird_flip, hummingbird_edge_rev);
hummingbirdfinal = vertcat(hummingbird2, hummingbird_big);
 imshow(uint8(hummingbirdfinal));
 imwrite(hummingbirdfinal, 'hummingbirdfinal.jpg');