mu = [0 0];
sig = [1 1];
p = [1];
N = 50;

[x y] = generate_gauss_classes(mu, sig, p, N);

X = x;

nC1 = randperm(N, 24);
nC2 = repmat([1 2], 1, 12);
for i = 1:24
    X(nC1(i), nC2(i)) = NaN;
end

XE = X;

index = 0;
for i = 1:N
    if isnan(XE(i,1))
        index = i;
        while isnan(XE(index,1))
            index = index - 1;
            if index == 0
                index = N;
            end
        end
        XE(i, 1) = XE(index, 1);
    end
    if isnan(XE(i,2))
        index = i;
        while isnan(XE(index,2))
            index = index - 1;
            if index == 0
                index = N;
            end
        end
        XE(i, 2) = XE(index, 2);
    end
end