function normalise_RMS_amp(audioFilepath, RMSout, outputFilepath)
% normaliseRMSamp(audioFilepath, RMSout, outputFilename)
%       audioFilepath  	String specifying the path and filename of the
%                       audio file to read into the script.
%       RMSout          Number to specify the desired RMS of the output
%                       audio file (including extension, e.g., .wav).
%       outputFilepath  String specifying the path and filename of the 
%                       output audio file (including extension, e.g., 
%                       .wav).
%
% This function takes an input audio file, changes the RMS amplitude, and
% saves the output.
%
% Emma Holmes
% Created on 12/06/2015
% Last updated 09/05/2019

% Read wav file
try
    [waveform, srate] = audioread(audioFilepath);
catch err
    fprintf('\n\nSearching for file: %s\n', audioFilepath);
    rethrow(err)
end
% Calculate current RMS value of waveform
fileRMS = sqrt(mean(waveform.^2));

% Scale the waveform to match the desired RMS
rmsratio = RMSout / fileRMS;
waveform = waveform * rmsratio;

% Write the modified waveform
audiowrite(outputFilepath, waveform, srate);

end