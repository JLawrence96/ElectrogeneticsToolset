%%%%%%%%%%%%%%%%%%%
%Fig S12c = Chrono Inverter
%%%%%%%%%%%%%%%%%%%

%% Import
SF12c_raw = readmatrix('SF12bcd_raw.csv')

%% Statistics
SF12c_times = SF12c_raw(:,1) / 60;
SF12c_current = SF12c_raw(:,2) / 1000;

%% Plotting
fSF12c = plot(SF12c_times,SF12c_current,'LineWidth',10,'Color',[0.836 0.855 0.09])

box off 
set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xlim([-0.3 60])
ylim([-7.5 0])
xlabel('Time (min)');
ylabel('Current (mA)');

pbaspect([1 1 1])
set(gcf, 'Position',  [100, 100, 3000, 3000])
saveas(gcf,'SF12c','tiffn')

hold off