clear;
clc;
clearvars;
load('pat_4.mat')
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
[A, pval] = corrcoef(T);
[A1, p1] = corrcoef(T1);
[A2, p2] = corrcoef(T2);
[A3,p3] = corrcoef(T3);
[A4,p4] = corrcoef(T4);
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

% figure; 
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

% figure;
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
% end
% 
% % 
% % Draw network
% set =  0:0.05:1;
% figure;
% counts = 1;
% for j =  0:0.05:1
% for k = 1:16
% subplot(4,4, k)
% Th = j;
% A_th = a{1,k};
% comparator = A_th ==1; 
% A_th(comparator) = 0;
% comparator = A_th < Th;
% A_th(comparator) = 0;
% comparator = A_th >= Th;
% A_th(comparator) = 1;
% G = graph(A_th);
% N = numedges(G);
% N_edges(counts,k) = N;
% plot(G)
% if k == 1
%     title('Adiacency matrix');
% end
% if k ~= 1
%     str = sprintf('A %d', k-1);
%     title(str);
% end
% end
% counts = counts +1; 
% end

% figure;
% boxplot(N_edges, "Labels",a)
% xlabel('Correlation coefficient threshold')

% figure;
% bar(set, N_edges, 'DisplayName','N_edges')
% hold on
% yline(280)

A_th = a{1,1};
comparator = a{1,1}==1; 
A_th(comparator) = 0;
comparator = a{1,1}<0.25;
A_th(comparator) = 0;
G = graph(A_th);



% network using Bonferroni correction: 
%alpha = 0.05 / ((64*63)/2);

% network using Dunn-Sidak correction: 
alpha = 1-(1-0.05)^(1/(64*63/2));
comparator = p1<alpha;
p1(comparator) = nan;

figure;
% cambiare qua
A_th = a{1,16};
pval = isnan(p1);
comparator = pval ==1; 
A_th(comparator) = 0;
comparator = A_th<0;
A_th(comparator) = 0;
G = graph(A_th, 'omitselfloops');
h = plot(G, MarkerSize=10, EdgeAlpha=0.5, Layout="force");
layout(h,'force','WeightEffect','inverse')
% nodes degree
deg_ranks = centrality(G,'degree');
% edges = linspace(min(deg_ranks),max(deg_ranks),7);
% bins = discretize(deg_ranks,edges);
% h.MarkerSize = bins*3;

% closeness
closeness = centrality(G,'closeness')*(64-1);
% h.NodeCData = closeness; % weighted on network extension
% colormap jet
% colorbar

% betweeness centrality 
betweennes = centrality(G,'betweenness','Cost',G.Edges.Weight)* (64-1)*(64-2);
n = numnodes(G);
h.NodeCData = betweennes;
colormap parula
colorbar

pg_ranks = centrality(G,'pagerank'); 
eig_centrality = centrality(G,'eigenvector'); 

% type of node
type = class{1,1};
type = string(type);
comparator = class{1,1} == 1;
type(comparator) = 'diamond';
comparator = class{1,1} == 2;
type(comparator) = 'square';
comparator = class{1,1} == 3;
type(comparator) = '*';

h.Marker = type;
color = ["#0072BD","#D95319","#EDB120","#7E2F8E","#77AC30","#4DBEEE","#A2142F", "#FF9999"];
% % Pat 04
% highlight(h,1:8,'NodeColor',color{1})
% highlight(h,9:16,'NodeColor',color{2})
% highlight(h,17:26,'NodeColor',color{3})
% highlight(h,27:36,'NodeColor',color{4})
% highlight(h,37:46,'NodeColor',color{5})
% highlight(h,47:54,'NodeColor',color{6})
% highlight(h,55:59,'NodeColor',color{7})
% highlight(h,60:64,'NodeColor',color{8})

% %pat 05 
% highlight(h,1:10,'NodeColor',color{6})
% highlight(h,11:22,'NodeColor',color{2})
% highlight(h,23:34,'NodeColor',color{3})
% highlight(h,35:46,'NodeColor',color{4})
% highlight(h,47:56,'NodeColor',color{5})

hold on

p = zeros(3, 1);
p(1) = plot(NaN,NaN,'diamond');
p(2) = plot(NaN,NaN,'square');
p(3) = plot(NaN,NaN,'*');
legend(p,'Non epilettogenic', 'Involved', 'Epilettogenic')
title('Network betweenness', 'FontSize', 18)

% Pat05
% for i = 1:56 
% vicini = neighbors(G,i);
% if (1<=i) && (i<=10)
%     counts = 0; 
%     for j = 1:length(vicini)
%         n = vicini(j);
%         if (11<=n) && (n<=56)
%             counts = counts +1;
%         end
%     end
%     neig(i) = counts;
% end
% if (11<=i) && (i<=22)
%     counts = 0; 
%     for j = 1:length(vicini)
%         n = vicini(j);
%         if (1<=n) && (n<=10) || (23<=n) && (n<=56)
%             counts = counts +1;
%         end
%     end
%     neig(i) = counts;
% end
% if (23<=i) && (i<=34)
%     counts = 0; 
%     for j = 1:length(vicini)
%         n = vicini(j);
%         if (1<=n) && (n<=22) || (35<=n) && (n<=56)
%             counts = counts +1;
%         end
%     end
%     neig(i) = counts;
% end
% if (35<=i) && (i<=46)
%     counts = 0; 
%     for j = 1:length(vicini)
%         n = vicini(j);
%         if (1<=n) && (n<=34) || (47<=n) && (n<=56)
%             counts = counts +1;
%         end
%     end
%     neig(i) = counts;
% end
% if (47<=i) && (i<=56)
%     counts = 0; 
%     for j = 1:length(vicini)
%         n = vicini(j);
%         if (1<=n) && (n<=46)
%             counts = counts +1;
%         end
%     end
%     neig(i) = counts;
% end
% end
% neig = transpose(neig);

%Pat04
for i = 1:64 
vicini = neighbors(G,i);
if (1<=i) && (i<=8)
    counts = 0; 
    for j = 1:length(vicini)
        n = vicini(j);
        if (9<=n) && (n<=64)
            counts = counts +1;
        end
    end
    neig(i) = counts;
end
if (9<=i) && (i<=16)
    counts = 0; 
    for j = 1:length(vicini)
        n = vicini(j);
        if (1<=n) && (n<=8) || (10<=n) && (n<=64)
            counts = counts +1;
        end
    end
    neig(i) = counts;
end
if (17<=i) && (i<=26)
    counts = 0; 
    for j = 1:length(vicini)
        n = vicini(j);
        if (1<=n) && (n<=16) || (27<=n) && (n<=64)
            counts = counts +1;
        end
    end
    neig(i) = counts;
end
if (27<=i) && (i<=36)
    counts = 0; 
    for j = 1:length(vicini)
        n = vicini(j);
        if (1<=n) && (n<=26) || (37<=n) && (n<=64)
            counts = counts +1;
        end
    end
    neig(i) = counts;
end
if (37<=i) && (i<=46)
    counts = 0; 
    for j = 1:length(vicini)
        n = vicini(j);
        if (1<=n) && (n<=36) || (47<=n) && (n<=64)
            counts = counts +1;
        end
    end
    neig(i) = counts;
end
if (47<=i) && (i<=54)
    counts = 0; 
    for j = 1:length(vicini)
        n = vicini(j);
        if (1<=n) && (n<=46) || (55<=n) && (n<=64)
            counts = counts +1;
        end
    end
    neig(i) = counts;
end
if (55<=i) && (i<=59)
    counts = 0; 
    for j = 1:length(vicini)
        n = vicini(j);
        if (1<=n) && (n<=54) || (60<=n) && (n<=64)
            counts = counts +1;
        end
    end
    neig(i) = counts;
end
if (60<=i) && (i<=64)
    counts = 0; 
    for j = 1:length(vicini)
        n = vicini(j);
        if (1<=n) && (n<=59)
            counts = counts +1;
        end
    end
    neig(i) = counts;
end
end
neig = transpose(neig);


% Decision tree
% degree = table2array(centralityvalues(:, 1));
% closeness = table2array(centralityvalues(:, 2));
% betweenness = table2array(centralityvalues(:, 3));
% pecentage_ext = table2array(centralityvalues(:, 4));
% norm_ext = table2array(centralityvalues(:, 5));
% X =[degree closeness betweenness pecentage_ext norm_ext];
% Mdl = fitctree(X,type);
% view(Mdl, 'mode', 'graph');
% predire con decision tree
% Ynew = predict(CMdl,mean(X))

% plottare modello 
% view(trainedModel1.ClassificationTree,"Mode","graph")


