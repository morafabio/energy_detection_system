clear all
close all
clc

addpath('/home/beams/repos/thesis_ulb/Matlab_scripts/matlab_utils-master')


%% Read from the file
Nsamples=1024;

inFileMatlab = fopen('./results_binary_matlab.txt','r');
inFileSim = fopen('./results_sim.txt','r'); %simulation results with ip cores FIR

Y=read_complex_binary(file);  %complex signal read from the file


%for j=1:6999
    resultsSim = fscanf(inFileSim,'%d,%d',[2 Inf]);
    resultMat= fscanf(inFileMatlab,'%d',[6999]);
    resultsSim=resultsSim';
%end

%% Decoding the samples valuesSim
nb=16;


%% FFT on the samples created
fc=100e3; %cut-off frequencySim
fs=10e6;   %sample rate frequency
N=1024;
T=[0:1/(fs):N/fs];


M=1024;     %number of points
fo = fs/M;                           %frequency resolution
f= (-(M-1)/2:(M-1)/2)*fo ;                       %frequency points for plotting

for(j=0:1:3)

figure(1);
subplot(3,1,1)
plot(f./1e6,abs(fftshift(resultMat([j*N+1: j*N+N],1))),'r')
title("SQM Matlab")
xlabel("f")
ylabel("|Y|²")

subplot(3,1,2)
plot(f./1e6,abs(fftshift(resultsSim([j*N+1:j*N+N],2))),'b')
title("SQM Simulation")
xlabel("f")
ylabel("|Y|²")

subplot(3,1,3)
plot(f./1e6,abs(fftshift(resultsSim([j*N+1:j*N+N],1))),'b')
title("Detection")
xlabel("f")
ylabel("|Y|²")


pause()
end
