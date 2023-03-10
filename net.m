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

% tl = tiledlayout("flow",'TileSpacing','Compact');
% nexttile(tl)
% h = imagesc(A6);
% clim([-1 1]);
% title('2501 - 3000')
% nexttile(tl);
% h = imagesc(A7);
% clim([-1 1]);
% title('3001 - 3500')
% nexttile(tl);
% h = imagesc(A8);
% clim([-1 1]);
% title('3501 - 4000')
% nexttile(tl);
% h = imagesc(A9);
% clim([-1 1]);
% title('4001 - 4500')
% boh = nexttile(tl);
% h = imagesc(A10);
% clim([-1 1]);
% title('4501 - 5000')
% nexttile(tl);
% heatmap(A6);
% clim([-1 1]);
% nexttile(tl);
% heatmap(A7);
% clim([-1 1]);
% nexttile(tl);
% heatmap(A8);
% clim([-1 1]);
% nexttile(tl);
% heatmap(A9);
% clim([-1 1]);
% nexttile(tl);
% heatmap(A10);
% clim([-1 1]);
% nexttile(tl);
% heatmap(A11);
% clim([-1 1]);
% nexttile(tl);
% heatmap(A12);
% clim([-1 1]);
% nexttile(tl);
% heatmap(A13);
% clim([-1 1]);
% nexttile(tl);
% heatmap(A14);
% clim([-1 1]);
% nexttile(tl);
% heatmap(A15);
% clim([-1 1]);
% nexttile(tl);
% h = imagesc(A);
% clim([-1 1]);
% title('Final adj matrx')
% 
% J = customcolormap([0 0.5 1], {'#0025B3','#ffffff','#FF0008'});
% colormap(J);
% cb = colorbar;
% cb.Layout.Tile = 'east';
matrices = {A, A1, A2, A3, A4, A5 ,A6, A7, A8, A9, A10, A11, A12, A13, A14, A15};
a = matrices;
% 
% for k = 1:16
% subplot(4,4, k)
% histogram(a{1,k},64, 'Normalization', 'probability');
% ylim([0, 0.1]);
% xlim([-1, 1]);
% xlabel('Coefficient');
% ylabel('Probability');
% if k == 1
%     title('Adiacency matrix');
% end
% if k ~= 1
%     str = sprintf('A %d', k-1);
%     title(str);
% end
% % end


% Draw network
counts = 1;
set =  0:0.05:1;
for j =  0:0.05:1
for k = 1:16
%subplot(4,4, k)
Th = j;
A_th = a{1,k};
comparator = a{1,k}==1; 
A_th(comparator) = 0;
comparator = a{1,k}<Th;
A_th(comparator) = 0;
G = graph(A_th);
% plot(G);
N = numedges(G);
N_edges(k, counts)= N;

if k == 1
    title('Adiacency matrix');
end
if k ~= 1
    str = sprintf('A %d', k-1);
    title(str);
end
end
counts = counts +1; 
end

boxplot(N_edges, "Labels",set)
xlabel('Correlation coefficient threshold')
% bar(set, N_edges, 'DisplayName','N_edges')

