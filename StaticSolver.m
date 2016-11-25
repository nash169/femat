% StaticSolver.m
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

function[w]=StaticSolver(K_c,F_c,mesh,nctot)

s=K_c\F_c;
index=1:mesh.nn*3;
q=zeros(mesh.nn*3,1);
index(nctot)=[];

for i=1:numel(index)
    q(index(i))=s(i);
end

w=q(1:3:end);
return