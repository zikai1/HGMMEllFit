%-------------------------------------------------------------
%     HGMM_MAKE compiles several HGMM cpp functions

%     This file is part of the HGMM package.
%
% 
%     HGMM package is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%--------------------------------------------------------------


function HGMM_make()

psave=pwd; 
p = mfilename('fullpath'); 
[pathstr, ~, ~] = fileparts(p);

%%%%%%%%%%%%%%%%%%%% HGMM-mex %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Compiling HGMM-mex functions...');
disp('If this is the first time you use mex, it will ask you to choose a compiler.');
disp('Just choose the matlab default one (usually option #1).');
cd (pathstr); 
cd HGMM_make;

try
    mex mexGaussTransformForEllipse.cpp;
    mex point_density.cpp;
catch
   disp('Compilation of HGMM mex functions failed. Try to run mex -setup to adjust your compiler.');
    
end

cd(psave);