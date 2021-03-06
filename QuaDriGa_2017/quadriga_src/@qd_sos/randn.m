function [ s, h_sos ] = randn( dist_decorr, coord )
%RANDN Generates normal distributed spatially correlated random numbers
%
% Input:
%   dist_decorr     Vector of decorrelation distances  [1 x M] or [ M x 1 ]
%   coord           List of 3D positions [ 3 x N ]
%   
% Output:
%   s               Random correlated numbers [ M x N ]
%   h_sos           SOS objects used to generate the numbers
% 
% QuaDRiGa Copyright (C) 2017 Fraunhofer Heinrich Hertz Institute
% e-mail: quadriga@hhi.fraunhofer.de
%
% QuaDRiGa is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published
% by the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.

s = zeros( numel( dist_decorr ), size(coord,2) );
h_sos = qd_sos([]);

for n = 1 : numel( dist_decorr )
    if dist_decorr(n) == 0
        dist_decorr(n) = 0.1;
    end
    h_sos(1,n) = qd_sos( dist_decorr(n) );
    s(n,:) = h_sos(1,n).val( coord );
end

end
