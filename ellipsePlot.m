function [ output_args ] = ellipsePlot( center, radii, color )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

theta = 0:0.01:2*pi;

if size(radii,1) == 1
    radiusX = 3 * sqrt(radii(1));
    radiusY = 3 * sqrt(radii(2));
elseif size(radii,1) == 2
    radiusX = 3 * sqrt(radii(1,1));
    radiusY = 3 * sqrt(radii(2,2));
end

x = radiusX * cos(theta) + center(1);
y = radiusY * sin(theta) + center(2);

plot(x, y, color);
end

