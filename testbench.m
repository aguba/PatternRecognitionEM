
%-------------Synthetic Data------------------
mu = [0 2; 5 2; 5 5];
sig = [.05 .5; .27 .27; .4 .1];
p = [0.2 0.3 0.5];
N = 500;
k = 3;

[X y] = generate_gauss_classes(mu, sig, p, N);
x = X;

m = 100;
nC1 = randperm(N, m);
nC2 = repmat([1 2], 1, m/2);
scatter(x(nC1,1), x(nC1,2), 'r');
hold on;
for i = 1:m
    x(nC1(i), nC2(i)) = NaN;
end

scatter(mu(:,1), mu(:,2), 'r', 'filled');
hold on;
for i=1:k
    ellipsePlot(mu(i,:), sig(i,:), 'r');
end
%--------------------------------------------------------

%---------Old Faithful-------------------------
% x = OldFaithful;
% k = 2;
%--------------------------------------------

muEstimate = [];
% muEstimate = [7 40; 0 90];
% muEstimate = [4.5 40; 2 90];
% muEstimate = [0 1; 6 0; 4 4];
% muEstimate = [0 1; 0 1.1; 0.1 1];

% [MU SIG W count muInit] = EM_GMM(x, k, muEstimate, true);
[MU SIG W count muInit] = EM_GMM_carryForwardImputation(x, k, muEstimate);
% [MU SIG W count muInit xc m] = EM_GMM_meanImputation1(x, k, muEstimate);

scatter(x(:,1), x(:,2), 'b', 'filled');
hold on;
scatter(MU(:,1), MU(:,2), 24, 'g', 'filled');
scatter(muInit(:,1), muInit(:,2), 72, 'xm', 'LineWidth', 2);

for i=1:k
    ellipsePlot(MU(i,:), SIG(:,:,i), 'g');
end

hold off;