function [ mu, sig, w, count, initialMeanEstimate, xc, m ] = EM_GMM_meanImputation1( X, k, meanEstimate )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
x = X;
xo = x(sum(isnan(x),2) == 0, :);
xc(:,:,1:k) = repmat(x,1,1,k);
N = size(x, 1);
No = size(xo, 1);

[m(:,1), m(:,2)] = find(isnan(x));
m = sortrows(m);

%initial mean estimate
if isempty(meanEstimate)
    mu = xo(randperm(No, k), :);
else
    mu = meanEstimate;
end
initialMeanEstimate = mu;

for i = 1:size(m,1)
    x(m(i,1), m(i,2)) = mu(1, m(i,2));
end

%initial covariance matrix estimate
sig = zeros(2,2,k);
sig(:,:,1:k) = repmat(cov(x),1,1,k);

%initial gaussian weight estimate
w(1:k) = repmat(1/k, 1, k);



muPrev = 0;
sigPrev = 0;
wPrev = 0;

muSum = sum(sum(mu));
sigSum = sum(sum(sum(sig)));
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
        for j = 1:size(m,1)
            mum = mu(i,m(j,2));
            muo = mu(i, abs(m(j,2) - 2) + 1);
            sigmo = sig(1,2,i);
            sigoo = sig(abs(m(j,2)-2)+1,abs(m(j,2)-2)+1, i);
            xobserved = xc(m(j,1),abs(m(j,2)-2)+1,i);
            xc(m(j,1), m(j,2), i) = mum + (sigmo / sigoo) * (xobserved - muo);
        end
    end
    
    for i = 1:k
        pSum = 0;
        muSum = 0;
        sigSum = 0;
        for j = 1:N
            pSum = pSum + p(j, i);
            muSum = muSum + p(j, i) * xc(j, :, i);
        end
        w(i) = pSum / N;
        mu(i, :) = muSum / pSum;
        
        for j = 1:N
            sigSum = sigSum + p(j, i) * (xc(j, :, i) - mu(i, :))'*(xc(j, :, i) - mu(i, :));
        end       
        sig(:,:,i) = sigSum / pSum;
        
    end
    
    muSum = sum(sum(mu));
    sigSum = sum(sum(sum(sig)));
    wSum = sum(w);
end
end

