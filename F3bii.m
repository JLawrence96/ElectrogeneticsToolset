%%%%%%%%%%%%%%%%%%%
%Fig 3bii = Seed Promoter OFF RPU
%%%%%%%%%%%%%%%%%%%

%Dependencies = F2e.m, F3bi.m, brewermap.m, heatmap2.m

%% Statistics
F3bii_offmean = F3b_offmean(F3b_categories);
F3bii_onmean = F3b_onmean(F3b_categories);
F3bii_foldchangemean = F3b_foldchangemean(F3b_categories);
F3bii_offstd = F3b_offstd(F3b_categories);
F3bii_onstd = F3b_onstd(F3b_categories);
F3bii_foldchangestd = F3b_foldchangestd(F3b_categories);

%% Plotting
set(gcf, 'Position',  [1, 1, 400, 280]);
map = brewermap(100,'BuGN');
hF3b_off = heatmap2(round(F3bii_offmean,2),[],[],round(F3bii_offmean,2),'FontSize', 44,'Colormap',map, 'MinColorValue',0,'MaxColorValue',1.5,'GridLines','-');
xlabel({'Uni-P\it{sox}S'});

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca, 'TickLength',[0 0])

yh = get(gca,'ylabel') 
o = get(yh,'position') 
o(1) = o(1)/2;    
set(yh,'position',o)
   

pbaspect([1 1 1])
saveas(gcf,'F3bii','tiffn')

hold off