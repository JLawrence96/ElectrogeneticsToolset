%%%%%%%%%%%%%%%%%%%
%Fig 3bi = Mutant Promoter OFF RPU
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, brewermap.m, heatmap2.m

%% Import
F3b_raw = csvread('F3bcd_raw.csv');

%% Statistics
F3b_categories = size(F3b_raw,1)-1;
F3b_conditions = size(F3b_raw,2);

F3b_blanked = F3b_raw(1:F3b_categories,:)-F3b_raw(F3b_categories+1,:);
F3b_blanked(F3b_blanked<0) = 0;
F3b_normalised = F3b_blanked(:,(F3b_conditions/2)+1:F3b_conditions)./F3b_blanked(:,1:F3b_conditions/2);
F3b_RPU = F3b_normalised./DH5a_GFP_RPU;
F3b_foldchange = F3b_RPU(:,4:6)./ F3b_RPU(:,1:3);

F3b_offmean = mean(F3b_RPU(:,1:3),2);
F3b_onmean = mean(F3b_RPU(:,4:6),2);
F3b_foldchangemean = mean(F3b_foldchange(:,1:3),2);
F3b_offstd = std(F3b_RPU(:,1:3),0,2);
F3b_onstd = std(F3b_RPU(:,4:6),0,2);
F3b_foldchangestd = std(F3b_foldchange(:,1:3),0,2);

F3bi_offmean = reshape(F3b_offmean(1:F3b_categories-1),[4,3]);
F3bi_onmean = reshape(F3b_onmean(1:F3b_categories-1),[4,3]);
F3bi_foldchangemean = reshape(F3b_foldchangemean(1:F3b_categories-1),[4,3]);
F3bi_offstd = reshape(F3b_offstd(1:F3b_categories-1),[4,3]);
F3bi_onstd = reshape(F3b_onstd(1:F3b_categories-1),[4,3]);
F3bi_foldchangestd = reshape(F3b_foldchangestd(1:F3b_categories-1),[4,3]);

%% Plotting
set(gcf, 'Position',  [1, 1, 1000, 1333]);
map = brewermap(100,'BuGN');
hF3b_off = heatmap2(round(F3bi_offmean,2),["A" "B" "C"],["a" "b" "c" "d"],round(F3bi_offmean,2),'FontSize', 44,'Colormap',map, 'Colorbar',true,'MinColorValue',0,'MaxColorValue',1.5,'GridLines','-');
title({'Uninduced Output (RPU)',' '});
xlabel({'-35 Sequence'});
ylabel({'-10 Sequence'});

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca, 'TickLength',[0 0])

yh = get(gca,'ylabel') 
o = get(yh,'position') 
o(1) = o(1)/2;    
set(yh,'position',o)
   
col = colorbar;
col.LineWidth = 3;
col.TickDirection = 'out';

pbaspect([0.6 0.8 1])
saveas(gcf,'F3bi','tiffn')

hold off