%%%%%%%%%%%%%%%%%%%
%Fig S9a = Pyo M9 Mediator Response Curve
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, inverse_response.m

%% Import
SF9a_raw = csvread('SF9a_raw.csv');

%% Statistics
SF9a_categories = size(SF9a_raw,1)-3;
SF9a_conditions = size(SF9a_raw,2);

for i = 3:3:SF9a_conditions/2;
SF9a_concentrations_inv(i/3) = SF9a_raw(1,i);
end;

SF9a_blanked = SF9a_raw(2,:)-SF9a_raw(3,:);
SF9a_blanked(SF9a_blanked<0) = 0;
SF9a_normalised = SF9a_blanked(:,(SF9a_conditions/2)+1:SF9a_conditions)./SF9a_blanked(:,1:SF9a_conditions/2);
SF9a_RPU = SF9a_normalised./DH5aM9_GFP_RPU;

for j = 1:1:SF9a_conditions/6;
    SF9a_mean(:,j) = mean(SF9a_RPU(:,(j*3)-2:j*3),2);
    SF9a_std(:,j) = std(SF9a_RPU(:,(j*3)-2:j*3),0,2);
end

%% Curve Fitting and Plotting
k = 1;

x_val_inv = SF9a_concentrations_inv;
x_valplot_inv = x_val_inv;
y_val_inv = SF9a_mean(k,:);
y_eb_inv = SF9a_std(k,:);

x_valplot_inv(1) = 0.005;
x_valend_inv = max([x_valplot_inv]);

for k = 1;
    
type inverse_response

fun = @(A)inverse_response(A,x_val_inv,y_val_inv);

A0 = [2 2];
bestA = fminsearch(fun,A0);
n(k) = bestA(1);
K(k) = bestA(2);

y_test = y_val_inv(1) - ((y_val_inv(1) - min(y_val_inv)) .* (x_val_inv.^n(k) ./ (K(k)^n(k) + x_val_inv.^n(k))));
SSE(k) = sum((y_val_inv-y_test).^2);
SST(k) = sum((y_val_inv-mean(y_val_inv)).^2);

x_fit_inv = linspace(x_valplot_inv(1)*2,x_valend_inv,10000);
y_fit_inv = y_val_inv(1) - (y_val_inv(1) - min(y_val_inv)) .* (x_fit_inv.^n(k) ./ (K(k)^n(k) + x_fit_inv.^n(k)));


fSF9a(k) = loglog(x_fit_inv,y_fit_inv);
hold on
eSF9a(k) = errorbar(x_valplot_inv,y_val_inv,y_eb_inv,'ok');
hold on
end

SF9a_n = n
SF9a_K = K
SF9a_y0 = SF9a_mean(k,1)
SF9a_y_minmax = min(SF9a_mean(k,:))
SF9a_Dynamic_range = SF9a_y0 / SF9a_y_minmax
SF9a_R_squared = 1 - SSE./SST

%% Formatting
box off;

set(fSF9a,'Color',[0.836 0.855 0.09])
set(fSF9a,'LineWidth',3)

set(eSF9a,'MarkerFaceColor',[0.836 0.855 0.09])
set(eSF9a,'MarkerEdgeColor',[0.836 0.855 0.09])
set(eSF9a,'MarkerSize',10)
set(eSF9a,'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xticks([10^-3,10^-2,10^-1,10^0,10^1]);
xticklabels({' ','10^{-2}','10^{-1}','10^0','10^1'});
xlim([0.005 20]);
ylim([0.03 3]);
xlabel({'[Pyocyanin] (\muM)'});
ylabel({'Output (RPU)'});
legend([fSF9a],' Inv106 (DH5α)','location','northwest');
legend('boxoff')
 
pbaspect([1 1 1])
set(gcf, 'Position',  [100, 100, 1000, 1000])
saveas(gcf,'SF9a','tiffn')

hold off
