x = OldFaithful;
k = 2;

muEstimate = [];

[MU SIG W count muInit] = EM_GMM(x, k, muEstimate, true);

scatter(x(:,1), x(:,2), 'b', 'filled');
hold on;
scatter(MU(:,1), MU(:,2), 24, 'g', 'filled');
scatter(muInit(:,1), muInit(:,2), 72, 'xm', 'LineWidth', 2);
for i=1:k
    ellipsePlot(MU(i,:), SIG(:,:,i), 'g');
end

hold off;