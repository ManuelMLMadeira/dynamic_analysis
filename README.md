## Dynamic  Analysis of Human Movement

### Gait and Standing Long Jump

Computational implementation of the dynamical analysis of human movements. In particular, in this repository, a multibody biomechanical analysis is performed to study the gait cycle and the standing long jump.

The methods and pipeline used are extensively described in the ***report.pdf*** file. 

---
### Code:

#### [**Dynamic Analysis**](computational_implementation/dynamic_analysis)
Inside computational_implementation/dynamic_analysis you can find our dynamic analysis implementation:

1) Run script ***Preprocessing.m***. A choice window will pop up and the gait.xlsx or the ***jump.xlsx*** should be picked;

2) A new pop-up will appear and the ***gaitF1.tsv*** or the ***jumpF1.tsv*** should be picked. The choice must be coherent with the file chosen in 1);

3) Run ***DynamicsAnalysis.m***. A choice window will pop up and the ***BiomechanicalModel_gait.txt*** or the ***BiomechanicalModel_jump.txt*** should be picked.

Note that for each of these steps, the choice of the aforementioned files will lead to the analysis of the respective motion. For the analysis of the alternative file, please repeat the steps for the other files.


#### [**Electromyography (EMG)**](computational_implementation/emg)

Steps to obtain EMG Results:

1) Open ***Read_EMG.m*** in MATLAB;

2) Run the first section and choose one (any of the two) of the GAIT or JUMP .txt files if you want to observe the gait or standing long jump results EMG respectively;
   
3) Run the 2nd section if you chose any of the GAIT .txt files in step 2), or run the 3rd and 4th sections if you chose any of the JUMP .txt files in step 2).