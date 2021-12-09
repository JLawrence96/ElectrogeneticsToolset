%%%%%%%%%%%%%%%%%%%
%Fig S6b = Hydrogen Peroxide Act Growth Curve 
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, shadedErrorBar.m

%% Import
SF6b_raw = csvread('SF6b_raw.csv');
SF6b_blank = csvread('SF6b_blank_raw.csv');

%% Statistics
SF6b_categories = size(SF6b_raw,1)-1;
SF6b_conditions = size(SF6b_raw,2)-1;

SF6b_times = SF6b_blank(2:size(SF6b_blank,1))/60;
SF6b_concentrations = SF6b_blank(1,2:(((size(SF6b_blank,2)-1)/2)+1));


SF6b_blanked = zeros(size(SF6b_raw,1)-1,size(SF6b_raw,2)-1);


for i = 3:3:72
    SF6b_blanked(:,i-2:i) = SF6b_raw(2:size(SF6b_raw,1),i-1:i+1) - SF6b_blank(2:size(SF6b_blank,1),(i/3)+1);
end
SF6b_blanked(SF6b_blanked<0) = 0;

SF6b_OD600 = SF6b_blanked(:,1:SF6b_conditions/2);
SF6b_normalised = SF6b_blanked(:,(SF6b_conditions/2)+1:SF6b_conditions) ./ SF6b_OD600;
SF6b_RPU = SF6b_normalised./DJ901_GFP_RPU;

for j = 1:1:SF6b_conditions/6;
     SF6b_OD600_mean(:,j) = mean(SF6b_OD600(:,(j*3)-2:j*3),2);
     SF6b_OD600_std(:,j) = std(SF6b_OD600(:,(j*3)-2:j*3),0,2);
     SF6b_RPU_mean(:,j) = mean(SF6b_RPU(:,(j*3)-2:j*3),2);
     SF6b_RPU_std(:,j) = std(SF6b_RPU(:,(j*3)-2:j*3),0,2);
end

%% Plotting

for k = 1:1:length(SF6b_concentrations);
    cols = [0.966-((k-1)*0.05) 0.2-((k-1)*0.05) 0.2-((k-1)*0.05)];
    cols(cols<0) = 0;
    fSF6b_OD600(k) = shadedErrorBar(SF6b_times,SF6b_OD600_mean(:,k),SF6b_OD600_std(:,k),'lineProps',{'color',cols,'LineWidth',3,});
    hold on
end

k = 1:1:length(SF6b_concentrations);
legendnames = cellstr(num2str(SF6b_concentrations','%.2f'));
legendnames = append(legendnames,' mM');
legend([fSF6b_OD600(k).mainLine],legendnames,'location','eastoutside');
legend('boxoff');

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

ylim([0 0.5])
xlabel('Time (hr)');
ylabel('OD_{600}');


pbaspect([1.3 1 1])
set(gcf, 'Position',  [100, 100, 3000, 3000])
saveas(gcf,'SF6b','tiffn')

hold off



