%%%%%%%%%%%%%%%%%%%
%Fig S5b = Ribo Act Growth Curve 
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, shadedErrorBar.m

%% Import
SF5b_raw = csvread('SF5b_raw.csv');
SF5b_blank = csvread('SF5b_blank_raw.csv');

%% Statistics
SF5b_categories = size(SF5b_raw,1)-1;
SF5b_conditions = size(SF5b_raw,2)-1;

SF5b_times = SF5b_blank(2:size(SF5b_blank,1))/60;
SF5b_concentrations = SF5b_blank(1,2:(((size(SF5b_blank,2)-1)/2)+1));


SF5b_blanked = zeros(size(SF5b_raw,1)-1,size(SF5b_raw,2)-1);


for i = 3:3:72
    SF5b_blanked(:,i-2:i) = SF5b_raw(2:size(SF5b_raw,1),i-1:i+1) - SF5b_blank(2:size(SF5b_blank,1),(i/3)+1);
end
SF5b_blanked(SF5b_blanked<0) = 0;

SF5b_OD600 = SF5b_blanked(:,1:SF5b_conditions/2);
SF5b_normalised = SF5b_blanked(:,(SF5b_conditions/2)+1:SF5b_conditions) ./ SF5b_OD600;
SF5b_RPU = SF5b_normalised./DJ901_GFP_RPU;

for j = 1:1:SF5b_conditions/6;
     SF5b_OD600_mean(:,j) = mean(SF5b_OD600(:,(j*3)-2:j*3),2);
     SF5b_OD600_std(:,j) = std(SF5b_OD600(:,(j*3)-2:j*3),0,2);
     SF5b_RPU_mean(:,j) = mean(SF5b_RPU(:,(j*3)-2:j*3),2);
     SF5b_RPU_std(:,j) = std(SF5b_RPU(:,(j*3)-2:j*3),0,2);
end

%% Plotting

for k = 1:1:length(SF5b_concentrations);
    cols = [0.966-((k-1)*0.05) 0.2-((k-1)*0.05) 0.2-((k-1)*0.05)];
    cols(cols<0) = 0;
    fSF5b_OD600(k) = shadedErrorBar(SF5b_times,SF5b_OD600_mean(:,k),SF5b_OD600_std(:,k),'lineProps',{'color',cols,'LineWidth',3,});
    hold on
end

k = 1:1:length(SF5b_concentrations);
legendnames = cellstr(num2str(SF5b_concentrations','%.0f'));
legendnames = append(legendnames,' \muM');
legend([fSF5b_OD600(k).mainLine],legendnames,'location','eastoutside');
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
saveas(gcf,'SF5b','tiffn')

hold off



