mu = [0 2; 5 2; 5 5];
sig = [.05 .5; .27 .27; .4 .1];
p = [0.2 0.3 0.5];
N = 500;
k = 3;

muEstimate = [];
% muEstimate = [1 1; 6 0; 4 4];
% muEstimate = [0 1; 0 1.1; 0.1 1];

[x y] = generate_gauss_classes(mu, sig, p, N);
[MU SIG W count muInit] = EM_GMM(x, k, muEstimate)

scatter(x(:,1), x(:,2))
hold on;
scatter(mu(:,1), mu(:,2), 'filled');
scatter(MU(:,1), MU(:,2), 24, 'g', 'filled');
scatter(muInit(:,1), muInit(:,2), 72, 'xm', 'LineWidth', 2);

for i=1:k
    ellipsePlot(mu(i,:), sig(i,:), 'r');
    ellipsePlot(MU(i,:), SIG(:,:,i), 'g');
end

hold off;