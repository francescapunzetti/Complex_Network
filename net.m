clear;
clc;
clearvars;
load('pat_5.mat')
T = readmatrix('dataPat_5.csv');
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

figure; 
tl = tiledlayout("flow",'TileSpacing','Compact');
nexttile(tl)
h = imagesc(A6);
clim([-1 1]);
title('2501 - 3000')
nexttile(tl);
h = imagesc(A7);
clim([-1 1]);
title('3001 - 3500')
nexttile(tl);
h = imagesc(A8);
clim([-1 1]);
title('3501 - 4000')
nexttile(tl);
h = imagesc(A9);
clim([-1 1]);
title('4001 - 4500')
boh = nexttile(tl);
h = imagesc(A10);
clim([-1 1]);
title('4501 - 5000')
h = imagesc(A);
clim([-1 1]);
title('Final adj matrx')

J = customcolormap([0 0.5 1], {'#0025B3','#ffffff','#FF0008'});
colormap(J);
cb = colorbar;
cb.Layout.Tile = 'east';

matrices = {A, A1, A2, A3, A4, A5 ,A6, A7, A8, A9, A10, A11, A12, A13, A14, A15};
a = matrices;

figure;
for k = 1:16
subplot(4,4, k)
histogram(a{1,k},64, 'Normalization', 'probability');
ylim([0, 0.1]);
xlim([-1, 1]);
xlabel('Coefficient');
ylabel('Probability');
if k == 1
    title('Adiacency matrix');
end
if k ~= 1
    str = sprintf('A %d', k-1);
    title(str);
end
end
% 
% % 
% % Draw network
set =  0:0.05:1;
figure;
counts = 1;
for j =  0:0.05:1
for k = 1:16
subplot(4,4, k)
Th = j;
A_th = a{1,k};
comparator = A_th ==1; 
A_th(comparator) = 0;
comparator = A_th < Th;
A_th(comparator) = 0;
comparator = A_th >= Th;
A_th(comparator) = 1;
G = graph(A_th);
N = numedges(G);
N_edges(counts,k) = N;
plot(G)
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

% figure;
% boxplot(N_edges, "Labels",a)
% xlabel('Correlation coefficient threshold')

figure;
bar(set, N_edges, 'DisplayName','N_edges')
hold on
yline(280)

A_th = a{1,1};
comparator = a{1,1}==1; 
A_th(comparator) = 0;
comparator = a{1,1}<0.25;
A_th(comparator) = 0;
G = graph(A_th);



% network using Bonferroni correction: 
%alpha = 0.05 / ((64*63)/2);

% network using Dunn-Sidak correction: 
alpha = 1-(1-0.05)^(1/(55*56/2));
comparator = p1<alpha;
p1(comparator) = nan;

figure;
A_th = a{1,1};
pval = isnan(p1);
comparator = pval ==1; 
A_th(comparator) = 0;
comparator = A_th<0;
A_th(comparator) = 0;
G = graph(A_th, 'omitselfloops');
h = plot(G, MarkerSize=10, EdgeAlpha=0.5);

% nodes degree
deg_ranks = centrality(G,'degree');
% edges = linspace(min(deg_ranks),max(deg_ranks),7);
% bins = discretize(deg_ranks,edges);
% h.MarkerSize = bins*3;

% closeness
ucc = centrality(G,'closeness')*55;
% h.NodeCData = ucc; % weighted on network extension
% colormap jet
% colorbar

% betweeness centrality 
wbc = centrality(G,'betweenness','Cost',G.Edges.Weight);
n = numnodes(G);
h.NodeCData = wbc;
colormap parula
colorbar

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
% Pat 04
% highlight(h,1:8,'NodeColor',color{1})
% highlight(h,9:16,'NodeColor',color{2})
% highlight(h,17:26,'NodeColor',color{3})
% highlight(h,27:36,'NodeColor',color{4})
% highlight(h,37:46,'NodeColor',color{5})
% highlight(h,47:55,'NodeColor',color{6})
% highlight(h,55:59,'NodeColor',color{7})
% highlight(h,60:64,'NodeColor',color{8})

%pat 05 
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

