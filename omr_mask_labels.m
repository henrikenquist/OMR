function BLOBS = omr_mask_labels(MSK, dispOK)
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

if nargin < 2
    % Display BLOBS and their labels
    dispOK = true;
end

% If MSK is a string, load image
if ischar(MSK)
    [MSK map] = imread(MSK);            % mask image
    MSK = omr_adjust_image(MSK, map);   % convert to intensity image and scale
end

% Locate blobs in mask and label them
[BLOBS, N] = bwlabel(~MSK);   % N = number of blobs found

if dispOK
    figure
    imshow(BLOBS);
    for k = 1:N
        % Calculate blob's center of gravity
        [i j] = find(BLOBS == k);
        cog   = mean([i j])';
        t     = text(cog(2), cog(1), num2str(k));
        set(t, 'Color', 'r', 'FontWeight', 'bold');
    end
end

end