function [EmittingDirection] = DirectionGenerator (mode_n)
% EmittingDirection is using the local coordinate system
% mode number: mode_n

% author@mhrex(Hao MA) Nov.14,2014

rng('shuffle');
U = rand;
V = rand;

z = U^(1/(mode_n+1));

x = sqrt(1-z^2)*cos(2*pi*V);

y = sqrt(1-z^2)*sin(2*pi*V);


EmittingDirection = [x,y,z];
