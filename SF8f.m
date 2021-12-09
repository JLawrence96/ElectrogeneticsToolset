%%%%%%%%%%%%%%%%%%%
%Fig S8f = DHNA Inv Growth Curve
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, shadedErrorBar.m

%% Import
SF8f_raw = csvread('SF8f_raw.csv');
SF8f_blank = csvread('SF8f_blank_raw.csv');

%% Statistics
SF8f_categories = size(SF8f_raw,1)-1;
SF8f_conditions = size(SF8f_raw,2)-1;

SF8f_times = SF8f_blank(2:size(SF8f_blank,1))/60;
SF8f_concentrations = SF8f_blank(1,2:(((size(SF8f_blank,2)-1)/2)+1));


SF8f_blanked = zeros(size(SF8f_raw,1)-1,size(SF8f_raw,2)-1);


for i = 3:3:72
    SF8f_blanked(:,i-2:i) = SF8f_raw(2:size(SF8f_raw,1),i-1:i+1) - SF8f_blank(2:size(SF8f_blank,1),(i/3)+1);
end
SF8f_blanked(SF8f_blanked<0) = 0;

SF8f_OD600 = SF8f_blanked(:,1:SF8f_conditions/2);
SF8f_normalised = SF8f_blanked(:,(SF8f_conditions/2)+1:SF8f_conditions) ./ SF8f_OD600;
SF8f_RPU = SF8f_normalised./DH5a_GFP_RPU;

for j = 1:1:SF8f_conditions/6;
     SF8f_OD600_mean(:,j) = mean(SF8f_OD600(:,(j*3)-2:j*3),2);
     SF8f_OD600_std(:,j) = std(SF8f_OD600(:,(j*3)-2:j*3),0,2);
     SF8f_RPU_mean(:,j) = mean(SF8f_RPU(:,(j*3)-2:j*3),2);
     SF8f_RPU_std(:,j) = std(SF8f_RPU(:,(j*3)-2:j*3),0,2);
end

%% Plotting

for k = 1:1:length(SF8f_concentrations);
    cols = [0.976-((k-1)*0.05) 0.995-((k-1)*0.05) 0.13-((k-1)*0.05)];
    cols(cols<0) = 0;
    fSF8f_OD600(k) = shadedErrorBar(SF8f_times,SF8f_OD600_mean(:,k),SF8f_OD600_std(:,k),'lineProps',{'color',cols,'LineWidth',3,});
    hold on
end

k = 1:1:length(SF8f_concentrations);
legendnames = cellstr(num2str(SF8f_concentrations','%.0f'));
legendnames = append(legendnames,' \muM');
legend([fSF8f_OD600(k).mainLine],legendnames,'location','eastoutside');
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
saveas(gcf,'SF8f','tiffn')

hold off



