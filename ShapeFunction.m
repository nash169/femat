% ShapeFunction.m
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

function[shapeFunction]=ShapeFunction(xi,eta,ShapeOption)
% Database of shape functions and their natural derivatives (xi,eta)
% 'quad1': 4 nodes
% 'quad2': 8 nodes
% 'quad3': 9 nodes

shapeFunction=struct();

switch ShapeOption
    
    case 'Q4'
        shapeFunction.fun=1/4*[(1-xi)*(1-eta)
                               (1+xi)*(1-eta)
                               (1+xi)*(1+eta)
                               (1-xi)*(1+eta)];
                           
        shapeFunction.dfun=1/4*[-(1-eta),-(1-xi)
                                1-eta,-(1+xi)
                                1+eta,1+xi
                                -(1+eta),1-xi];
                            
    case 'Q8'
        shapeFunction.fun=[1/4*xi*(1-xi)*eta*(1-eta)
                           -1/2*xi*(1-xi)*(1+eta)*(1-eta)
                           -1/4*xi*(1-xi)*eta*(1+eta)
                           1/2*(1+xi)*(1-xi)*(1+eta)*eta
                           1/4*xi*(1+xi)*eta*(1+eta)
                           1/2*xi*(1+xi)*(1+eta)*(1-eta)
                           -1/4*xi*(1+xi)*eta*(1-eta)
                           -1/2*(1+xi)*(1-xi)*(1-eta)*eta];
                       
       shapeFunction.dfun=[...
           1/4*eta*(-1+eta)*(-1+2*xi)      1/4*xi*(-1+xi)*(-1+2*eta)
      -1/2*(1+eta)*(-1+eta)*(-1+2*xi)                -xi*(-1+xi)*eta
            1/4*eta*(1+eta)*(-1+2*xi)       1/4*xi*(-1+xi)*(1+2*eta)
                      -xi*eta*(1+eta)  -1/2*(1+xi)*(-1+xi)*(1+2*eta)
             1/4*eta*(1+eta)*(1+2*xi)        1/4*xi*(1+xi)*(1+2*eta)
       -1/2*(1+eta)*(-1+eta)*(1+2*xi)                 -xi*(1+xi)*eta
            1/4*eta*(-1+eta)*(1+2*xi)       1/4*xi*(1+xi)*(-1+2*eta)
                     -xi*eta*(-1+eta) -1/2*(1+xi)*(-1+xi)*(-1+2*eta)];
                       
    case 'Q9'
        error('work in progress');
end

return 