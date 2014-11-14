function X = WhichSide(source,L,W,H)

% decide which wall the "source" point belongs to

% author@mhrex(Hao MA) Nov.14,2014

a = source(1);
b = source(2);
c = source(3);

DIFF = 1e-12;
if(abs(diff([a,0]))<=DIFF)
    X='south';
elseif (abs(diff([a,L]))<=DIFF)
    X='north';
elseif (abs(diff([b,0]))<=DIFF)
    X='east';
elseif (abs(diff([b,W]))<=DIFF)
    X='west';
elseif (abs(diff([c,0]))<=DIFF)
    X='floor';
elseif (abs(diff([c,H]))<=DIFF)
    X='ceiling';
end
