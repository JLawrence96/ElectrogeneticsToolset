%%%%%%%%%%%%%%%%%%%
%Fig 2e = Promoter Architecture GFP
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, barwitherr.m

%% Import
F2e_raw = csvread('F2e_raw.csv');

%% Statistics
F2e_categories = size(F2e_raw,1)-1;
F2e_conditions = size(F2e_raw,2);


F2e_blanked = F2e_raw(1:F2e_categories,:)-F2e_raw(F2e_categories+1,:);
F2e_blanked(F2e_blanked<0) = 0;
F2e_normalised = F2e_blanked(:,(F2e_conditions/2)+1:F2e_conditions)./F2e_blanked(:,1:F2e_conditions/2);
F2e_RPU = F2e_normalised./DH5a_GFP_RPU;

F2e_mean(1,1:F2e_categories) = mean(F2e_RPU(:,1:3),2);
F2e_mean(2,1:F2e_categories) = mean(F2e_RPU(:,4:6),2);
F2e_std(1,1:F2e_categories) = std(F2e_RPU(:,1:3),0,2);
F2e_std(2,1:F2e_categories) = std(F2e_RPU(:,4:6),0,2);

F2e_mean(:,2:3) = []; % Removing Samples
F2e_std(:,2:3) = [];
F2e_foldchange = F2e_mean(2,:)./F2e_mean(1,:)

%% Plotting
y_val = F2e_mean';
y_eb = F2e_std';

[bF2e eF2e] = barwitherr(y_eb,y_val,0.9);
hold on;


%% Formatting
box off;

set(bF2e(1),'FaceColor',[0.789 0.926 0.992])
set(bF2e(2),'FaceColor',[0.008 0.617 0.923])
set(bF2e(:),'EdgeColor',[0 0 0])
set(bF2e(:),'LineWidth',3)
set(eF2e(:),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','off','YMinorTick','on');
set(gca,'XTick',[]);


xlim([0.5 F2e_categories+0.5-2]); %Removed 2
ylim([0 1.2]);
ylabel({'Output (RPU)',' '});
legend([bF2e(1) bF2e(2)],' + 0 \muM Pyo',' + 2.5 \muM Pyo','location','northeast');
legend('boxoff')

xh = get(gca,'xlabel') 
p = get(xh,'position') 
p(2) = 1*p(2);    
set(xh,'position',p)

set(gcf, 'Position',  [100, 100, 3350, 1000])
saveas(gcf,'F2e','tiffn')

hold off