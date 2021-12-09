%%%%%%%%%%%%%%%%%%%
%Fig S8c = DHNA Act Growth Curve 
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, shadedErrorBar.m

%% Import
SF8c_raw = csvread('SF8c_raw.csv');
SF8c_blank = csvread('SF8c_blank_raw.csv');

%% Statistics
SF8c_categories = size(SF8c_raw,1)-1;
SF8c_conditions = size(SF8c_raw,2)-1;

SF8c_times = SF8c_blank(2:size(SF8c_blank,1))/60;
SF8c_concentrations = SF8c_blank(1,2:(((size(SF8c_blank,2)-1)/2)+1));


SF8c_blanked = zeros(size(SF8c_raw,1)-1,size(SF8c_raw,2)-1);


for i = 3:3:72
    SF8c_blanked(:,i-2:i) = SF8c_raw(2:size(SF8c_raw,1),i-1:i+1) - SF8c_blank(2:size(SF8c_blank,1),(i/3)+1);
end
SF8c_blanked(SF8c_blanked<0) = 0;

SF8c_OD600 = SF8c_blanked(:,1:SF8c_conditions/2);
SF8c_normalised = SF8c_blanked(:,(SF8c_conditions/2)+1:SF8c_conditions) ./ SF8c_OD600;
SF8c_RPU = SF8c_normalised./DJ901_GFP_RPU;

for j = 1:1:SF8c_conditions/6;
     SF8c_OD600_mean(:,j) = mean(SF8c_OD600(:,(j*3)-2:j*3),2);
     SF8c_OD600_std(:,j) = std(SF8c_OD600(:,(j*3)-2:j*3),0,2);
     SF8c_RPU_mean(:,j) = mean(SF8c_RPU(:,(j*3)-2:j*3),2);
     SF8c_RPU_std(:,j) = std(SF8c_RPU(:,(j*3)-2:j*3),0,2);
end

%% Plotting

for k = 1:1:length(SF8c_concentrations);
    cols = [0.966-((k-1)*0.05) 0.2-((k-1)*0.05) 0.2-((k-1)*0.05)];
    cols(cols<0) = 0;
    fSF8c_OD600(k) = shadedErrorBar(SF8c_times,SF8c_OD600_mean(:,k),SF8c_OD600_std(:,k),'lineProps',{'color',cols,'LineWidth',3,});
    hold on
end

k = 1:1:length(SF8c_concentrations);
legendnames = cellstr(num2str(SF8c_concentrations','%.0f'));
legendnames = append(legendnames,' \muM');
legend([fSF8c_OD600(k).mainLine],legendnames,'location','eastoutside');
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
saveas(gcf,'SF8c','tiffn')

hold off



