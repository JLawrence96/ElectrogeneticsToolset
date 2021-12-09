%%%%%%%%%%%%%%%%%%%
%Fig S8d = MV Inv Growth Curve
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, shadedErrorBar.m

%% Import
SF8d_raw = csvread('SF8d_raw.csv');
SF8d_blank = csvread('SF8d_blank_raw.csv');

%% Statistics
SF8d_categories = size(SF8d_raw,1)-1;
SF8d_conditions = size(SF8d_raw,2)-1;

SF8d_times = SF8d_blank(2:size(SF8d_blank,1))/60;
SF8d_concentrations = SF8d_blank(1,2:(((size(SF8d_blank,2)-1)/2)+1));


SF8d_blanked = zeros(size(SF8d_raw,1)-1,size(SF8d_raw,2)-1);


for i = 3:3:72
    SF8d_blanked(:,i-2:i) = SF8d_raw(2:size(SF8d_raw,1),i-1:i+1) - SF8d_blank(2:size(SF8d_blank,1),(i/3)+1);
end
SF8d_blanked(SF8d_blanked<0) = 0;

SF8d_OD600 = SF8d_blanked(:,1:SF8d_conditions/2);
SF8d_normalised = SF8d_blanked(:,(SF8d_conditions/2)+1:SF8d_conditions) ./ SF8d_OD600;
SF8d_RPU = SF8d_normalised./DH5a_GFP_RPU;

for j = 1:1:SF8d_conditions/6;
     SF8d_OD600_mean(:,j) = mean(SF8d_OD600(:,(j*3)-2:j*3),2);
     SF8d_OD600_std(:,j) = std(SF8d_OD600(:,(j*3)-2:j*3),0,2);
     SF8d_RPU_mean(:,j) = mean(SF8d_RPU(:,(j*3)-2:j*3),2);
     SF8d_RPU_std(:,j) = std(SF8d_RPU(:,(j*3)-2:j*3),0,2);
end

%% Plotting

for k = 1:1:length(SF8d_concentrations);
    cols = [0.976-((k-1)*0.05) 0.995-((k-1)*0.05) 0.13-((k-1)*0.05)];
    cols(cols<0) = 0;
    fSF8d_OD600(k) = shadedErrorBar(SF8d_times,SF8d_OD600_mean(:,k),SF8d_OD600_std(:,k),'lineProps',{'color',cols,'LineWidth',3,});
    hold on
end

k = 1:1:length(SF8d_concentrations);
legendnames = cellstr(num2str(SF8d_concentrations','%.2f'));
legendnames = append(legendnames,' \muM');
legend([fSF8d_OD600(k).mainLine],legendnames,'location','eastoutside');
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
saveas(gcf,'SF8d','tiffn')

hold off



