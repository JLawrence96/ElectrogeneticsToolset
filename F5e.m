%%%%%%%%%%%%%%%%%%%
%Fig 5e = Pyo Cyclic Voltammograms
%%%%%%%%%%%%%%%%%%%

%% Import

F5ei_raw = readmatrix('F5ei_raw.csv');
F5eii_raw = readmatrix('F5eii_raw.csv');

%% Statistics
F5e_voltages = F5ei_raw(:,1) + 0.2; %in V vs SHE
F5e_currents = F5ei_raw(:,6); %in uA
F5e_currents_O2 = F5eii_raw(:,6); %in uA

F5e_E_searchindex = find(F5e_voltages > -0.1 & F5e_voltages < 0.1);
F5e_Ered_index = find(ismember(F5e_currents, min(F5e_currents(F5e_E_searchindex))));
F5e_Eox_index = find(ismember(F5e_currents, max(F5e_currents(F5e_E_searchindex))));
F5e_Ered = F5e_voltages(F5e_Ered_index)
F5e_Eox = F5e_voltages(F5e_Eox_index)
F5e_Em = (F5e_Ered + F5e_Eox)/2

%% Plotting 

fF5e(1) = plot(F5e_voltages,F5e_currents,'LineWidth',2.5,'color',[0 0 0],'LineWidth',3);
hold on
fF5e(2) = plot(F5e_voltages,F5e_currents_O2,'LineWidth',2.5,'color',[0.5 0.5 0.5],'LineWidth',3);
hold on

box off

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xlim([min(F5e_voltages) max(F5e_voltages)]);
ylim([-4 1]);
xlabel({'Potential (V vs SHE)'});
ylabel({'Current (\muA)'});
legend([fF5e(1) fF5e(2)],' Pyo in N_{2}',' Pyo in Air','location','northwest');
legend('boxoff')

pbaspect([1 1 1])
set(gcf, 'Position',  [100, 100, 1000, 1000])
saveas(gcf,'F5e','tiffn')

hold off