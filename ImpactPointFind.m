function [ImpactPoint, t, wall, wallvector]=ImpactPointFind(Source,Ray,L,W,H)
% find the new impact point

% author@mhrex(Hao MA) Nov.14,2014

c = physconst('LightSpeed');

while(1)
    
    % north wall
    n_surface = [1,0,0];
    temp = dot(n_surface,Ray);
    if (temp>0)
        d = L-Source(1);
        k = d/temp;
        impact_temp=Source+k*Ray;
        if ((impact_temp(2)<=W) && (impact_temp(2)>=0) && (impact_temp(3)<=H) && (impact_temp(3)>=0))
            ImpactPoint = impact_temp;
            t=k/c;
            wall = 'north';
            wallvector = [-1,0,0];
            break;
        end
    end
    
    % south wall
    n_surface = [-1,0,0];
    temp = dot(n_surface,Ray);
    if (temp>0)
        d = Source(1);
        k = d/temp;
        impact_temp=Source+k*Ray;
        if ((impact_temp(2)<=W) && (impact_temp(2)>=0) && (impact_temp(3)<=H) && (impact_temp(3)>=0))
            ImpactPoint = impact_temp;
            t=k/c;
            wall = 'south';
            wallvector = [1,0,0];
            break;
        end
    end
    
    % west wall
    n_surface = [0,1,0];
    temp = dot(n_surface,Ray);
    if (temp>0)
        d = W-Source(2);
        k = d/temp;
        impact_temp=Source+k*Ray;
        if ((impact_temp(1)<=L) && (impact_temp(1)>=0) && (impact_temp(3)<=H) && (impact_temp(3)>=0))
            ImpactPoint = impact_temp;
            t=k/c;
            wall = 'west';
            wallvector = [0,-1,0];
            break;
        end
    end
    
    % east wall
    n_surface = [0,-1,0];
    temp = dot(n_surface,Ray);
    if (temp>0)
        d = Source(2);
        k = d/temp;
        impact_temp=Source+k*Ray;
        if ((impact_temp(1)<=L) && (impact_temp(1)>=0) && (impact_temp(3)<=H) && (impact_temp(3)>=0))
            ImpactPoint = impact_temp;
            t=k/c;
            wall = 'east';
            wallvector = [0,1,0];
            break;
        end
    end
    
    % ceiling wall
    n_surface = [0,0,1];
    temp = dot(n_surface,Ray);
    if (temp>0)
        d = H-Source(3);
        k = d/temp;
        impact_temp=Source+k*Ray;
        if ((impact_temp(1)<=L) && (impact_temp(1)>=0) && (impact_temp(2)<=W) && (impact_temp(2)>=0))
            ImpactPoint = impact_temp;
            t=k/c;
            wall = 'ceiling';
            wallvector = [0,0,-1];
            break;
        end
    end
    
    % floor wall
    n_surface = [0,0,-1];
    temp = dot(n_surface,Ray);
    if (temp>0)
        d = Source(3);
        k = d/temp;
        impact_temp=Source+k*Ray;
        if ((impact_temp(1)<=L) && (impact_temp(1)>=0) && (impact_temp(2)<=W) && (impact_temp(2)>=0))
            ImpactPoint = impact_temp;
            t=k/c;
            wall = 'floor';
            wallvector = [0,0,1];
            break;
        end
    end
    
end
