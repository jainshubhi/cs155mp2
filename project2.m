%% CS 155 Project 2
% Dylan Schultz, Shubi Jain, Ritvik Mishra

%% Open the data file.
file_data = fopen('./miniproject2_data/data.txt');
formatSpec = '%d\t%d\t%d';
data = cell2mat(textscan(file_data, formatSpec));

%% Part 1: Finding Y = UV'
%% Create Y
% Find the number of users.
users = max(data(:,1));
% Find the number of movies.
movies = max(data(:,2));
% Initialze Y to all zeros.
Y = zeros(users, movies);
% Loop through the data set.
for i = 1:length(data)
    % The mth row is a user
    m = data(i, 1);
    % The nth column is a movie.
    n = data(i, 2);
    % This the the mth user's rating of the nth movie.
    Y(m, n) = data(i, 3);
end

%% Choose a number of latent factors.
k = 20;

%% Choose a value of lambda.
lambda = .1;

%% Initialize U and V randomly
U = rand(users, k);
V = rand(movies, k);

%% Optimize U and V using ALS
next_U = new_U(Y, V, lambda);
n = norm((U-next_U), 'fro');
while n > 1.1
    U = next_U;
    V = new_V(Y, U, lambda);
    next_U = new_U(Y, V, lambda);
    n = norm((U-next_U), 'fro')
end

U = next_U;
V = new_V(Y, U, lambda);

%% Part 2: Projecting U and V onto 2 dimensions.
% Mean center both U and V so all rows have a mean of 0.
% for i = 1:users
%     U(i, :) = U(i, :) - mean(U(i,:));
% end
% for i = 1:movies
%     V(i, :) = V(i, :) - mean(V(i,:));
% end

%% Compute the SVD of both U and V.
[Au, Su, Bu] = svd(U, 'econ');
[Av, Sv, Bv] = svd(V, 'econ');

%% Reduce U and V to highest 2 dimensions.
U2d = Au(1:2, :)*U';
V2d = Av(1:2, :)*V';

%% Part 3: Visualization
file_genres = fopen('./miniproject2_data/movies_wotxt.txt');
formatSpec = '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d';
genres = cell2mat(textscan(file_genres, formatSpec));

%% Genre Plot
genre_means1 = zeros(1, 19);
genre_means2 = zeros(1, 19);

% Get mean for each genre.
for i = 2 : 20
    g = genres(genres(:, i) == 1);
    genre_means1(i - 1) = mean(V2d(1, g));
    genre_means2(i - 1) = mean(V2d(2, g));
end

% Plot with labels.
scatter(genre_means1, genre_means2, 'k.');
hold on
xlabel('Dimension 1');
ylabel('Dimension 2');
a = [1:19]';
b = num2str(a);
labels = cellstr(b);
dx = 0.0001;
dy = 0.0001;
text(genre_means1 + dx, genre_means2 + dy, labels);
title('Visual Representation of Model - Genres');
hold off

%% Series Plot
% The IDs for movies in each of these series.
% Die Hard series
dh = [226, 550, 144];
% Star Trek series
s = [222, 227, 228, 229, 230, 380, 449, 450];
% Jaws series
j = [234, 452, 453];

% Plot with labels.
scatter(V2d(1, dh), V2d(2, dh), 'r');
hold on
scatter(V2d(1, s), V2d(2, s), 'k');
scatter(V2d(1, j), V2d(2, j), 'g');
xlabel('Dimension 1');
ylabel('Dimension 2');
title('Visual Representation of Model - Series');
hold off

%% Difference in Dimension Plot

pred20 = U * V';
pred2 = U2d' * V2d;

diff = pred2 - pred20;
diff = reshape(diff, [1, 943 * 1682]);
line(diff);
% scatter(V2d(1, g1), V2d(2, g1), 'r');
hold on

% scatter(V2d(1, g2), V2d(2, g2), 'k');
% scatter(V2d(1, g3), V2d(2, g3), 'b');
% scatter(V2d(1, g4), V2d(2, g4), 'g');
hold off
