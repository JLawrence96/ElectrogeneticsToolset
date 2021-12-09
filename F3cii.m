%%%%%%%%%%%%%%%%%%%
%Fig 3cii = Seed Promoter OFF RPU
%%%%%%%%%%%%%%%%%%%

%Dependencies = F2e.m, F3ci.m, brewermap.m, heatmap2.m

%% Statistics
F3cii_offmean = F3c_offmean(F3c_categories);
F3cii_onmean = F3c_onmean(F3c_categories);
F3cii_foldchangemean = F3c_foldchangemean(F3c_categories);
F3cii_offstd = F3c_offstd(F3c_categories);
F3cii_onstd = F3c_onstd(F3c_categories);
F3cii_foldchangestd = F3c_foldchangestd(F3c_categories);

%% Plotting
set(gcf, 'Position',  [1, 1, 400, 280]);
map = brewermap(100,'BuGN');
hF3c_off = heatmap2(round(F3cii_onmean,2),[],[],round(F3cii_onmean,2),'FontSize', 44,'Colormap', map, 'MinColorValue',0,'MaxColorValue',1.5,'GridLines','-');
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
saveas(gcf,'F3cii','tiffn')

hold off