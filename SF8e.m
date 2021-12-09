%%%%%%%%%%%%%%%%%%%
%Fig S8e = Pyo Inv Growth Curve
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, shadedErrorBar.m

%% Import
SF8e_raw = csvread('SF8e_raw.csv');
SF8e_blank = csvread('SF8e_blank_raw.csvv');

%% Statistics
SF8e_categories = size(SF8e_raw,1)-1;
SF8e_conditions = size(SF8e_raw,2)-1;

SF8e_times = SF8e_blank(2:size(SF8e_blank,1))/60;
SF8e_concentrations = SF8e_blank(1,2:(((size(SF8e_blank,2)-1)/2)+1));


SF8e_blanked = zeros(size(SF8e_raw,1)-1,size(SF8e_raw,2)-1);


for i = 3:3:72
    SF8e_blanked(:,i-2:i) = SF8e_raw(2:size(SF8e_raw,1),i-1:i+1) - SF8e_blank(2:size(SF8e_blank,1),(i/3)+1);
end
SF8e_blanked(SF8e_blanked<0) = 0;

SF8e_OD600 = SF8e_blanked(:,1:SF8e_conditions/2);
SF8e_normalised = SF8e_blanked(:,(SF8e_conditions/2)+1:SF8e_conditions) ./ SF8e_OD600;
SF8e_RPU = SF8e_normalised./DH5a_GFP_RPU;

for j = 1:1:SF8e_conditions/6;
     SF8e_OD600_mean(:,j) = mean(SF8e_OD600(:,(j*3)-2:j*3),2);
     SF8e_OD600_std(:,j) = std(SF8e_OD600(:,(j*3)-2:j*3),0,2);
     SF8e_RPU_mean(:,j) = mean(SF8e_RPU(:,(j*3)-2:j*3),2);
     SF8e_RPU_std(:,j) = std(SF8e_RPU(:,(j*3)-2:j*3),0,2);
end

%% Plotting

for k = 1:1:length(SF8e_concentrations);
    cols = [0.976-((k-1)*0.05) 0.995-((k-1)*0.05) 0.13-((k-1)*0.05)];
    cols(cols<0) = 0;
    fSF8e_OD600(k) = shadedErrorBar(SF8e_times,SF8e_OD600_mean(:,k),SF8e_OD600_std(:,k),'lineProps',{'color',cols,'LineWidth',3,});
    hold on
end

k = 1:1:length(SF8e_concentrations);
legendnames = cellstr(num2str(SF8e_concentrations','%.2f'));
legendnames = append(legendnames,' \muM');
legend([fSF8e_OD600(k).mainLine],legendnames,'location','eastoutside');
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
saveas(gcf,'SF8e','tiffn')

hold off



