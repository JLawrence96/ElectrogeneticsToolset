%%%%%%%%%%%%%%%%%%%
%Fig 6c = Inverter Echem Results
%%%%%%%%%%%%%%%%%%%

%Dependencies = barwitherr.m

%% Import
F6c_raw = csvread('F6c_raw.csv');

%% Statistics
F6c_conditions = size(F6c_raw,2)-6;

for i = 0:3:3;
    F6c_blanked(:,1+i:3+i) = F6c_raw(:,1+i:3+i) - F6c_raw(:,7:9);
    F6c_blanked(:,7+i:9+i) = F6c_raw(:,10+i:12+i) - F6c_raw(:,16:18);
end

F6c_blanked(F6c_blanked<0) = 0;
F6c_normalised = F6c_blanked(:,1:F6c_conditions/2) ./ F6c_blanked(:,((F6c_conditions/2)+1):F6c_conditions);
F6c_foldchange = F6c_normalised(2,:) ./ F6c_normalised(1,:)

F6c_mean(1) = mean(F6c_foldchange(1:3));
F6c_mean(2) = mean(F6c_foldchange(4:6));
F6c_std(1) = std(F6c_foldchange(1:3),0,2);
F6c_std(2) = std(F6c_foldchange(4:6),0,2);

%% Plotting
y_val = F6c_mean';
y_eb = F6c_std';

[bF6c eF6c] = barwitherr(y_eb,y_val,0.45);
hold on;

%% Formatting
box off;

set(bF6c,'FaceColor',[0.836 0.855 0.09])
set(bF6c(:),'EdgeColor',[0 0 0])
set(bF6c(:),'LineWidth',3)
set(eF6c(:),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','off','YMinorTick','on');
set(gca,'XTick',[]);


xlim([0.5 2.5]); %Removed 2
ylim([0 3]);
ylabel({'Output (Fold-Change)',' '});

xh = get(gca,'xlabel') 
p = get(xh,'position') 
p(2) = 1*p(2);    
set(xh,'position',p)
   
set(gcf, 'Position',  [100, 100, 1100, 1000])
saveas(gcf,'F6c','tiffn')

hold off