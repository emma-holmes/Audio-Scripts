function BATCH_normalise_RMS_amp(DIR, RMS)
% BATCH_normalise_RMS_amp(DIR, RMS)
%       DIR         String specifying the directory containing files to
%                   modify.
%       RMS         RMS amplitude value (number between 0 and 1). Leave
%                   empty to display average RMS amplitude of files in
%                   directory before user input.
%
% This script takes all .wav files in a specified directory, normalises 
% the RMS amplitude, and saves them into a new subdirectory.
%
% Emma Holmes
% Created on 12/06/2015
% Last updated 09/05/2019


% Find wav files in specified directory
wavSpec = fullfile(DIR, '*.wav');
wavFilenames = dir(wavSpec);
nFiles = numel(wavFilenames);

% If no value entered for RMS, then print mean to console, then ask for
% user input
if isempty(RMS)
    % Get RMS of all files in directory
    fprintf('\nAnalysing files in directory...\n');
    averageRMS = zeros(1, nFiles);
    for i = 1:nFiles   
        % Read wav file
        [waveform, srate] = audioread(sprintf('%s\\%s', DIR, ...
            char(wavFilenames(i).name))); %#ok<ASGLU>
        
        % Calculate current RMS value of waveform
        averageRMS(i) = sqrt(mean(waveform.^2));
    end
    averageRMS = mean(squeeze(averageRMS));
    fprintf('\nAverage RMS of files in directory = %.4f\n', averageRMS);

    % User inputs RMS value to scale files to
    RMS = input('Please specify desired RMS value: ');
end

% Create output directory
outputDir = sprintf('%s\\normalise_RMS_to_%.3f', DIR, RMS);
if ~exist(outputDir, 'dir')
    if ~mkdir(outputDir)
        error('Error: Could not create output directory')
    end
end

% Modify RMS and save to output directory
reverseStr = ''; % variable to control console printing
for i = 1:nFiles
    % Print progress
    msg = sprintf('Analysing file %d of %d', i, nFiles);
    fprintf([reverseStr msg]);
    reverseStr = repmat(sprintf('\b'),1,length(msg));
    
    % Call amplitude normalisation script
    normalise_RMS_amp(sprintf('%s\\%s', DIR, char(wavFilenames(i).name)), ...
        RMS, sprintf('%s\\%s', outputDir, char(wavFilenames(i).name)))
end

fprintf('\nScript finished.\n');