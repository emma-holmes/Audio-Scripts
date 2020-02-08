# Audio-Scripts
Miscallaneous scripts for auditory / hearing / speech research
* BATCH_pitchShift
* BATCH_normalise_RMS_amp
* plot_audiogram

## License
These scripts are licensed under the GNU General Public License v3.0; see the [LICENSE](LICENSE) file for details.




## BATCH_pitchShift
This script is designed for editing the pitch and formant spacing of audio files. The script will find all .wav files within the specified directory and create new versions of every file, which is saved in a new subdirectory (so you don't need to worry about overwriting files). When the script is run, it generates a form, which enables the user to specify the directory, the magnitude of the pitch shift (or 0 if no pitch shift), and the desired formant ratio (specify 1 to maintain original formant spacing).
<br><br>
The script gives users the option to specify the pitch shift in 4 different ways:
1) Absolute value in Hertz
2) Percentage change (e.g. if you wanted a 20% increase or decrease in pitch)
3) Semitones
4) ERBs (based on Glasberg & Moore, 1990, Hearing Research). I have implemented this by calculating the ERB at the average F0 of the original stimulus, then adding (or subtracting) this bandwidth, which becomes the average F0 of the new stimulus. If 2 ERBs are specified, then the script changes by 1 ERB, recalculates the ERB at the new F0, then modifies it by the new bandwidth.
<br><br>
The magnitude of the pitch shift will depend on the method specified above. For example, if "Hertz" is selected, then entering 50 as an input will shift the pitch upwards by 50 Hz. To specify pitches lower than the original, enter a negative number.

### Prerequisites
This script can be run using Praat, which can be installed from the following link: [http://www.fon.hum.uva.nl/praat/](http://www.fon.hum.uva.nl/praat/)
<br>
The script was tested using Praat version 6.0.36 for Windows.

### Running the script
To use, download the [BATCH_pitchShift](BATCH_pitchShift) script, open the script in Praat, then select Run from the toolbar.




## BATCH_normalise_RMS_amp
This script takes all .wav files in a specified directory, normalises the RMS amplitude, and saves them into a new subdirectory.

### Prerequisites
This is a MATLAB script, tested using MATLAB R2017a. The [normalise_RMS_amp.m](normalise_RMS_amp.m) script should be in the MATLAB path.

### Running the script
Use as: <br>
BATCH_normalise_RMS_amp(DIR, RMS)
<br><br>
e.g., <br>
BATCH_normalise_RMS_amp(pwd, 0.05)
<br><br>
The script takes the following inputs:
| Input       | Description   |
|-------------|---------------|
| DIR         | String specifying the directory containing files to modify. |
| RMS         | RMS amplitude value (number between 0 and 1). Leave empty to display average RMS amplitude of files in directory before user input.|




## plot_audiogram
This script plots audiometric thresholds on a graph. Plots worse frequencies towards the bottom of the graph.

### Prerequisites
This is a MATLAB script, tested using MATLAB R2017a. The [format_graph.m](format_graph.m) script should be in the MATLAB path.

### Running the script
Use as: <br>
hFig = plot_audiogram(hFig, freq, threshs, xLimits, yLimits, plotColour, ind_threshs, ind_colour, save_file)
<br><br>
e.g., <br>
hFig = plot_audiogram([], [250, 500, 1000, 2000, 4000, 8000], [5, 5, 5, 10, 5, 10], [200, 8050], [-10, 80], 'k', [], [], 'audiogram_plot')
<br><br>
The script takes the following inputs:
| Input       | Description   |
|-------------|---------------|
| hFig        | Handle for figure or axis. To create new, pass empty vector. |
| freq        | Vector containing frequencies to plot.|
| threshs     | Vector containing threshold values to plot. |
| xLimits     | 2-element vector containing upper and lower bounds of x-axis (frequencies). Default = [0, 8000]. |
| yLimits     | 2-element vector containing upper and lower bounds of y-axis (thresholds). Default = [-10, 60]. |
| plotColour  | MATLAB ColorSpec, e.g., 'r' or [1, 0, 0]. |
| ind_threshs | N x freq matrix specifying thresholds for individual  participants to plot on graph. If empty, does not plot individual participants. |
| ind_colour  | N x 3 matrix of RGB color values, corresponding to the individual thresholds specified in ind_thresh. |
| save_file   | String containing filepath to save plot. If empty vector passed, plot not saved. |
