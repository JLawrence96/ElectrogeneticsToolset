%%%%%%%%%%%%%%%%%%%
%RPU_Calibrants
%%%%%%%%%%%%%%%%%%%

%% Import
RPU_raw = csvread('RPU_raw.csv');

%% Statistics
RPU_categories = size(RPU_raw,1);
RPU_conditions = size(RPU_raw,2);

RPU_blanked = RPU_raw(1:2:RPU_categories,:)-RPU_raw(2:2:RPU_categories,:);
RPU_blanked(RPU_blanked<0) = 0;
RPU_normalised = RPU_blanked(:,(RPU_conditions/2)+1:RPU_conditions)./RPU_blanked(:,1:RPU_conditions/2);

DH5a_GFP_RPU = mean(RPU_normalised(1,1:3))
DH5a_RFP_RPU = mean(RPU_normalised(2,1:3))
DJ901_GFP_RPU = mean(RPU_normalised(3,1:3))
BL21_GFP_RPU = mean(RPU_normalised(4,1:3))
MDS42_GFP_RPU = mean(RPU_normalised(5,1:3))
Vnat_GFP_RPU = mean(RPU_normalised(6,1:3))
DH5aM9_GFP_RPU = mean(RPU_normalised(7,1:3))

