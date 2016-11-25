% FEM.m
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

%%%%%%%%%%%% FEM %%%%%%%%%%%%%%%
clear all;close all;clc

%---------------------GEOMETRY-----------------------
fprintf('------GEOMETRY------\n\n');

fprintf('Inserisci le dimensioni della piastra\n');
a=input('Lunghezza in x: ');
b=input('Lunghezza in y: ');


%---------------------MESH---------------------------
fprintf('\n------MESH------\n\n');

ex=input('Numeri di elementi in x: ');
ey=input('Numeri di elementi in y: ');

mesh=MeshGenerator(a,b,ex,ey);


%---------------------ELEMENT------------------------
fprintf('\n------ELEMENT------\n\n');
fprintf('Elementi diponibili:\n1. Q4\n2. Q8\n3. Q9\n');
typeElem=input('Che tipo di elemento vuoi? ');

if typeElem==1
    ShapeOption='Q4';
    quadrature=GaussQuadrature('gauss2');
elseif typeElem==2
    ShapeOption='Q8';
    quadrature=GaussQuadrature('gauss3');
elseif typeElem==3
    ShapeOption='Q9';
    quadrature=GaussQuadrature('gauss3');
end


%---------------------MATERIAL------------------------
fprintf('\n------MATERIAL------\n\n');
fprintf('Matriali disponibili:\n1. Al\n');
typeMat=input('Che materiale vuoi? ');

if typeMat==1
    material=MaterialProperty('Al');
end
K=StiffnessMatrix(material,mesh,quadrature,ShapeOption);


%---------------------LOADS----------------------------
fprintf('\n------LOADS------\n\n');
fprintf('Opzioni disponbili:\n');
fprintf('1.Carico distribuito su tutta la piastra\n');
fprintf('2.Carico concentrato su un lato\n');
loads=input('Che tipologia di carico vuoi? ');

switch loads
    case 1
        p0=input('\nIntensita del carico distribuito: ');
        F=ForceVector(mesh,quadrature,ShapeOption,p0);
    case 2
        c0=input('\nIntensita del carico concentrato: ');
        cl=input('\nLato da caricare: ');
        F=ForceVector(cl,c0,mesh);
end


%---------------------CONSTRAINTS-----------------------
fprintf('\n------CONSTRAINTS------\n\n');
fprintf('Opzioni di vincolo:\n');
fprintf('1.Simply Supported\n');
vincolo=input('Che tipo di vincolo vuoi? ');

switch vincolo
    case 1
        nc=[mesh.lato1 mesh.lato2(2:end) mesh.lato3(2:end) mesh.lato4(2:end-1)];
end

[K_c,F_c,nctot]=Constraints(nc,K,F);


%---------------------SOLUTION---------------------------
w=StaticSolver(K_c,F_c,mesh,nctot);

%---------------------PLOT-------------------------------
figure
surf(mesh.x(1,:),mesh.y(:,1),reshape(w,size(mesh.x,2),size(mesh.x,1))');
axis equal
hold on
title('Deformed geometry')
% for i=1:numel(mesh.x)
%     text(mesh.cordinates(i,1),mesh.cordinates(i,2),w(i),num2str(w(i)));
% end

%-------------------MODAL ANALYSIS--------------------
M=MassMatrix(material,mesh,quadrature,ShapeOption);
numberMode=5;
[V,D]=eigs(M\K,numberMode,'sm');
scal=0.5;
for i=1:numberMode
    figure
    surf(mesh.x,mesh.y,reshape(V(1:3:end,i),size(mesh.x,2),size(mesh.x,1))');
end