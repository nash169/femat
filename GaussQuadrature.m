% GaussQuadrature.m
%
% This file is part of FEMAT.
% Copyright (C) 2013 Bernardo Fichera
%
% FEMAT is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% FEMAT is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with FEMAT.  If not, see <http://www.gnu.org/licenses/>.

function[quadrature]=GaussQuadrature(GaussOption)
% Compute the Gauss Point with their weights
% Case 1: Quad 1x1
% Case 2: Quad 2x2
% Case 3: Quad 3x3
% Gauss points are automatically chosen relative to shape function

quadrature=struct();

switch GaussOption
    case 'gauss1'
        quadrature.points=[0 0];
        
        quadrature.weights=4;
        
    case 'gauss2'
        quadrature.points=[...
            -1/sqrt(3) -1/sqrt(3)
             1/sqrt(3) -1/sqrt(3)
             1/sqrt(3)  1/sqrt(3)
            -1/sqrt(3)  1/sqrt(3)];
        
        quadrature.weights=ones(size(quadrature.points,1),1);
        
    case 'gauss3'
        quadrature.points=[...
                    0           0
             sqrt(3/5)  sqrt(3/5)
            -sqrt(3/5)  sqrt(3/5)
            -sqrt(3/5) -sqrt(3/5)
             sqrt(3/5) -sqrt(3/5)
                     0  sqrt(3/5)
            -sqrt(3/5)         0
                     0 -sqrt(3/5)
             sqrt(3/5)         0];
         
         quadrature.weights=[...
             64/81
             25/81
             25/81
             25/81
             25/81
             40/81
             40/81
             40/81
             40/81];
end

figure
grid on, hold on
scatter(quadrature.points(:,1),quadrature.points(:,2),'*');
axis([-1 1 -1 1]);

for i=1:size(quadrature.points,1)
    text(quadrature.points(i,1),quadrature.points(i,2)+0.1,num2str(i),'FontSize',14);
end

return