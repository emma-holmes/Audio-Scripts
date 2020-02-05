# Audio-Scripts
Miscallaneous scripts for auditory / hearing / speech research

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
