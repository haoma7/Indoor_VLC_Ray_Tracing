function [P_r,t]=ContributionCalculator(source,P,wallvector,Rx,Ar,FOV,mode_n)
% calculate the power contribution from the "source" point (LED emitter/wall reflector)

% author@mhrex(Hao MA) Nov.14,2014

temp = Rx-source;

d = norm(temp);

out_angle = acos(dot(temp,wallvector)/d);
c = physconst('LightSpeed');
t = d/c;
in_angle = acos(dot(temp,[0,0,-1])/norm(temp));
if (in_angle > FOV)
    P_r = 0;
else
    P_r=(mode_n + 1)*Ar/(2*pi)*P*((cos(out_angle))^mode_n)*cos(in_angle)/(d^2);
end


    
