function [ V ] = new_V( Y, U, lambda )
%new_V Calculate V based on Y, U and lambda
%   As part of the alternating least squares solution for solving for
%   Y = UV', we hold U constant and calculate the optimal V.
% Find the number of latent factors.
[~, k] = size(U);
% Get dimensions of Y.
[m, n] = size(Y);
% Initialize V.
V = zeros(n, k);
% Create a k x k identity.
I = eye(k);
% Scale identity by regulation factor lambda.
L = lambda * I;
% Find each row of V using the least squares optimal solution.
for j = 1:n
    % Calculate the U matrix which is a sum of matrices created by rows
    % of U.
    % Calculate the y_vector which is a sum of vectors of u scaled by 
    % y(i,j). 
    Umat = zeros(k, k);
    y_vec = zeros(k, 1);
    for i = 1:m
        % Only learn on entries of Y that exist.
        if Y(i, j) ~= 0
            Umat = Umat + U(i, :)'*U(i, :);
            y_vec = y_vec + Y(i, j)*U(i,:)';
        end
    end
    % Calculate the row of U
    V(j, :) = ((L+Umat)\y_vec)';
end

end
