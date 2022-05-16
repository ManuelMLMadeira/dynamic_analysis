% General Dynamic Analysis Program

clear all; close all; clc;
global tspan 

% Read and preprocess data
ReadInputData();

% Correct the initial conditions
[q,qd] = CorrectInitialConditions();

% Form the initial y vector
y0 = [q;qd];

% Call the Matlab time integrator
% position and velocity at this given time step 
[t,y] = ode45(@FuncEval,tspan,y0);

% Report Results
ReportResults(y,t)