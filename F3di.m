%%%%%%%%%%%%%%%%%%%
%Fig 3di = Mutant Promoter Fold Change
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, brewermap.m, heatmap2.m

%% Import
F3d_raw = csvread('F3bcd_raw.csv');

%% Statistics
F3d_categories = size(F3d_raw,1)-1;
F3d_conditions = size(F3d_raw,2);

F3d_blanked = F3d_raw(1:F3d_categories,:)-F3d_raw(F3d_categories+1,:);
F3d_blanked(F3d_blanked<0) = 0;
F3d_normalised = F3d_blanked(:,(F3d_conditions/2)+1:F3d_conditions)./F3d_blanked(:,1:F3d_conditions/2);
F3d_RPU = F3d_normalised./DH5a_GFP_RPU;
F3d_foldchange = F3d_RPU(:,4:6)./ F3d_RPU(:,1:3);

F3d_offmean = mean(F3d_RPU(:,1:3),2);
F3d_onmean = mean(F3d_RPU(:,4:6),2);
F3d_foldchangemean = mean(F3d_foldchange(:,1:3),2);
F3d_offstd = std(F3d_RPU(:,1:3),0,2);
F3d_onstd = std(F3d_RPU(:,4:6),0,2);
F3d_foldchangestd = std(F3d_foldchange(:,1:3),0,2);

F3di_offmean = reshape(F3d_offmean(1:F3d_categories-1),[4,3]);
F3di_onmean = reshape(F3d_onmean(1:F3d_categories-1),[4,3]);
F3di_foldchangemean = reshape(F3d_foldchangemean(1:F3d_categories-1),[4,3]);
F3di_offstd = reshape(F3d_offstd(1:F3d_categories-1),[4,3]);
F3di_onstd = reshape(F3d_onstd(1:F3d_categories-1),[4,3]);
F3di_foldchangestd = reshape(F3d_foldchangestd(1:F3d_categories-1),[4,3]);

%% Plotting
set(gcf, 'Position',  [1, 1, 1000, 1333]);
map = brewermap(100,'BuGN');
hF3d_off = heatmap2(round(F3di_foldchangemean,1),["A" "B" "C"],["a" "b" "c" "d" "e"],round(F3di_foldchangemean,1),'FontSize', 44,'Colormap',map,'Colorbar',true,'MinColorValue',0,'MaxColorValue',12,'GridLines','-');
title({'Fold Change',' '});
xlabel({'-35 Sequence'});
ylabel({'-10 Sequence'});

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'fontsize',44);
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
set(gcf, 'Position',  [1, 1, 1000, 1333])
saveas(gcf,'F3di','tiffn')

hold off