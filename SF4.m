%%%%%%%%%%%%%%%%%%%
%Fig S4a = Activator Characterisation GFP in different strains
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, barwitherr.m

%% Import
SF4_raw = csvread('SF4_raw.csv');

%% Statistics
SF4_categories = size(SF4_raw,1)-2;
SF4_conditions = size(SF4_raw,2);

SF4_blanked(1:4,:) = SF4_raw(1:4,:)-SF4_raw(SF4_categories+1,:);
SF4_blanked(5:6,:) = SF4_raw(5:6,:)-SF4_raw(SF4_categories+2,:);
SF4_blanked(SF4_blanked<0) = 0;
SF4_normalised = SF4_blanked(:,(SF4_conditions/2)+1:SF4_conditions)./SF4_blanked(:,1:SF4_conditions/2);
SF4_RPU(1:2,:) = SF4_normalised(1:2,:)./BL21_GFP_RPU;
SF4_RPU(3:4,:) = SF4_normalised(3:4,:)./MDS42_GFP_RPU;
SF4_RPU(5:6,:) = SF4_normalised(5:6,:)./Vnat_GFP_RPU;

SF4_mean(1,1:SF4_categories) = mean(SF4_RPU(:,1:3),2);
SF4_mean(2,1:SF4_categories) = mean(SF4_RPU(:,4:6),2);
SF4_mean(3,1:SF4_categories) = mean(SF4_RPU(:,7:9),2);
SF4_std(1,1:SF4_categories) = std(SF4_RPU(:,1:3),0,2);
SF4_std(2,1:SF4_categories) = std(SF4_RPU(:,4:6),0,2);
SF4_std(3,1:SF4_categories) = std(SF4_RPU(:,7:9),0,2);

SF4_foldchange(1,:) = SF4_mean(2,:)./SF4_mean(1,:)
SF4_foldchange(2,:) = SF4_mean(3,:)./SF4_mean(1,:)

%% Plotting
y_val = SF4_mean';
y_eb = SF4_std';

[bSF4 eSF4] = barwitherr(y_eb,y_val,0.9);
hold on;
%% Formatting
box off;

set(bSF4(1),'FaceColor',[0.996 0.559 0.559])
set(bSF4(2),'FaceColor',[0.986 0.22 0.22])
set(bSF4(3),'FaceColor',[0.766 0 0])
set(bSF4(:),'EdgeColor',[0 0 0])
set(bSF4(:),'LineWidth',3)
set(eSF4(:),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','off','YMinorTick','on');
set(gca,'XTick',[]);


xlim([0.5 SF4_categories+0.5]);
ylim([0 2.8]);
ylabel({'Output (RPU)',' '});
legend([bSF4(1) bSF4(2) bSF4(3)],' + 0 \muM Pyo',' + 2.5 \muM Pyo',' + 10 \muM Pyo','location','northwest');
legend('boxoff')

set(gcf, 'Position',  [0, 0, 3350*1.23, 1000*1.23])
saveas(gcf,'SF4','tiffn')

hold off