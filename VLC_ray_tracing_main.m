function [f_query,vlc_frequency_gain]=VLC_ray_tracing_main(Tx,Rx)

%% This is the Modified Monte Carlo Ray-tracing Method to generate the VLC channel impulse reponse of a indoor environment
%  Algorithm: Lo, Francisco J., and Rafael Pe. "Ray-tracing algorithms for fast calculation of the channel impulse response
%  on diffuse IR wireless indoor channels." Optical engineering 39.10 (2000): 2775-2780.

% Reference paper: Chowdhury, M. I., Weizhi Zhang, and Mohsen Kavehrad. "Combined Deterministic and Modified Monte Carlo 
% Method for Calculating Impulse Responses of Indoor Optical Wireless Channels." Journal of Lightwave Technology 32.18 (2014): 3132-3148.

% author@mhrex(Hao MA) Sep.22,2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic

VLC_system_settings


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Better not to change the code below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Pr_array = [];
t_array = [];
k = 0;

% LOS contribution made by the LED emitter 
[Pr_LOS,t_LOS] = ContributionCalculator(Tx,P_emitted/N,[0,0,-1],Rx,Ar,FOV,mode_n);
% Pr_LOS = 0;
% t_LOS = 0;
while (k < N)
    k;
    
    source = Tx;
    
    P = P_emitted/N;
 
    % calculate the direction from the LED emitter (local coordinate system)
    [emitting_direction_local] = DirectionGenerator(mode_n);     
    
    %%%%%comment these two lines we get only NLOS%%%%%%%%%%%
     Pr_array = [Pr_array Pr_LOS];
     t_array = [t_array t_LOS];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    t_refl = 0;
    
    % count the number of reflections
    r = 0; 
    
    while(r < Rf)

       emitting_direction_room = CoordinateConverter(emitting_direction_local,WhichSide(source, L, W, H));
       
       % strike the obstacle at one point and this point becomes a new source
       [source,t1,wall,wallvector] = ImpactPointFind(source,emitting_direction_room, L, W, H);
       
       % reflection attenuation
       if strcmp(wall,'floor')
           rho = 0.73;
       else
           rho = 0.73;
       end
       P = rho*P;
       
       % NLOS contribution of the r-th reflection
       [Pr,t2]=ContributionCalculator(source,P,wallvector,Rx,Ar,FOV,mode_n);
       
       % record the time that has passed for each reflection
       t_refl = t_refl+t1; 
       
       Pr_array = [Pr_array Pr];
       % remeber to add the time t2
       t_array = [t_array t_refl+t2]; 
      
       emitting_direction_local = DirectionGenerator(mode_n);
       
       r=r+1;
       
    end
    
       k=k+1;  
end

[sorted_t, index]=sort(t_array);
sorted_Pr = Pr_array(index);

t_final = [];
Pr_final = [];

toc
%% Data Processing and Plotting
c1 = 1; 
c2 = 0;
% time resolution
TIME_BIN = 1*10^-9;

length_t = length(sorted_t);

while(c1<=length_t)
    
    temp_m = [];
    while((c1<=length_t)&&(sorted_t(c1)<TIME_BIN*(c2+1)))
        temp_m=[temp_m c1];
        c1=c1+1;
    end
    
    t_final = [t_final TIME_BIN*c2];
    
    if(isempty(temp_m))
        Pr_final = [Pr_final 0];
    else
        Pr_final = [Pr_final sum(sorted_Pr(temp_m))];
    end
    
    c2=c2+1;
end 

% temp_t = 0;
% while(temp_t<1)
% t_final = [t_final t_final(length(t_final))+0.2*10^-9];
% Pr_final = [Pr_final 0];
% temp_t=temp_t+1;
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Impulse response in time domain
%%%%%%%%%%%%%%%
% figure(1)
% plot((10^9)*t_final,Pr_final,'-')
% title('Indoor VLC Impulse Response h(t) in time domain')
% xlabel('Time (ns)')
% ylabel('h(t) Amplitude')
% grid


Fs = 1/TIME_BIN;

NFFT = 2^nextpow2(length(t_final));

Y = fft(Pr_final,NFFT);

%Y = fft(Pr_final,NFFT)/NFFT;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Impulse response in frequency domain (single-sided amplitude spectrum)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot(f/10^6,2*abs(Y(1:NFFT/2+1)));
% axis([0 60e6])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_query = [frequency_min:frequency_granularity:frequency_max];
vlc_frequency_gain=interp1(f,2*abs(Y(1:NFFT/2+1)),f_query,'linear');

plot(f_query/10^6,vlc_frequency_gain) 
%axis([0 60e6])
hold on;

% figure(3)
% plot(f/10^6,angle(Y(1:NFFT/2+1))) 
title('Indoor VLC Impulse Response H(f) in the frequency domain')
xlabel('Frequency (MHz)')
ylabel('|H(f)|')
grid
