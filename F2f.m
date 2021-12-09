%%%%%%%%%%%%%%%%%%%
%Fig 2f = Promoter Architecture RFP
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, barwitherr.m

%% Import
F2f_raw = csvread('F2f_raw.csv');

%% Statistics
F2f_categories = size(F2f_raw,1)-1;
F2f_conditions = size(F2f_raw,2);


F2f_blanked = F2f_raw(1:F2f_categories,:)-F2f_raw(F2f_categories+1,:);
F2f_blanked(F2f_blanked<0) = 0;
F2f_normalised = F2f_blanked(:,(F2f_conditions/2)+1:F2f_conditions)./F2f_blanked(:,1:F2f_conditions/2);
F2f_RPU = F2f_normalised./DH5a_RFP_RPU;

F2f_mean(1,1:F2f_categories) = mean(F2f_RPU(:,1:3),2);
F2f_mean(2,1:F2f_categories) = mean(F2f_RPU(:,4:6),2);
F2f_std(1,1:F2f_categories) = std(F2f_RPU(:,1:3),0,2);
F2f_std(2,1:F2f_categories) = std(F2f_RPU(:,4:6),0,2);

%% Removing Samples
F2f_mean(:,2) = [];
F2f_std(:,2) = [];

%% Plotting
y_val = F2f_mean';
y_eb = F2f_std';

[bF2f eF2f] = barwitherr(y_eb,y_val,0.9);
hold on;


%% Formatting
box off;

set(bF2f(1),'FaceColor',[0.789 0.926 0.992])
set(bF2f(2),'FaceColor',[0.008 0.617 0.923])
set(bF2f(:),'EdgeColor',[0 0 0])
set(bF2f(:),'LineWidth',3)
set(eF2f(:),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','off','YMinorTick','on');
set(gca,'XTick',[]);

xlim([0.5 F2f_categories+0.5-1]);
ylim([0 1.2]);
ylabel({'Output (RPU)',' '});
legend([bF2f(1) bF2f(2)],' + 0 \muM Pyo',' + 2.5 \muM Pyo','location','northeast');
legend('boxoff')

xh = get(gca,'xlabel') 
p = get(xh,'position') 
p(2) = 1*p(2);    
set(xh,'position',p)
   
set(gcf, 'Position',  [100, 100, 1675*1.146886, 1000])
saveas(gcf,'F2f','tiffn')

hold off