x = rawMaterialProperties;
k = 3;

muEstimate = [];
% muEstimate = [0.5 38; 3 12; 5 4];

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