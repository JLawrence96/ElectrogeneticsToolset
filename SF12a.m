%%%%%%%%%%%%%%%%%%%
%Fig S12a = Inverter Echem Results
%%%%%%%%%%%%%%%%%%%

%Dependencies = barwitherr.m

%% Import
SF12a_raw = csvread('F6c_raw.csv');

%% Statistics
SF12a_conditions = size(SF12a_raw,2)-6;

for i = 0:3:3;
    SF12a_blanked(:,1+i:3+i) = SF12a_raw(:,1+i:3+i) - SF12a_raw(:,7:9);
    SF12a_blanked(:,7+i:9+i) = SF12a_raw(:,10+i:12+i) - SF12a_raw(:,16:18);
end

SF12a_blanked(SF12a_blanked<0) = 0;
SF12a_normalised = SF12a_blanked(:,1:SF12a_conditions/2) ./ SF12a_blanked(:,((SF12a_conditions/2)+1):SF12a_conditions);

SF12a_mean(:,1) = mean(SF12a_normalised(:,1:3),2);
SF12a_mean(:,2) = mean(SF12a_normalised(:,4:6),2);
SF12a_std(:,1) = std(SF12a_normalised(:,1:3),0,2);
SF12a_std(:,2) = std(SF12a_normalised(:,4:6),0,2);

%% Plotting
y_val = SF12a_mean';
y_eb = SF12a_std';

[bSF12a eSF12a] = barwitherr(y_eb,y_val,0.9);
hold on;

%% Formatting
box off;

set(bSF12a(1),'FaceColor',[0.953 0.961 0.656])
set(bSF12a(2),'FaceColor',[0.836 0.855 0.09])
set(bSF12a(:),'EdgeColor',[0 0 0])
set(bSF12a(:),'LineWidth',3)
set(eSF12a(:),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','off','YMinorTick','on');
set(gca,'XTick',[]);


xlim([0.5 2.5]);
ylabel({'Normalised Fluorescence (AU)',' '});
legend([bSF12a(1) bSF12a(2)],' Counter',' Working','location','northeast');
legend('boxoff')

xh = get(gca,'xlabel') 
p = get(xh,'position') 
p(2) = 1*p(2);    
set(xh,'position',p)
   
set(gcf, 'Position',  [100, 100, 1000, 1000])
saveas(gcf,'SF12a','tiffn')

hold off