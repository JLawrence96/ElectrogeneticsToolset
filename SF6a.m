%%%%%%%%%%%%%%%%%%%
%Fig S6a = Hydrogen Peroxide Mediator Response Curve
%%%%%%%%%%%%%%%%%%%

%Dependencies = RPU.m, linear_response.m

%% Import
SF6a_raw = csvread('SF6a_raw.csv');

%% Statistics
SF6a_categories = size(SF6a_raw,1)-3;
SF6a_conditions = size(SF6a_raw,2);

for i = 3:3:SF6a_conditions/2;
SF6a_concentrations_act(i/3) = SF6a_raw(1,i);
end;

SF6a_blanked(1:2,:) = SF6a_raw(2:3,:)-SF6a_raw(4,:);
SF6a_blanked(SF6a_blanked<0) = 0;
SF6a_normalised = SF6a_blanked(:,(SF6a_conditions/2)+1:SF6a_conditions)./SF6a_blanked(:,1:SF6a_conditions/2);
SF6a_RPU = SF6a_normalised./DJ901_GFP_RPU;

for j = 1:1:SF6a_conditions/6;
    SF6a_mean(:,j) = mean(SF6a_RPU(:,(j*3)-2:j*3),2);
    SF6a_std(:,j) = std(SF6a_RPU(:,(j*3)-2:j*3),0,2);
end

%% Curve Fitting and Plotting

for k = 1;
    
x_val = SF6a_concentrations_act;
x_valplot = x_val;
x_valplot(1) = x_valplot(2)/10*3;
y_val = SF6a_mean(k,:);
y_eb = SF6a_std(k,:);

type linear_response

fun = @(A)linear_response(A,x_val,y_val);

A0 = [((max(y_val)-y_val(1))/(max(SF6a_concentrations_act)-SF6a_concentrations_act(1))) y_val(1)];
bestA = fminsearch(fun,A0);
m(k) = bestA(1)
c(k) = bestA(2)

x_fit = linspace(x_val(2)/10*5,x_val(length(x_val)),10000);
y_fit = m(k).*x_fit + c(k);

fSF6a(k) = semilogx(x_fit,y_fit)
hold on

eSF6a(k) = errorbar(x_valplot,y_val,y_eb,'ok')
hold on

end


%% Formatting
box off;

set(fSF6a,'Color',[0.766 0 0])
set(fSF6a,'LineWidth',3)

set(eSF6a,'MarkerFaceColor',[0.766 0 0])
set(eSF6a,'MarkerEdgeColor',[0.766 0 0])
set(eSF6a,'MarkerSize',10)
set(eSF6a,'LineWidth',3)

set(gca, 'FontName', 'Helvetica Ltd Std');
set(gca,'TickDir','out');
set(gca,'fontsize',44);
set(gca,'FontWeight','normal');
set(gca,'LineWidth',3);
set(gca,'XMinorTick','on','YMinorTick','on');

xticks([10^-2,10^-1,10^-0,10^1,10^2,10^3]);
xticklabels({' ','10^{-1}','10^{0}','10^1','10^2','10^3'});
xlim([0.12 4]);
ylim([0 1]);
xlabel({'[Hydrogen Peroxide] (mM)'});
ylabel({'Output (RPU)'});
legend([fSF6a],' Act106 (DH5α)','location','northwest');
legend('boxoff')
 
pbaspect([1 1 1])
set(gcf, 'Position',  [100, 100, 1000, 1000])
saveas(gcf,'SF6a','tiffn')

hold off
