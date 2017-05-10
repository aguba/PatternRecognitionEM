function [ mu, sig, w, count, initialMeanEstimate ] = EM_GMM_carryForwardImputation( X, k, meanEstimate, showPlot )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
x = X;
N = size(x, 1);
[m(:,1), m(:,2)] = find(isnan(x));
mSize = size(m, 1);

index = 0;
for i = 1:N
    if isnan(x(i,1))
        index = i;
        while isnan(x(index,1))
            index = index - 1;
            if index == 0
                index = N;
            end
        end
        x(i, 1) = x(index, 1);
    end
    if isnan(x(i,2))
        index = i;
        while isnan(x(index,2))
            index = index - 1;
            if index == 0
                index = N;
            end
        end
        x(i, 2) = x(index, 2);
    end
end

%initial mean estimate
if isempty(meanEstimate)
    mu = x(randperm(N, k), :);
else
    mu = meanEstimate;
end
initialMeanEstimate = mu;

%initial covariance matrix estimate
sig = zeros(2,2,k);
sig(:,:,1:k) = repmat(cov(x),1,1,k);

%initial gaussian weight estimate
w(1:k) = repmat(1/k, 1, k);


muPrev = 0;
sigPrev = 0;
wPrev = 0;

muSum = sum(sum(mu));
sigSum = sum(sum(sig));
wSum = sum(w);

count = 0;
threshold = 0.0001;

while (abs(muPrev - muSum) > threshold || abs(sigPrev - sigSum) > threshold || abs(wPrev - wSum) > threshold)
    count = count + 1;
    
    muPrev = muSum;
    sigPrev = sigSum;
    wPrev = wSum;
    
    %E-step
    p = zeros(N, k);
    for i = 1:N
        pSum = 0;
        for j = 1:k
            p(i, j) = w(j)*mvnpdf(x(i,:), mu(j,:), sig(:,:,j));
            pSum = pSum + p(i, j);
        end

        for j = 1:k
            p(i, j) = p(i, j) / pSum;
        end
    end


    %M-step
    %weights, means, and covariances
    for i = 1:k
        pSum = 0;
        muSum = 0;
        sigSum = 0;
        for j = 1:N
            pSum = pSum + p(j, i);
            muSum = muSum + p(j, i) * x(j, :);
        end
        w(i) = pSum / N;
        mu(i, :) = muSum / pSum;
        
        for j = 1:N
            sigSum = sigSum + p(j, i) * (x(j, :) - mu(i, :))'*(x(j, :) - mu(i, :));
        end       
        sig(:,:,i) = sigSum / pSum;
    end
    
    muSum = sum(sum(mu));
    sigSum = sum(sum(sum(sig)));
    wSum = sum(w);
end
end

