%%%%%%%%%%%%%%%%%%%
%Fig 5a = MV Mediator Response Curve
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, dose_response.m, inverse_response.m

%% Import
F5a_raw = csvread('F5a_raw.csv');

%% Statistics
F5a_categories = size(F5a_raw,1)-3;
F5a_conditions = size(F5a_raw,2);

for i = 3:3:F5a_conditions/2;
F5a_concentrations_act(i/3) = F5a_raw(1,i);
F5a_concentrations_inv(i/3) = F5a_raw(5,i);
end;

F5a_blanked(1:2,:) = F5a_raw(2:3,:)-F5a_raw(4,:);
F5a_blanked(3:4,:) = F5a_raw(6:7,:)-F5a_raw(8,:);
F5a_blanked(F5a_blanked<0) = 0;
F5a_normalised = F5a_blanked(:,(F5a_conditions/2)+1:F5a_conditions)./F5a_blanked(:,1:F5a_conditions/2);
F5a_RPU(1:2,:) = F5a_normalised(1:2,:)./DJ901_GFP_RPU;
F5a_RPU(3:4,:) = F5a_normalised(3:4,:)./DH5a_GFP_RPU;

for j = 1:1:F5a_conditions/6;
    F5a_mean(:,j) = mean(F5a_RPU(:,(j*3)-2:j*3),2);
    F5a_std(:,j) = std(F5a_RPU(:,(j*3)-2:j*3),0,2);
end

%% Curve Fitting and Plotting
l = 2;
m = 4;

x_val_act = F5a_concentrations_act;
x_valplot_act = x_val_act;
y_val_act = F5a_mean(l,:);
y_eb_act = F5a_std(l,:);

x_val_inv = F5a_concentrations_inv;
x_valplot_inv = x_val_inv;
y_val_inv = F5a_mean(m,:);
y_eb_inv = F5a_std(m,:);

x_valplot_act(1) = 0.1;
x_valplot_inv(1) = 0.1;
x_valend_act = max([x_valplot_act x_valplot_inv]);
x_valend_inv = max([x_valplot_act x_valplot_inv]);

for l = 2;
    
type dose_response

fun = @(A)dose_response(A,x_val_act,y_val_act);

A0 = [2 2 2];
bestA = fminsearch(fun,A0);
n(l/2) = bestA(1);
K(l/2) = bestA(2);

y_test = y_val_act(1) + ((max(y_val_act) - y_val_act(1)) .* (x_val_act.^n(l/2) ./ (K(l/2)^n(l/2) + x_val_act.^n(l/2))));
SSE(l/2) = sum((y_val_act-y_test).^2);
SST(l/2) = sum((y_val_act-mean(y_val_act)).^2);

x_fit_act = linspace(x_valplot_act(1)*2,x_valend_act,10000);
y_fit_act = y_val_act(1) + ((max(y_val_act) - y_val_act(1)) .* (x_fit_act.^n(l/2) ./ (K(l/2)^n(l/2) + x_fit_act.^n(l/2))));

fF5a(l/2) = loglog(x_fit_act,y_fit_act);
hold on
eF5a(l/2) = errorbar(x_valplot_act,y_val_act,y_eb_act,'ok');
hold on

end


for m = 4;

type inverse_response

fun = @(A)inverse_response(A,x_val_inv,y_val_inv);

A0 = [2 2];
bestA = fminsearch(fun,A0);
n(m/2) = bestA(1);
K(m/2) = bestA(2);

y_test = y_val_inv(1) - ((y_val_inv(1) - min(y_val_inv)) .* (x_val_inv.^n(m/2) ./ (K(m/2)^n(m/2) + x_val_inv.^n(m/2))));
SSE(m/2) = sum((y_val_inv-y_test).^2);
SST(m/2) = sum((y_val_inv-mean(y_val_inv)).^2);

x_fit_inv = linspace(x_valplot_inv(1)*2,x_valend_inv,10000);
y_fit_inv = y_val_inv(1) - (y_val_inv(1) - min(y_val_inv)) .* (x_fit_inv.^n(m/2) ./ (K(m/2)^n(m/2) + x_fit_inv.^n(m/2)));


fF5a(m/2) = loglog(x_fit_inv,y_fit_inv);
hold on
eF5a(m/2) = errorbar(x_valplot_inv,y_val_inv,y_eb_inv,'ok');
hold on

end

F5a_n = n
F5a_K = K
F5a_y0 = [F5a_mean(l,1) F5a_mean(m,1)]
F5a_y_minmax = [max(F5a_mean(l,:)) min(F5a_mean(m,:))]
F5a_Dynamic_range = [(F5a_y_minmax(1) / F5a_y0(1)) (F5a_y0(2) / F5a_y_minmax(2))] 
F5a_R_squared = 1 - SSE./SST


%% Formatting
box off;

set(fF5a(1),'Color',[0.766 0 0])
set(fF5a(2),'Color',[0.836 0.855 0.09])
set(fF5a(1),'LineWidth',3)
set(fF5a(2),'LineWidth',3)

set(eF5a(1),'MarkerFaceColor',[0.766 0 0])
set(eF5a(2),'MarkerFaceColor',[0.836 0.855 0.09])
set(eF5a(1),'MarkerEdgeColor',[0.766 0 0])
set(eF5a(2),'MarkerEdgeColor',[0.836 0.855 0.09])
set(eF5a(1),'MarkerSize',10)
set(eF5a(2),'MarkerSize',10)
set(eF5a(1),'LineWidth',3)
set(eF5a(2),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xticks([10^-2,10^-1,10^-0,10^1,10^2]);
xticklabels({' ','10^{-1}','10^{0}','10^1','10^2'});
xlim([0.1 200]);
ylim([0.01 6]);
xlabel({'[Methyl Viologen] (\muM)'});
ylabel({'Output (RPU)'});
legend([fF5a(1) fF5a(2)],' Act106 (DJ901)',' Inv106 (DH5α)','location','northwest');
legend('boxoff')
 
pbaspect([1 1 1])
set(gcf, 'Position',  [100, 100, 1000, 1000])
saveas(gcf,'F5a','tiffn')

hold off
