%%%%%%%%%%%%%%%%%%%%%%%%%
%Fig S7a = cLogD Oxidised Redox Inducers
%%%%%%%%%%%%%%%%%%%%%%%%%

%% Import
SF7a_raw = csvread('SF7a_raw.csv');

%% Plotting
pSF7a = plot(SF7a_raw(:,1),SF7a_raw(:,2:5),'-');

%% Formatting
box off;

set(pSF7a,'LineWidth',5);
set(pSF7a(1),'Color',[0.008 0.617 0.923]);
set(pSF7a(2),'Color',[0 0.398 0.152]);
set(pSF7a(3),'Color',[0.766 0 0]);
set(pSF7a(4),'Color',[0.836 0.855 0.09]);

set(gca, 'FontName', 'Arial');
set(gca,'TickDir','out');
set(gca,'fontsize',24);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',2);
set(gca,'XMinorTick','on','YMinorTick','on');

legend([pSF7a(1) pSF7a(2) pSF7a(3) pSF7a(4)],' Oxidised Pyo',' Oxidised MV',' Oxidised DHNA',' Oxidised RF','location','north');
legend('boxoff')
xlabel({'pH'});
ylabel({'cLogD'});
ylim([-7 5]);

pbaspect([1 1 1])
set(gcf, 'Position',  [100, 1, 1000, 1000])
saveas(gcf,'SF7a','tiffn')

