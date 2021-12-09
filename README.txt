%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Supplementary Code for: J. M. Lawrence et. al. "An Expanded Toolset for Electrogenetics" (2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

1) Raw data files for each figure are contained within .csv files. E.g. F2e_raw.csv contains the data displayed in figure 2e
2) Code for processing data and plotting figures are contained within .m files. E.g F2e.m processes F2e_raw.csv to create figure 2e
3) Code for fitting response functions are contained within the linear_response.m (for non-responsive contructs), dose_response.m (for responsive Uni-PsoxS & Activator constructs) & inverse_response.m (for responsive Inverter constructs)
4) Other .m files are functions created by others which were used to process and plot data:
	i) Rob Campbell (2021). raacampbell/shadedErrorBar (https://github.com/raacampbell/shadedErrorBar), GitHub. Retrieved August 21, 2021.
	ii) Ameya Deoras (2021). Customizable Heat Maps (https://www.mathworks.com/matlabcentral/fileexchange/24253-customizable-heat-maps), MATLAB Central File Exchange. Retrieved August 21, 2021.
	iii) Stephen Cobeldick (2021). ColorBrewer: Attractive and Distinctive Colormaps (https://github.com/DrosteEffect/BrewerMap), GitHub. Retrieved August 21, 2021.
	iv) Martina Callaghan (2021). barwitherr(errors,varargin) (https://www.mathworks.com/matlabcentral/fileexchange/30639-barwitherr-errors-varargin), MATLAB Central File Exchange. Retrieved August 21, 2021.

For any support please email jml203@cam.ac.uk 