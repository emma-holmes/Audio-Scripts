function [hFig] = plot_audiogram(hFig, freq, threshs, xLimits, yLimits, plotColour, ind_threshs, ind_colour, save_file)
% [hFig] = plot_audiogram(hFig, freq, threshs, xLimits, yLimits, ...
%    plotColour, PLOT_IND)
%       hFig        Handle for figure or axis. To create new, pass empty
%                   vector.
%       freq        Vector containing frequencies to plot.
%       threshs    	Vector containing threshold values to plot.
%       xLimits     2-element vector containing upper and lower bounds of
%                   x-axis (frequencies).
%       yLimits     2-element vector containing upper and lower bounds of
%                   y-axis (thresholds).
%       plotColour  MATLAB ColorSpec, e.g., 'r' or [1, 0, 0].
%       ind_threshs N x freq matrix specifying thresholds for individual
%                   participants to plot on graph. If empty, does not plot
%                   individual participants.
%       ind_colour  N x 3 matrix of RGB color values, corresponding to the
%                   individual thresholds specified in ind_thresh
%       save_file   String containing filepath to save plot. If empty
%                   vector passed, plot not saved.
%
% Emma Holmes
% Created on 18/04/2018


% Define visual properties of bar graph
markerSize 	= 30;
lineWidth   = 1.5;
indWidth    = 0.5;
xTitle      = 'Frequency (Hz)';
yTitle      = 'Threshold (dB HL)';

% Draw figure
if isempty(hFig)
    hFig 	= figure;
else
    try
        figure(hFig);
    catch
        axis(hFig);
    end
end
hold on;

% Set x- and y-limits to defaults if empty
if isempty(xLimits)
    xLimits	= [0, 8000];
end
if isempty(yLimits)
    yLimits	= [-10, 60];
end

% Draw individual points on graph
if ~isempty(ind_threshs)
    for p = 1 : size(ind_threshs, 1)
        hLine = plot(freq, ind_threshs(p,:), 'Color', ind_colour(p,:), ...
            'Marker', '.', 'MarkerSize', markerSize, 'LineWidth', indWidth);
        uistack(hLine, 'bottom');
    end
end

% Draw thresholds
for t = 1 : size(threshs, 1)
    plot(freq, threshs(t,:), 'Color', plotColour, 'Marker', '.', ...
        'MarkerSize', markerSize, 'LineWidth', lineWidth);
end

% Draw x=0 and y=0
hX = plot([0, 0], yLimits, 'k', 'LineWidth', lineWidth);
hY = plot(xLimits, [0, 0], 'k', 'LineWidth', lineWidth);
uistack([hX, hY], 'bottom');

% Add grid lines
grid(gca, 'on');

% Format graph style
xlim(xLimits);
ylim(yLimits);
format_graph(gca, xTitle, yTitle);
box on;
set(gcf, 'Position', [692, 317, 521, 568])

% Reverse direction of y-axis
set(gca, 'YDir', 'reverse');

% Set x-axis to log scale and set tick labels to frequencies
set(gca, 'XScale', 'log');
xticks(freq);
yticks(yLimits(1) : 10 : yLimits(end));
set(gca, 'GridColor', 'k', 'MinorGridLineStyle', 'none', ...
    'XMinorTick', 'off', 'Layer', 'bottom');

% Save plot
if ~isempty(save_file)
    set(gcf, 'PaperPositionMode', 'auto');
    print(gcf, save_file, '-dtiff', '-r300');
end
