%%%%%%%%%%%%%%%%%%%
%Fig S10d = LB Cyclic Voltammograms
%%%%%%%%%%%%%%%%%%%

%% Import

SF10di_raw = readmatrix('SF10di_raw.csv');
SF10dii_raw = readmatrix('SF10dii_raw.csv');

%% Statistics
SF10d_voltages = SF10di_raw(:,1) + 0.2; %in V vs SHE
SF10d_currents = SF10di_raw(:,6); %in uA
SF10d_currents_O2 = SF10dii_raw(:,6); %in uA

%% Plotting 

fSF10d(1) = plot(SF10d_voltages,SF10d_currents,'LineWidth',2.5,'color',[0 0 0],'LineWidth',3);
hold on
fSF10d(2) = plot(SF10d_voltages,SF10d_currents_O2,'LineWidth',2.5,'color',[0.5 0.5 0.5],'LineWidth',3);
hold on

box off

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xlim([min(SF10d_voltages) max(SF10d_voltages)]);
ylim([-4 1]);
xlabel({'Potential (V vs SHE)'});
ylabel({'Current (\muA)'});
legend([fSF10d(1) fSF10d(2)],' N_{2}',' Air','location','southeast');
legend('boxoff')

pbaspect([1 1 1])
set(gcf, 'Position',  [100, 100, 1000, 1000])
saveas(gcf,'SF10d','tiffn')

hold off