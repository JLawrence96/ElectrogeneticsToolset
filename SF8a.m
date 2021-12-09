%%%%%%%%%%%%%%%%%%%
%Fig S8a = MV Act Growth Curve 
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, shadedErrorBar.m

%% Import
SF8a_raw = csvread('SF8a_raw.csv');
SF8a_blank = csvread('SF8a_blank_raw.csv');

%% Statistics
SF8a_categories = size(SF8a_raw,1)-1;
SF8a_conditions = size(SF8a_raw,2)-1;

SF8a_times = SF8a_blank(2:size(SF8a_blank,1))/60;
SF8a_concentrations = SF8a_blank(1,2:(((size(SF8a_blank,2)-1)/2)+1));


SF8a_blanked = zeros(size(SF8a_raw,1)-1,size(SF8a_raw,2)-1);


for i = 3:3:72
    SF8a_blanked(:,i-2:i) = SF8a_raw(2:size(SF8a_raw,1),i-1:i+1) - SF8a_blank(2:size(SF8a_blank,1),(i/3)+1);
end
SF8a_blanked(SF8a_blanked<0) = 0;

SF8a_OD600 = SF8a_blanked(:,1:SF8a_conditions/2);
SF8a_normalised = SF8a_blanked(:,(SF8a_conditions/2)+1:SF8a_conditions) ./ SF8a_OD600;
SF8a_RPU = SF8a_normalised./DJ901_GFP_RPU;

for j = 1:1:SF8a_conditions/6;
     SF8a_OD600_mean(:,j) = mean(SF8a_OD600(:,(j*3)-2:j*3),2);
     SF8a_OD600_std(:,j) = std(SF8a_OD600(:,(j*3)-2:j*3),0,2);
     SF8a_RPU_mean(:,j) = mean(SF8a_RPU(:,(j*3)-2:j*3),2);
     SF8a_RPU_std(:,j) = std(SF8a_RPU(:,(j*3)-2:j*3),0,2);
end

%% Plotting

for k = 1:1:length(SF8a_concentrations);
    cols = [0.966-((k-1)*0.05) 0.2-((k-1)*0.05) 0.2-((k-1)*0.05)];
    cols(cols<0) = 0;
    fSF8a_OD600(k) = shadedErrorBar(SF8a_times,SF8a_OD600_mean(:,k),SF8a_OD600_std(:,k),'lineProps',{'color',cols,'LineWidth',3,});
    hold on
end

k = 1:1:length(SF8a_concentrations);
legendnames = cellstr(num2str(SF8a_concentrations','%.0f'));
legendnames = append(legendnames,' \muM');
legend([fSF8a_OD600(k).mainLine],legendnames,'location','eastoutside');
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
saveas(gcf,'SF8a','tiffn')

hold off



