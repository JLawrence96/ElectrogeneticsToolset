%%%%%%%%%%%%%%%%%%%
%Fig 3dii = Seed Promoter OFF RPU
%%%%%%%%%%%%%%%%%%%

%Dependencies = F2e.m, F3di.m, brewermap.m, heatmap2.m

%% Statistics
F3dii_offmean = F3d_offmean(F3d_categories);
F3dii_onmean = F3d_onmean(F3d_categories);
F3dii_foldchangemean = F3d_foldchangemean(F3d_categories);
F3dii_offstd = F3d_offstd(F3d_categories);
F3dii_onstd = F3d_onstd(F3d_categories);
F3dii_foldchangestd = F3d_foldchangestd(F3d_categories);

%% Plotting
set(gcf, 'Position',  [1, 1, 400, 280]);
map = brewermap(100,'BuGN');
hF3d_off = heatmap2(round(F3dii_foldchangemean,1),[],[],round(F3dii_foldchangemean,1),'FontSize', 44,'Colormap', map, 'MinColorValue',0,'MaxColorValue',12,'GridLines','-');
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
saveas(gcf,'F3dii','tiffn')

hold off