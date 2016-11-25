% Constraints.m
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

function[K_c,F_c,nctot]=Constraints(nc,K,F)

nctot=zeros(1,numel(nc)*3);

for i=1:numel(nc)
    nctot(i*3-2:i*3)=[nc(i)*3-2 nc(i)*3-1 nc(i)*3];
end

K(nctot,:)=[];
K(:,nctot)=[];
K_c=K;

F(nctot)=[];
F_c=F;
return