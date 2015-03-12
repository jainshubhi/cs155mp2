%% CS 155 Project 2
%% Dylan Schultz
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
k = 15;
%% Initialize U and V randomly
U = rand(users, k);
V = rand(movies, k);
%% Optimize U and V using ALS
% Choose a value of lambda.
lambda = 1;
next_U = new_U(Y, V, lambda);
n = norm((U-next_U), 'fro');
while n > 0.01
    U = next_U;
    V = new_V(Y, U, lambda);
    next_U = new_U(Y, V, lambda);
    n = norm((U-next_U), 'fro')
end
%%
U = next_U;
V = new_V(Y, U, lambda);
%% Part 2: Projecting U and V onto 2 dimensions.
%% Mean center both U and V so all rows have a mean of 0.
for i = 1:users
    U(i, :) = U(i, :) - mean(U(i,:));
end
for i = 1:movies
    V(i, :) = V(i, :) - mean(V(i,:));
end
%% Compute the SVD of both U and V.
[Au, Su, Bu] = svd(U, 'econ');
[Av, Sv, Bv] = svd(V, 'econ');
%% Reduce U and V to highest 2 dimensions.
U2d = Au(1:2, :)*U';
V2d = Av(1:2, :)*V';
%% Plot shit
