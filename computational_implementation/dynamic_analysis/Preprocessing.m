% Adapted for Dynamics 

clear all; close all; clc;
global Data file 

ReadDraftInput('Model.txt');

StaticData= ReadProcessData('static');

ComputeAverageLengths(StaticData);

ComputeBodyProperties();

% Choose motion
[file,~] = uigetfile('*.xlsx','Choose gait or jump');
file = file(1:end-5);

% Read data
Data = ReadProcessData(file);

% Compute positions and angles of bodies
EvaluatePositions(Data);

% Evaluate drivers
EvaluateDrivers(Data);

%Ground reaction forces
ReadGRF(Data.fs);

% Updates the date in files to be read by the kinematic analysis
WritesModelInput(strcat('BiomechanicalModel_',file,'.txt'));


