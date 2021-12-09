%%%%%%%%%%%%%%%%%%%
%Fig S2c = pSoxR/S Variants GFP
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, barwitherr.m

%% Import
SF2c_raw = csvread('SF2c_raw.csv');

%% Statistics
SF2c_categories = size(SF2c_raw,1)-1;
SF2c_conditions = size(SF2c_raw,2);

SF2c_blanked = SF2c_raw(1:SF2c_categories,:)-SF2c_raw(SF2c_categories+1,:);
SF2c_blanked(SF2c_blanked<0) = 0;
SF2c_RPU = SF2c_normalised./DH5a_GFP_RPU;

SF2c_mean(1,1:SF2c_categories) = mean(SF2c_RPU(:,1:3),2);
SF2c_mean(2,1:SF2c_categories) = mean(SF2c_RPU(:,4:6),2);
SF2c_std(1,1:SF2c_categories) = std(SF2c_RPU(:,1:3),0,2);
SF2c_std(2,1:SF2c_categories) = std(SF2c_RPU(:,4:6),0,2);

%% Plotting
y_val = SF2c_mean';
y_eb = SF2c_std';

[bSF2c eSF2c] = barwitherr(y_eb,y_val,0.9);
hold on;


%% Formatting
box off;

set(bSF2c(1),'FaceColor',[0.789 0.926 0.992])
set(bSF2c(2),'FaceColor',[0.008 0.617 0.923])
set(bSF2c(:),'EdgeColor',[0 0 0])
set(bSF2c(:),'LineWidth',3)
set(eSF2c(:),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','off','YMinorTick','on');
set(gca,'XTick',[]);

xlim([0.5 SF2c_categories+0.5]);
ylim([0 1.5]);
ylabel({'Output (RPU)',' '});
legend([bSF2c(1) bSF2c(2)],' + 0 \muM Pyo',' + 2.5 \muM Pyo','location','eastoutside');
legend('boxoff')

xh = get(gca,'xlabel') 
p = get(xh,'position') 
p(2) = 1*p(2);    
set(xh,'position',p)
   
set(gcf, 'Position',  [100, 100, 1800, 1000])
saveas(gcf,'SF2c','tiffn')

hold off