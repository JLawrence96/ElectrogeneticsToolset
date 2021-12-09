%%%%%%%%%%%%%%%%%%%
%Fig 4c = Activator Characterisation GFP
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, barwitherr.m

%% Import
F4c_raw = csvread('F4c_raw.csv');

%% Statistics
F4c_categories = size(F4c_raw,1)-1;
F4c_conditions = size(F4c_raw,2);

F4c_blanked = F4c_raw(1:F4c_categories,:)-F4c_raw(F4c_categories+1,:);
F4c_blanked(F4c_blanked<0) = 0;
F4c_normalised = F4c_blanked(:,(F4c_conditions/2)+1:F4c_conditions)./F4c_blanked(:,1:F4c_conditions/2);
F4c_RPU(1:5,:) = F4c_normalised(1:5,:)./DH5a_GFP_RPU;
F4c_RPU(6:8,:) = F4c_normalised(6:8,:)./DJ901_GFP_RPU;

F4c_mean(1,1:F4c_categories) = mean(F4c_RPU(:,1:3),2);
F4c_mean(2,1:F4c_categories) = mean(F4c_RPU(:,4:6),2);
F4c_std(1,1:F4c_categories) = std(F4c_RPU(:,1:3),0,2);
F4c_std(2,1:F4c_categories) = std(F4c_RPU(:,4:6),0,2);

F4c_foldchange = F4c_mean(2,:)./F4c_mean(1,:)

%% Removing Samples
F4c_mean(:,2:3) = [];
F4c_std(:,2:3) = [];

%% Plotting
y_val = F4c_mean';
y_eb = F4c_std';

[bF4c eF4c] = barwitherr(y_eb,y_val,0.9);
hold on;
%% Formatting
box off;

set(bF4c(1),'FaceColor',[0.996 0.559 0.559])
set(bF4c(2),'FaceColor',[0.766 0 0])
set(bF4c(:),'EdgeColor',[0 0 0])
set(bF4c(:),'LineWidth',3)
set(eF4c(:),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','off','YMinorTick','on');
set(gca,'XTick',[]);


xlim([0.5 F4c_categories+0.5-2]);
ylim([0 2.8]);
ylabel({'Output (RPU)',' '});
legend([bF4c(1) bF4c(2)],' + 0 \muM Pyo',' + 2.5 \muM Pyo','location','northwest');
legend('boxoff')

set(gcf, 'Position',  [0, 0, 3350*1.23, 1000*1.23])
saveas(gcf,'F4c','tiffn')

hold off