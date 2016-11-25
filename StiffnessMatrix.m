% StiffnessMatrix.m
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

function[K]=StiffnessMatrix(material,mesh,quadrature,ShapeOption)
% ...

K=zeros(mesh.nn*3);

D_f=material.E/(1-material.v^2).*[1 material.v 0 
                                  material.v 1 0 
                                  0 0 (1-material.v)/2];
            
D_t=[material.G 0
     0 material.G];
 
alpha=5/6;
beta=material.t^3/12;

if strcmp(ShapeOption,'Q4')
    shape_order=4;
elseif strcmp(ShapeOption,'Q8')
    shape_order=8;
elseif strcmp(ShapeOption,'Q9')
    shape_order=9;
end

for iel=1:mesh.ne
    KElem=zeros(shape_order*3);
    for ig=1:size(quadrature.points,1)
        shapeFunction=ShapeFunction(quadrature.points(ig,1),quadrature.points(ig,2),ShapeOption);
        elemCoordinates=[mesh.Nid(mesh.Eid(iel,2:end),2), mesh.Nid(mesh.Eid(iel,2:end),3)];
        jacobian=Jacobian(shapeFunction,elemCoordinates);
        Nd=jacobian.globalDerivatives;
        
        B_f=zeros(3,shape_order*3);
        B_t=zeros(2,shape_order*3);

        for ib=1:shape_order
            temp=[0 Nd(ib,1) 0
                  0 0 Nd(ib,2)
                  0 Nd(ib,2) Nd(ib,1)];
            B_f(:,ib*3-2:ib*3)=temp;
    
            temp=[Nd(ib,1) shapeFunction.fun(ib) 0
                  Nd(ib,2) 0 shapeFunction.fun(ib)];
            B_t(:,ib*3-2:ib*3)=temp;  
        end
        KElem=KElem+quadrature.weights(ig)*(beta*B_f'*D_f*B_f+alpha*B_t'*D_t*B_t)*det(jacobian.matrix);
    end
    ntot=mesh.Eid(iel,2:end)*3-2;
    
    for j=1:numel(ntot)
        for k=1:numel(ntot)
            K(ntot(j):ntot(j)+2,ntot(k):ntot(k)+2) = K(ntot(j):ntot(j)+2,ntot(k):ntot(k)+2) + KElem(j*3-2:j*3,k*3-2:k*3);
        end
    end
    
end
return