%%%%%%%%%%%%%%%%%%%
%Fig S3 = Mutant Promoter Bar Chart RPU
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, barwitherr.m

%% Import
SF3_raw = csvread('F3bcd_raw.csv');

%% Statistics
SF3_categories = size(SF3_raw,1)-1;
SF3_conditions = size(SF3_raw,2);

SF3_blanked = SF3_raw(1:SF3_categories,:)-SF3_raw(SF3_categories+1,:);
SF3_blanked(SF3_blanked<0) = 0;
SF3_normalised = SF3_blanked(:,(SF3_conditions/2)+1:SF3_conditions)./SF3_blanked(:,1:SF3_conditions/2);
SF3_RPU = SF3_normalised./DH5a_GFP_RPU;;
SF3_RPU = [SF3_RPU(SF3_categories,:) ; SF3_RPU(1:SF3_categories-1,:)];

SF3_mean(1,1:SF3_categories) = mean(SF3_RPU(:,1:3),2);
SF3_mean(2,1:SF3_categories) = mean(SF3_RPU(:,4:6),2);
SF3_std(1,1:SF3_categories) = std(SF3_RPU(:,1:3),0,2);
SF3_std(2,1:SF3_categories) = std(SF3_RPU(:,4:6),0,2);

%% Plotting
y_val = SF3_mean';
y_eb = SF3_std';

[bSF3 eSF3] = barwitherr(y_eb,y_val,0.9);
hold on;

box off;

set(bSF3(1),'FaceColor',[0.84 0.938 0.93])
set(bSF3(2),'FaceColor',[0 0.398 0.152])
set(bSF3(:),'EdgeColor',[0 0 0])
set(bSF3(:),'LineWidth',3)
set(eSF3(:),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','off','YMinorTick','on');
set(gca,'XTick',[]);


ylim([0 2.5]);
ylabel({'Output (RPU)',' '});
legend([bSF3(1) bSF3(2)],' + 0 \muM Pyo',' + 10 \muM Pyo','location','northwest');
legend('boxoff')

xh = get(gca,'xlabel') 
p = get(xh,'position') 
p(2) = 1*p(2);    
set(xh,'position',p)
   
set(gcf, 'Position',  [100, 100, 3350, 1000])
saveas(gcf,'SF3','tiffn')

hold off

