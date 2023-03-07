clear;
clc;
clearvars;

T = readmatrix('dataPat_4.csv');
% separate the matrix in subset of 500 points (1s)
T1 = T(1:500, :);
T2 = T(501:1000, :);
T3 = T(1001:1500, :);
T4 = T(1501:2000, :);
T5 = T(2001:2500, :);
T6 = T(2501:3000, :);
T7 = T(3001:3500, :);
T8 = T(3501:4000, :);
T9 = T(4001:4500, :);
T10 = T(4501:5000, :);
T11 = T(5001:5500, :);
T12 = T(5501:6000, :);
T13 = T(6001:6500, :);
T14 = T(6501:7000, :);
T15 = T(7001:7200, :);

% calculate the adj matrix for each 
A = corrcoef(T);
A1 = corrcoef(T1);
A2 = corrcoef(T2);
A3 = corrcoef(T3);
A4 = corrcoef(T4);
A5 = corrcoef(T5);
A6 = corrcoef(T6);
A7 = corrcoef(T7);
A8 = corrcoef(T8);
A9 = corrcoef(T9);
A10 = corrcoef(T10);
A11 = corrcoef(T11);
A12 = corrcoef(T12);
A13 = corrcoef(T13);
A14 = corrcoef(T14);
A15 = corrcoef(T15);

tl = tiledlayout(4,4,'TileSpacing','Compact');
nexttile(tl)
heatmap(A1);
clim([-1 1]);
nexttile(tl);
heatmap(A2);
clim([-1 1]);
nexttile(tl);
heatmap(A3);
clim([-1 1]);
nexttile(tl);
heatmap(A4);
clim([-1 1]);
nexttile(tl);
heatmap(A5);
clim([-1 1]);
nexttile(tl);
heatmap(A6);
clim([-1 1]);
nexttile(tl);
heatmap(A7);
clim([-1 1]);
nexttile(tl);
heatmap(A8);
clim([-1 1]);
nexttile(tl);
heatmap(A9);
clim([-1 1]);
nexttile(tl);
heatmap(A10);
clim([-1 1]);
nexttile(tl);
heatmap(A11);
clim([-1 1]);
nexttile(tl);
heatmap(A12);
clim([-1 1]);
nexttile(tl);
heatmap(A13);
clim([-1 1]);
nexttile(tl);
heatmap(A14);
clim([-1 1]);
nexttile(tl);
heatmap(A15);
clim([-1 1]);
nexttile(tl);
heatmap(A);
colormap parula;
clim([-1 1]);



