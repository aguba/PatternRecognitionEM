%Function from matlab exercise 2.3 of the main textbook
%Slightly modified for ease of use
function [X,y]=generate_gauss_classes(mu,sig,P,N)
m = mu';

S = zeros(size(sig,2), size(sig,2), size(sig,1));
for i = 1:size(sig,1)
    S(:, :, i) = diag(sig(i,:));
end

[l,c]=size(m);
X=[];
y=[];
for j=1:c
    % Generating the [p(j)*N)] vectors from each distribution
    t=mvnrnd(m(:,j),S(:,:,j),fix(P(j)*N));
    % The total number of points may be slightly less than N
    % due to the fix operator
    X=[X; t];
    y=[y ones(1,fix(P(j)*N))*j];
end