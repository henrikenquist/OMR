function [SRC_aligned P fval] = omr_realign(SRC, REF, TGT, XY, page)    
%%
% Copyright Universita di Trento, Italy, and Centre National de la 
% Recherche Scientifique, France : Mateus Joffily, 2007 and 2017.
%
% mateusjoffily@gmail.com

% This software is a computer program whose purpose is to perform optical 
% mark recognition (OMR).

% This software is governed by the CeCILL  license under French law and
% abiding by the rules of distribution of free software.  You can  use, 
% modify and/ or redistribute the software under the terms of the CeCILL
% license as circulated by CEA, CNRS and INRIA at the following URL
% "http://www.cecill.info". 
%
% As a counterpart to the access to the source code and  rights to copy,
% modify and redistribute granted by the license, users are provided only
% with a limited warranty  and the software's author,  the holder of the
% economic rights,  and the successive licensors  have only  limited
% liability. 
%
% In this respect, the user's attention is drawn to the risks associated
% with loading,  using,  modifying and/or developing or reproducing the
% software by the user in light of its specific status of free software,
% that may mean  that it is complicated to manipulate,  and  that  also
% therefore means  that it is reserved for developers  and  experienced
% professionals having in-depth computer knowledge. Users are therefore
% encouraged to load and test the software's suitability as regards their
% requirements in conditions enabling the security of their systems and/or 
% data to be ensured and,  more generally, to use and operate it in the 
% same conditions as regards security.
%
% The fact that you are presently reading this means that you have had
% knowledge of the CeCILL license and that you accept its terms.%%
%%

% Set initial values for transformation
%----------------------------------------------------
%P0      = [0 0 0 1 1];          % with scalling
P0      = [0 0 0];              % without scalling

% mask region outside target area
nTGT = cast(~TGT,class(TGT));
cREF = REF .* nTGT + TGT;
cSRC = SRC .* nTGT + TGT;

% Find transformation to align image
%----------------------------------------------------
options      = optimset('Display','iter', 'TolFun', 10^-3, 'TolX', 10^-3);
[P, fval, e] = fminsearch('omr_transform', P0, options, cREF, cSRC, XY);

% Realign image using optimized parameters
%----------------------------------------------------
A            = omr_matrix(P);
Tform        = maketform('affine', A');
SRC_aligned  = omr_imtransform(SRC, Tform, XY);

end