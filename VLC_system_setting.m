%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Used in VLC_ray_tracing_main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%
% Room Size 
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ceiling height
H = 3; 
% Room Width
W = 5;
% Room Length
L = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmitter
%%%%%%%%%%%%%%%%%%%%%%%%%%
% VLC transmitter position
%Tx = [2.5,2.5,3];
% Transmitter Mode number
mode_n = 1;
% Emitting Power
P_emitted = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Receiver
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VLC receiver position (we assume the receiver faces up (to the ceiling))
%Rx =[1,1,1];
% Receiver Area (1 cm^2)
Ar = pi*(0.015)^2;
% Field of View (85 degree)
FOV = 85/180*pi;

% Number of Generated Rays (100000 takes 2 hours to finish)
N = 100;

% Number of reflections considered 
Rf = 3;


frequency_min             = 0e6;    	% Min frequency (Hz) to use
frequency_max             = 60e6;    	% Max frequency (Hz) to use 

frequency_granularity     = 24.414e3;    	% Granularity (Hz) in the frequency
