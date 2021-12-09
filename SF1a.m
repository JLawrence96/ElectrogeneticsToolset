%%%%%%%%%%%%%%%%%%%
%Fig S1a = Pyo Uni-pSoxS_NC Growth Curve 
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, shadedErrorBar.m

%% Import
SF1a_raw = csvread('SF1a_raw.csv');
SF1a_blank = csvread('SF1ab_blank_raw.csv');

%% Statistics
SF1a_categories = size(SF1a_raw,1)-1;
SF1a_conditions = size(SF1a_raw,2)-1;

SF1a_times = SF1a_blank(2:size(SF1a_blank,1))/60;

SF1a_concentrations = SF1a_blank(1,2:(((size(SF1a_blank,2)-1)/2)+1));
SF1a_concentrations(1:3:end) = [];
SF1a_concentrations(1:2:end) = [];

SF1a_blanked = SF1a_raw(2:size(SF1a_raw,1),2:size(SF1a_raw,2)) - SF1a_blank(2:size(SF1a_blank,1),2:size(SF1a_blank,2));
SF1a_blanked(SF1a_blanked<0) = 0;

SF1a_OD600 = SF1a_blanked(:,1:SF1a_conditions/2);
SF1a_normalised = SF1a_blanked(:,(SF1a_conditions/2)+1:SF1a_conditions) ./ SF1a_OD600;
SF1a_RPU = SF1a_normalised./DH5a_GFP_RPU;

for j = 1:1:SF1a_conditions/6;
     SF1a_OD600_mean(:,j) = mean(SF1a_OD600(:,(j*3)-2:j*3),2);
     SF1a_OD600_std(:,j) = std(SF1a_OD600(:,(j*3)-2:j*3),0,2);
     SF1a_RPU_mean(:,j) = mean(SF1a_RPU(:,(j*3)-2:j*3),2);
     SF1a_RPU_std(:,j) = std(SF1a_RPU(:,(j*3)-2:j*3),0,2);
end

%% Plotting
l = 0;
for k = [1 8];
    cols = [0.7-(l*0.5) 0.7-(l*0.5) 0.7-(l*0.5)];
    cols(cols<0) = 0;
    fSF1a_OD600(k) = shadedErrorBar(SF1a_times,SF1a_OD600_mean(:,k),SF1a_OD600_std(:,k),'lineProps',{'color',cols,'LineWidth',3,});
    hold on
    l = l + 1;
end

k = [1 8];
legendnames = cellstr(num2str([0 2.5 10]','%.1f'));
legendnames = append(legendnames,' \muM');
legend([fSF1a_OD600(k).mainLine],legendnames,'location','eastoutside');
legend('boxoff');

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xlim([0 14])
ylim([0 0.54])
xlabel('Time (hr)');
ylabel('OD_{600}');


pbaspect([1.3 1 1])
set(gcf, 'Position',  [100, 100, 3000, 3000])
saveas(gcf,'SF1a','tiffn')

hold off



