%%%%%%%%%%%%%%%%%%%%%%%%%
%Fig S7b = cLogD Reduced Redox Inducers
%%%%%%%%%%%%%%%%%%%%%%%%%

%% Import
SF7b_raw = csvread('SF7b_raw.csv');

%% Plotting
pSF7b = plot(SF7b_raw(:,1),SF7b_raw(:,2:5),'-');

%% Formatting
box off;

set(pSF7b,'LineWidth',5);
set(pSF7b(1),'Color',[0.789 0.926 0.992]);
set(pSF7b(2),'Color',[0.84 0.938 0.93]);
set(pSF7b(3),'Color',[0.996 0.559 0.559]);
set(pSF7b(4),'Color',[0.953 0.961 0.656]);

set(gca, 'FontName', 'Arial');
set(gca,'TickDir','out');
set(gca,'fontsize',24);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',2);
set(gca,'XMinorTick','on','YMinorTick','on');

legend([pSF7b(1) pSF7b(2) pSF7b(3) pSF7b(4)],'Reduced Pyo','Reduced MV','Reduced DHNA',' Reduced RF','location','north');
legend('boxoff')
xlabel({'pH'});
ylabel({'cLogD'});
ylim([-7 5]);

pbaspect([1 1 1])
set(gcf, 'Position',  [100, 1, 1000, 1000])
saveas(gcf,'SF7b','tiffn')

