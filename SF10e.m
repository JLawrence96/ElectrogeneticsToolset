%%%%%%%%%%%%%%%%%%%
%Fig S10e = LB Cyclic Voltammograms
%%%%%%%%%%%%%%%%%%%

%% Import

SF10ei_raw = readmatrix('SF10ei_raw.csv');
SF10eii_raw = readmatrix('SF10eii_raw.csv');

%% Statistics
SF10e_voltages = SF10ei_raw(:,1) + 0.2; %in V vs SHE
SF10e_currents = SF10ei_raw(:,6); %in uA
SF10e_currents_O2 = SF10eii_raw(:,6); %in uA

%% Plotting 

fSF10e(1) = plot(SF10e_voltages,SF10e_currents,'LineWidth',2.5,'color',[0 0 0],'LineWidth',3);
hold on
fSF10e(2) = plot(SF10e_voltages,SF10e_currents_O2,'LineWidth',2.5,'color',[0.5 0.5 0.5],'LineWidth',3);
hold on

box off

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xlim([min(SF10e_voltages) max(SF10e_voltages)]);
ylim([-1.3 1]);
xlabel({'Potential (V vs SHE)'});
ylabel({'Current (\muA)'});
legend([fSF10e(1) fSF10e(2)],' N_{2}',' Air','location','southeast');
legend('boxoff')

pbaspect([1 1 1])
set(gcf, 'Position',  [100, 100, 1000, 1000])
saveas(gcf,'SF10e','tiffn')

hold off