%%%%%%%%%%%%%%%%%%%
%Fig 2g = Uni-pSoxS Response Curve
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, linear_response.m, dose_response.m

%% Import
F2g_raw = csvread('F2g_raw.csv');

%% Statistics
F2g_categories = size(F2g_raw,1)-2;
F2g_conditions = size(F2g_raw,2);

for i = 3:3:F2g_conditions/2;
F2g_concentrations(i/3) = F2g_raw(1,i);
end;

F2g_blanked = F2g_raw(2:F2g_categories+1,:)-F2g_raw(F2g_categories+2,:);
F2g_blanked(F2g_blanked<0) = 0;
F2g_normalised = F2g_blanked(:,(F2g_conditions/2)+1:F2g_conditions)./F2g_blanked(:,1:F2g_conditions/2);
F2g_RPU = F2g_normalised./DH5a_GFP_RPU;

for j = 1:1:F2g_conditions/6;
    F2g_mean(:,j) = mean(F2g_RPU(:,(j*3)-2:j*3),2)
    F2g_std(:,j) = std(F2g_RPU(:,(j*3)-2:j*3),0,2)
end
        

for k = 1;
    
x_val = F2g_concentrations;
x_valplot = x_val;
x_valplot(1) = x_valplot(2)/10*3;
y_val = F2g_mean(k,:);
y_eb = F2g_std(k,:);

type linear_response

fun = @(A)linear_response(A,x_val,y_val);

A0 = [((max(y_val)-y_val(1))/(max(F2g_concentrations)-F2g_concentrations(1))) y_val(1)];
bestA = fminsearch(fun,A0);
m(k) = bestA(1)
c(k) = bestA(2)

x_fit = linspace(x_val(2)/10*5,x_val(length(x_val)),10000);
y_fit = m(k).*x_fit + c(k);

fF2g(k) = semilogx(x_fit,y_fit)
hold on

eF2g(k) = errorbar(x_valplot,y_val,y_eb,'ok')
hold on

end

for l = 3:1:F2g_categories;
    
x_val = F2g_concentrations;
x_valplot = x_val;
x_valplot(1) = x_valplot(2)/10*3;
y_val = F2g_mean(l,:);
y_eb = F2g_std(l,:);

type dose_response

fun = @(A)dose_response(A,x_val,y_val);

A0 = [2 2];
bestA = fminsearch(fun,A0);
n(l-2) = bestA(1);
K(l-2) = bestA(2);

y_test = y_val(1) + ((max(y_val) - y_val(1)) .* (x_val.^n(l-2) ./ (K(l-2)^n(l-2) + x_val.^n(l-2))));
SSE = sum((y_val-y_test).^2);
SST = sum((y_val-mean(y_val)).^2);

x_fit = linspace(x_val(2)/10*5,x_val(length(x_val)),10000)
y_fit = y_val(1) + ((max(y_val) - y_val(1)) .* (x_fit.^n(l-2) ./ (K(l-2)^n(l-2) + x_fit.^n(l-2))))


fF2g(l) = semilogx(x_fit,y_fit)
hold on
eF2g(l) = errorbar(x_valplot,y_val,y_eb,'ok')
hold on

end

F2g_n = n
F2g_K = K
F2g_y0 = F2g_mean(l,1)
F2g_y_minmax = max(F2g_mean(l,:))
F2g_Dynamic_range = F2g_y_minmax / F2g_y0
F2g_R_squared = 1 - SSE/SST
%% Formatting
box off;

set(fF2g(1),'Color',[0.5 0.5 0.5])
set(fF2g(3),'Color',[0.008 0.617 0.923])
set(fF2g(1),'LineWidth',3)
set(fF2g(3),'LineWidth',3)

set(eF2g(1),'MarkerFaceColor',[0.5 0.5 0.5])
set(eF2g(3),'MarkerFaceColor',[0.008 0.617 0.923])
set(eF2g(1),'MarkerEdgeColor',[0.5 0.5 0.5])
set(eF2g(3),'MarkerEdgeColor',[0.008 0.617 0.923])
set(eF2g(1),'MarkerSize',7)
set(eF2g(3),'MarkerSize',7)
set(eF2g(1),'LineWidth',3)
set(eF2g(3),'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xticks([10^-2,10^-1,10^0,10^1,10^2]);
xticklabels({' ','10^{-1}','10^0','10^1','10^2'});
xlim([3*10^-2 4*10^1]);
ylim([0 1]);
xlabel({'[Pyocyanin] (\muM)'});
ylabel({'Output (RPU)'});
legend([fF2g(1) fF2g(3)],' NC',' Uni-P\it{sox}S','location','northwest');
legend('boxoff')

pbaspect([1 1 1])
set(gcf, 'Position',  [100, 100, 1050, 1050])
saveas(gcf,'F2g','tiffn')

hold off