function [ U ] = new_U( Y, V, lambda )
%new_U Calculate U based on Y, V and lambda
%   As part of the alternating least squares solution for solving for
%   Y = UV', we hold V constant and calculate the optimal U.
% Find the number of latent factors.
[~, k] = size(V);
% Get dimensions of Y.
[m, n] = size(Y);
% Initialize U.
U = zeros(m, k);
% Create a k x k identity.
I = eye(k);
% Scale identity by regulation factor lambda.
L = lambda * I;
% Find each row of U using the least squares optimal solution.
for i = 1:m
    % Calculate the V matrix which is a sum of matrices created by columns
    % of V transpose.
    % Calculate the y_vector which is a sum of vectors of v scaled by 
    % y(i, j).
    Vmat = zeros(k, k);
    y_vec = zeros(k, 1);
    for j = 1:n
        % Only learn on entries of Y that exist.
        if Y(i, j) ~= 0
            Vmat = Vmat + V(j, :)' * V(j, :);
            y_vec = y_vec + Y(i, j) * V(j,:)';
        end
    end
    % Calculate the row of U
    U(i, :) = ((L+Vmat)\y_vec)';
end

end

