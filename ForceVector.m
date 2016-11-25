% ForceVector.m
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

function[F]=ForceVector(mesh,quadrature,ShapeOption,p0)
%....

if nargin==4 
    F=zeros(mesh.nn*3,1);

    for iel=1:mesh.ne
        FElem=zeros(12,1);
        for ig=1:size(quadrature.points,1)
            shapeFunction=ShapeFunction(quadrature.points(ig,1),quadrature.points(ig,2),ShapeOption);
            elemCoordinates=[mesh.Nid(mesh.Eid(iel,2:end),2), mesh.Nid(mesh.Eid(iel,2:end),3)];
            jacobian=Jacobian(shapeFunction,elemCoordinates);

            for ib=1:4
                temp=[shapeFunction.fun(ib) 0 0];
                N(:,ib*3-2:ib*3)=temp;
            end
        
            FElem=FElem+quadrature.weights(ig)*(N'*p0)*det(jacobian.matrix);
        end
    
        ntot=mesh.Eid(iel,2:end)*3-2;
    
        for j=1:numel(ntot)
            F(ntot(j):ntot(j)+2)=F(ntot(j):ntot(j)+2)+FElem(j*3-2:j*3);
        end 
    end

elseif nargin==3
    switch cl
        case 1
            nl=mesh.lato(1,:);
        case 2
            nl=mesh.lato(2,:);
        case 3
            nl=mesh.lato(3,:);
        case 4
            nl=mesh.lato(4,:);
    end
    
    F=zeros(mesh.nn*3,1);
    for i=nl
        F(3*i-2)=F(3*i-2)+c0;
    end
end
return