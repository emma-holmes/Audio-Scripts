function [rms_val, save_data] = calibrate_sound_level(wavFile, outFile, desired_level, start_rms)
% [rms_val, save_data] = calibrate_sound_level(wavFile, outFile, ...
%     desired_level, start_rms)
%           wavFile         String specifying name of audio file to play.
%           outFile         String specifying name of file to save outputs.
%           desired_level   Value specifying desired level in dB.
%           start_rms       Specify starting RMS value, if desired, or 
%                           leave empty to start at RMS of file.
%
% Emma Holmes
% Created on 29/03/2018


%% Initialise outputs
headings            = {'Count', 'RMS', 'Level (dB)'};
save_data           = cell(100, numel(headings));
save_data(1,:)  	= headings;
count               = 1;


%% Read audio file
try
    [waveform, FS]	= audioread(wavFile);
catch
    [waveform, FS]	= wavread(wavFile); %#ok<DWVRD>
end


%% Get starting level

% Adjust to desired starting RMS
current_rms         = sqrt(mean(waveform .^ 2));
if ~isempty(start_rms)
    rms_ratio      	= start_rms / current_rms;
    waveform     	= waveform * rms_ratio;
    rms_val         = sqrt(mean(waveform .^ 2));
else
    rms_val         = current_rms;
end

% Play sound
sound(waveform, FS);

% User inputs level
current_level      	= inputdlg('Enter level (dB):');
current_level       = str2double(current_level{1});
save_data(count+1,:)= [{count}, {rms_val}, {current_level}];


%% Adjust RMS until desired level is reached
while (current_level ~= desired_level)
    count    	= count + 1;
    
    % Get user input
    figHeading  = sprintf('Desired level = %.2f dB', desired_level);    
    figText     = sprintf('Current RMS = %.4f, Current level = %.2f dB', ...
        rms_val, current_level);
    fprintf('\n%s', figText);
    choice1     = 'Run automatic adjustment';
    choice2 	= 'Manually enter RMS value';
    choice      = questdlg(figText, figHeading, choice1, choice2, choice2);
    switch choice
        case choice1
            % Automatic adjustment of RMS value
            dB_diff     = desired_level - current_level;
            adjust      = 10 .^ (dB_diff / 20);
            rms_val     = rms_val * adjust;
        case choice2
            % User enters desired RMS
            rms_val     = inputdlg('Enter RMS value:');
            rms_val     = str2double(rms_val{1});
    end
    
    % Change waveform RMS
    current_rms      	= sqrt(mean(waveform .^ 2));
    rms_ratio         	= rms_val / current_rms;
    waveform          	= waveform * rms_ratio; 

    % Play sound
    sound(waveform, FS);

    % User inputs level
    current_level      	= inputdlg('Enter level (dB):');
    current_level       = str2double(current_level{1});
    
    % Store data
    save_data(count+1,:)= [{count}, {rms_val}, {current_level}];    
end


%% End calibration procedure
fprintf('\nCurrent RMS = %.4f, Current level = %.2f dB', ...
    rms_val, current_level);
endTxt  = sprintf('\nCalibration complete. Calibrated RMS value = %.4f\n\n', ...
    rms_val);


%% Check final levels
keepChecking    = 1;
while keepChecking
    
    % Get user input
    figHeading  = sprintf('Calibration complete');    
    figText     = sprintf('Calibration complete! Check levels?');
    choice1     = 'Yes';
    choice2 	= 'End calibration';
    choice      = questdlg(figText, figHeading, choice1, choice2, choice2);
    switch choice
        case choice1
            % Change waveform RMS
            current_rms      	= sqrt(mean(waveform .^ 2));
            rms_ratio         	= rms_val / current_rms;
            waveform          	= waveform * rms_ratio; 

            % Play sound
            sound(waveform, FS);
            
        case choice2
            % End procedure
            keepChecking    = 0;
    end
    
end


%% Save calibration details to file
save_data = save_data(1:count+1, :);
if ~isempty(outFile)
    notes   = inputdlg('Enter notes from this calibration session:'); %#ok<NASGU>
    save(outFile, 'rms_val', 'save_data', 'notes');
end