% MeshGenerator.m
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

function[mesh]=MeshGenerator(a,b,ex,ey)
% Define grid
% ...

mesh=struct();

nx=ex+1; ny=ey+1;
mesh.ne=ex*ey; mesh.nn=nx*ny;

dx=a/ex; dy=b/ey;

[mesh.x,mesh.y]=meshgrid(0:dx:a,0:dy:b);
mesh.cordinates(:,1)=reshape(mesh.x',numel(mesh.x),1);
mesh.cordinates(:,2)=reshape(mesh.y',numel(mesh.y),1);

% lato 1
mesh.lato1=1:nx;
% lato 2
mesh.lato2=nx:nx:mesh.nn;
% lato 3
mesh.lato3=mesh.nn:-1:mesh.nn-ex;
% lato 4
mesh.lato4=mesh.nn-ex:-nx:1;

mesh.Nid=zeros(mesh.nn,4);
mesh.Eid=zeros(mesh.ne,5);

for j=1:ny
    for i=1:nx
        mesh.Nid(i+nx*(j-1),:)=[i+nx*(j-1), (i-1)*dx, (j-1)*dy, 0];
    end
end

%% Elements ID - 1n - right - up - left
for j=1:ey
    for i=1:ex
        mesh.Eid(i+ex*(j-1),:)=[i+ex*(j-1), i+nx*(j-1)...
                           i+nx*(j-1)+1 i+nx*(j-1)+nx+1 i+nx*(j-1)+nx];
    end
end

figure
surf(mesh.x,mesh.y,zeros(size(mesh.x)));
hold on
axis equal
title('Undeformed Geometry');


for i=1:numel(mesh.x)
    text(mesh.cordinates(i,1),mesh.cordinates(i,2),0,num2str(i));
end

return