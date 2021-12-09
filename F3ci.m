%%%%%%%%%%%%%%%%%%%
%Fig 3ci = Mutant Promoter ON RPU
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m

%% Import
F3c_raw = csvread('F3bcd_raw.csv');

%% Statistics
F3c_categories = size(F3c_raw,1)-1;
F3c_conditions = size(F3c_raw,2);

F3c_blanked = F3c_raw(1:F3c_categories,:)-F3c_raw(F3c_categories+1,:);
F3c_blanked(F3c_blanked<0) = 0;
F3c_normalised = F3c_blanked(:,(F3c_conditions/2)+1:F3c_conditions)./F3c_blanked(:,1:F3c_conditions/2);
F3c_RPU = F3c_normalised./DH5a_GFP_RPU;
F3c_foldchange = F3c_RPU(:,4:6)./ F3c_RPU(:,1:3);

F3c_offmean = mean(F3c_RPU(:,1:3),2);
F3c_onmean = mean(F3c_RPU(:,4:6),2);
F3c_foldchangemean = mean(F3c_foldchange(:,1:3),2);
F3c_offstd = std(F3c_RPU(:,1:3),0,2);
F3c_onstd = std(F3c_RPU(:,4:6),0,2);
F3c_foldchangestd = std(F3c_foldchange(:,1:3),0,2);

F3ci_offmean = reshape(F3c_offmean(1:F3c_categories-1),[4,3]);
F3ci_onmean = reshape(F3c_onmean(1:F3c_categories-1),[4,3]);
F3ci_foldchangemean = reshape(F3c_foldchangemean(1:F3c_categories-1),[4,3]);
F3ci_offstd = reshape(F3c_offstd(1:F3c_categories-1),[4,3]);
F3ci_onstd = reshape(F3c_onstd(1:F3c_categories-1),[4,3]);
F3ci_foldchangestd = reshape(F3c_foldchangestd(1:F3c_categories-1),[4,3]);

%% Plotting
set(gcf, 'Position',  [1, 1, 1000, 1333]);
map = brewermap(100,'BuGN');
hF3c_off = heatmap2(round(F3ci_onmean,2),["A" "B" "C"],["a" "b" "c" "d" "e"],round(F3ci_onmean,2),'Colormap', map, 'FontSize', 44,'Colorbar',true,'MinColorValue',0,'MaxColorValue',1.5,'GridLines','-');
title({'Induced Output (RPU)',' '});
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
saveas(gcf,'F3ci','tiffn')

hold off