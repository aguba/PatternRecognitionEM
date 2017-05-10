%-------------Synthetic Data----------------------------
mu = [0 2; 5 2; 5 5];
% mu = [2 2; 3 2; 3 3.5];

sig = [.05 .5; .27 .27; .4 .1];
p = [0.2 0.3 0.5];
N = 500;
k = 3;

[X y] = generate_gauss_classes(mu, sig, p, N);
x = X;
%--------------------------------------------------------

% muEstimate = [];
muEstimate = [2.7 3.6; 3.4 1.8; 1.9 2.6];

[MU SIG W count muInit] = EM_GMM(x, k, muEstimate, false);

scatter(x(:,1), x(:,2), 'b', 'filled');
hold on;
scatter(mu(:,1), mu(:,2), 'r', 'filled');
scatter(MU(:,1), MU(:,2), 24, 'g', 'filled');
scatter(muInit(:,1), muInit(:,2), 72, 'xm', 'LineWidth', 2);
for i=1:k
    ellipsePlot(mu(i,:), sig(i,:), 'r');
    ellipsePlot(MU(i,:), SIG(:,:,i), 'g');
end

legend('Data Points', ['Original Means: ' mat2str(mu)],...
    ['Estimated Means: ' mat2str(round(MU,2))],... 
    ['Initial Mean Estimates: ' mat2str(round(muInit,2))],...
    ['Original Variance'],...
    ['Estimated Variance']);

hold off;