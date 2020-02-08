function format_graph(hAx, xTitle, yTitle)
% format_graph(hAx, xTitle, yTitle)
%       hAx         Axis handle.
%       xTitle    	String containing x-axis title.
%       yTitle  	String containing y-axis title.
%
% Emma Holmes
% Created on 05/01/2018


% Specify figure properties
font        = 'Calibri';
fontSize    = 20;
tickLength  = [.01 .01];
lineWidth   = 1.5;
pos         = [11, 447, 1008, 666];

% x- and y-axis labels
if ~isempty(xTitle)
    hX          = xlabel(xTitle);
    set(hX, 'FontName', font, 'FontSize', fontSize);
end
if ~isempty(yTitle)
    hY          = ylabel(yTitle); 
    set(hY, 'FontName', font, 'FontSize', fontSize);
end

% Format
set(hAx, 'Box', 'off', 'TickDir', 'out', 'TickLength', tickLength, ...
    'LineWidth', lineWidth);
set(hAx, 'FontName', font, 'FontSize', fontSize);
hold off;

% Set position
set(gcf, 'PaperPositionMode', 'auto', 'Position', pos);