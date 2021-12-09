%%%%%%%%%%%%%%%%%%%
%Fig 4f = Inverter Characterisation GFP
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, barwitherr.m

%% Import
F4f_raw = csvread('F4f_raw.csv');

%% Statistics
F4f_categories = size(F4f_raw,1)-1;
F4f_conditions = size(F4f_raw,2);


F4f_blanked = F4f_raw(1:F4f_categories,:)-F4f_raw(F4f_categories+1,:);
F4f_blanked(F4f_blanked<0) = 0;
F4f_normalised = F4f_blanked(:,(F4f_conditions/2)+1:F4f_conditions)./F4f_blanked(:,1:F4f_conditions/2);
F4f_RPU(1:4,:) = F4f_normalised(1:4,:)./DH5a_GFP_RPU;
F4f_RPU(5:8,:) = F4f_normalised(5:8,:)./DJ901_GFP_RPU;

F4f_mean(1,1:F4f_categories) = mean(F4f_RPU(:,1:3),2);
F4f_mean(2,1:F4f_categories) = mean(F4f_RPU(:,4:6),2);
F4f_std(1,1:F4f_categories) = std(F4f_RPU(:,1:3),0,2);
F4f_std(2,1:F4f_categories) = std(F4f_RPU(:,4:6),0,2);

F4f_foldchange = F4f_mean(1,:)./F4f_mean(2,:)


%% Removing Samples
F4f_mean(:,[2 6]) = [];
F4f_std(:,[2 6]) = [];

%% Plotting
y_val = F4f_mean';
y_eb = F4f_std';

[bF4f eF4f] = barwitherr(y_eb,y_val,0.9);
hold on;


%% Formatting
box off;

set(bF4f(1),'FaceColor',[0.953 0.961 0.656])
set(bF4f(2),'FaceColor',[0.836 0.855 0.09])
set(bF4f(:),'EdgeColor',[0 0 0])
set(bF4f(:),'LineWidth',3)
set(eF4f(:),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','off','YMinorTick','on');
set(gca,'XTick',[]);


xlim([0.5 F4f_categories+0.5-2]);
ylim([0 1]);
ylabel({'Output (RPU)',' '});
legend([bF4f(1) bF4f(2)],' + 0 \muM Pyo',' + 2.5 \muM Pyo','location','northwest');
legend('boxoff')

set(gcf, 'Position',  [0, 0, 3350*1.23, 1000*1.23])
saveas(gcf,'F4f','tiffn')

hold off