function XHist = add_history(X,numHist)
%ADD_HISTORY Given a matrix X of size TxN, returns a new matrix of size
%(T-(numHist-1), NxnumHist), adding previous time bins as extra features
% If numHist==1, then it just returns the same matrix.
T = size(X, 1);
N = size(X,2);
XHist = zeros(T-(numHist-1), N*(numHist));

% Loop through X to populate the new matrix with current and past values
for t = numHist:T
    % For each row, concatenate the current row and H previous rows
    row_with_history = X((t-(numHist-1)):t, :);
    % Flatten the row_with_history into a single row
    XHist(t-(numHist-1), :) = row_with_history(:)';
end

end

