%%%%%%%%%%%%%%%%%%%
%Fig 5d = MV Cyclic Voltammograms
%%%%%%%%%%%%%%%%%%%

%% Import

F5di_raw = readmatrix('F5di_raw.csv');
F5dii_raw = readmatrix('F5dii_raw.csv');

%% Statistics
F5d_voltages = F5di_raw(:,1) + 0.2; %in V vs SHE
F5d_currents = F5di_raw(:,6); %in uA
F5d_currents_O2 = F5dii_raw(:,6); %in uA

F5d_E1_searchindex = find(F5d_voltages > -0.9 & F5d_voltages < -0.6);
F5d_Ered1_index = find(ismember(F5d_currents, min(F5d_currents(F5d_E1_searchindex))));
F5d_Eox1_index = find(ismember(F5d_currents, max(F5d_currents(F5d_E1_searchindex))));
F5d_E2_searchindex = find(F5d_voltages > -0.6 & F5d_voltages < -0.2);
F5d_Ered2_index = find(ismember(F5d_currents, min(F5d_currents(F5d_E2_searchindex))));
F5d_Eox2_index = find(ismember(F5d_currents, max(F5d_currents(F5d_E2_searchindex))));


F5d_E1red = F5d_voltages(F5d_Ered1_index)
F5d_E1ox = F5d_voltages(F5d_Eox1_index)
F5d_Em1 = (F5d_E1red + F5d_E1ox)/2
F5d_E2red = F5d_voltages(F5d_Ered2_index)
F5d_E2ox = F5d_voltages(F5d_Eox2_index)
F5d_Em2 = (F5d_E2red + F5d_E2ox)/2



%% Plotting 

fF5d(1) = plot(F5d_voltages,F5d_currents,'LineWidth',2.5,'color',[0 0 0],'LineWidth',3);
hold on
fF5d(2) = plot(F5d_voltages,F5d_currents_O2,'LineWidth',2.5,'color',[0.5 0.5 0.5],'LineWidth',3);
hold on

box off

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xlim([min(F5d_voltages) max(F5d_voltages)]);
ylim([-15 3]);
xlabel({'Potential (V vs SHE)'});
ylabel({'Current (\muA)'});
legend([fF5d(1) fF5d(2)],' MV in N_{2}',' MV in Air','location','northwest');
legend('boxoff')

pbaspect([1 1 1])
set(gcf, 'Position',  [100, 100, 1000, 1000])
saveas(gcf,'F5d','tiffn')

hold off