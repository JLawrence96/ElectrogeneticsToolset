%%%%%%%%%%%%%%%%%%%
%Fig 5f = DHNA Cyclic Voltammograms
%%%%%%%%%%%%%%%%%%%

%% Import

F5fi_raw = readmatrix('F5fi_raw.csv');
F5fii_raw = readmatrix('F5fii_raw.csv');

%% Statistics
F5f_voltages = F5fi_raw(:,1) + 0.2; %in V vs SHE
F5f_currents = F5fi_raw(:,6); %in uA
F5f_currents_O2 = F5fii_raw(:,6); %in uA

F5f_E_searchindex = find(F5f_voltages > -0.1 & F5f_voltages < 0.5);
F5f_Ered_index = find(ismember(F5f_currents, min(F5f_currents(F5f_E_searchindex))));
F5f_Eox_index = find(ismember(F5f_currents, max(F5f_currents(F5f_E_searchindex))));
F5f_Ered = F5f_voltages(F5f_Ered_index)
F5f_Eox = F5f_voltages(F5f_Eox_index)
F5f_Em = (F5f_Ered + F5f_Eox)/2

%% Plotting 

fF5f(1) = plot(F5f_voltages,F5f_currents,'LineWidth',2.5,'color',[0 0 0],'LineWidth',3);
hold on
fF5f(2) = plot(F5f_voltages,F5f_currents_O2,'LineWidth',2.5,'color',[0.5 0.5 0.5],'LineWidth',3);
hold on

box off

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xlim([min(F5f_voltages) max(F5f_voltages)]);
ylim([-2 10]);
xlabel({'Potential (V vs SHE)'});
ylabel({'Current (\muA)'});
legend([fF5f(1) fF5f(2)],' DHNA in N_{2}',' DHNA in Air','location','northwest');
legend('boxoff')

pbaspect([1 1 1])
set(gcf, 'Position',  [100, 100, 1000, 1000])
saveas(gcf,'F5f','tiffn')

hold off